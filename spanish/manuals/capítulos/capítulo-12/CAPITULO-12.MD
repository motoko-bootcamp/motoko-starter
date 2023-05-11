# Capítulo 12: Actualización de un canister.
Actualizar un canister es una tarea común. Sin embargo, hay algunas cosas que se deben considerar antes de hacerlo, en particular:
- ¿Podría la actualización causar pérdida de datos?
- ¿Podría la actualización romper la dApp debido a cambios en la interfaz?
## Memoria estable vs memoria heap.
Un canister tiene acceso a dos tipos de memorias:
1. Un heap wasm que está limitado a 4 GiB porque actualmente el tiempo de ejecución de canisters [wasmtime](https://github.com/bytecodealliance/wasmtime) solo tiene direccionamiento de 32 bits. Este límite aumentará cuando se admita [wasm64](https://github.com/WebAssembly/memory64) en el tiempo de ejecución. El heap es una "pila" de memoria, es el espacio disponible para que el canister lo asigne y desasigne según sea necesario. El heap se borra durante las actualizaciones. El heap es la memoria más rápida disponible para el canister.

2. Una [memoria estable](https://internetcomputer.org/docs/current/references/ic-interface-spec#system-api-stable-memory) que actualmente puede almacenar hasta 48GiB de almacenamiento. Todo en la memoria estable sobrevivirá a las actualizaciones. Acceder a los datos en la memoria estable es más lento en comparación con acceder a la memoria en el heap porque la memoria estable no es directamente accesible dentro del entorno de tiempo de ejecución. En su lugar, acceder a la memoria estable requiere llamar a una API externa.

> Los desarrolladores que son nuevos en el IC a menudo hacen la pregunta: ¿qué memoria debo usar? Desafortunadamente, no hay una respuesta universal a esta pregunta. La elección óptima depende de los requisitos de su aplicación (seguridad durante la actualización frente a rendimiento) y la cantidad de memoria que necesitará. Si está interesado, [lea y únase a la discusión sobre este tema que está en constante evolución](https://forum.dfinity.org/t/motoko-stable-memory-in-2022/10433).

## Tipos estables.
Desafortunadamente, no todos los variables se pueden declarar como estables.
```motoko
stable var m : Int = 0;
```
El valor de `m` persistirá después de una actualización y no se perderá. 
Una variable estable se almacena en la memoria estable.

## Tipos estables.
Desafortunadamente, no todas las variables se pueden declarar como estables.
```motoko
stable let map = HashMap.HashMap<Principal, Student>(1, Principal.equal, Principal.hash);
```
Si intentamos utilizar el tipo `HashMap` que hemos visto anteriormente, nos encontraremos con un error: `la variable map se declara como estable pero tiene un tipo no estable`.

Todos los tipos primitivos son estables:
- `Nat` 
- `Text`
- `Ìnt`
- All bounded numbers: `Nat8`, `Nat16`, `Nat32`, `Nat64`, `Int8`, `Int16`, `Int32`, `Int64`.
- `Float`
- `Char`
- `Bool`
- `Array`

Un objeto que contiene métodos (es decir, una clase) no puede ser estable. Es por eso que `HashMap` y `TrieMap` no se pueden declarar como estructuras estables.

> Es posible reescribir algunas bibliotecas para convertirlas en tipos estables. Por ejemplo, [StableBuffer](https://github.com/canscale/StableBuffer) es una nueva versión del tipo `Buffer` que permite que se llame estable.

## Cambios de interfaz.
Otro desafío al actualizar un canister en un entorno distribuido como Internet Computer es que otros canisters pueden depender de la interfaz del canister que se está actualizando.

Imaginemos que tenemos dos canisters:
1. Canister A es el canister que queremos actualizar. Contiene muchas funciones públicas, pero nos centraremos solo en `getDiploma`.
```motoko
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Time "mo:base/Time";
actor School {

    type Diploma = {
        delivery_time : Time.Time;
        teacher : Principal;
        promotion : Nat;
    };

    let diplomas = HashMap.HashMap<Principal, HashMap>(0, Principal.equal, Principal.hash);

    public func getDiploma(p : Principal) : async ?Diploma {
        return diplomas.get(p);
    };

};
```

2. Canister B es el canister cliente que depende de la interfaz de Canister A. Debemos imaginar que en algún lugar del código de Canister B se llama a la función `getDiploma` de Canister A.
```motoko
actor dApp {
    type Diploma = {
        delivery_time : Time.Time;
        teacher : Principal;
        promotion : Nat;
    };

    // We define the other canister in the code here.
    let schoolActor : actor {
        getDiploma(p : Principal) -> async ?Diploma;
    } =  actor("<Can-Id>"); 

    public func shared ({ caller }) isAuthorized() :  async Bool {
        let answer = await schoolActor.getDiploma(caller);
        switch(answer){
            case(null){
                return false;
            };
            case(? some){
                return true;
            };
        };
    };
};
```
Supongamos que estamos actualizando el canister A y decidimos eliminar la función `getDiploma`. Si hacemos eso, causará problemas para el canister B porque depende de esa función. Pero no es solo eliminar la función lo que podría causar problemas. Si modificamos la firma de la función a algo como esto:
```motoko
getDiploma(p : Principal) -> async Result.Result<Diploma, Text>;
```
Ese cambio solo también rompería el código del canister B.
Cada vez que se actualiza un canister en el IC, representa un riesgo para todos los canisters que dependen de él, ¡tenemos que encontrar una forma de no romper las cosas! <br/>

¡Ahí es donde entra en juego la magia de **Candid**! <br/> 
Candid define un formalismo y reglas precisas para asegurarse de que cualquier modificación de la interfaz (añadir nuevos métodos, cambiar las firmas de las funciones, esperar argumentos adicionales...) no rompa los clientes existentes.

Por ejemplo, evolucionando la firma de la función `getDiploma` desde
```motoko
getDiploma(p : Principal) -> async ?Diploma;
```
hasta
```motoko
getDiploma(p : Principal, bootcampYear: ?Nat) -> async ?Diploma;
```
No causaría un problema, cuando se leen mensajes de clientes antiguos que no pasan ese argumento, se asume un valor `null`.

> En lo siguiente, todos los tipos e interfaces se expresan en formato Candid.

Veamos más ejemplos de lo que se puede y no se puede hacer. Imagina el siguiente servicio
```
service counter : {
  add : (nat) -> ();
  subtract : (nat) -> ();
  get : () -> (int) query;
}
```
La función `add` podría evolucionar desde
```
add : (nat) -> ();
```
hasta
```
add : (int) -> ();
```
Esto es posible porque cada `nat` también es un `int`. Si un cliente proporciona un `Nat`, será compatible con el nuevo tipo esperado. Decimos que `int` es un supertipo de `nat`. Sin embargo, evolucionar en la dirección opuesta no sería posible ya que no todos los `int` son `nat`.

Además, la función `add` y `substract` podrían evolucionar desde
```
add : (nat) -> ();
subtract : (nat) -> ();
```
hasta
```
add : (nat) -> (new_val : nat);
subtract : (nat) -> (new_val : nat);
```
Esto es posible porque cualquier nuevo valor devuelto que no se espere por los clientes antiguos simplemente se ignorará. Sin embargo, no sería posible agregar nuevos parámetros (no opcionales).

Para actualizar un canister de manera segura, siga estas reglas:
- Se pueden agregar nuevos métodos libremente.
- Los métodos existentes pueden devolver valores adicionales. Los clientes antiguos simplemente ignorarán los valores adicionales.
- Los métodos existentes pueden acortar su lista de parámetros. Los clientes antiguos enviarán el argumento(s) adicional(es), pero se ignorarán.
- Los métodos existentes solo pueden agregar tipos opcionales (`opt`) como nuevos parámetros. Cuando se leen mensajes de clientes antiguos que no pasan ese argumento, se asume un valor `null`.
- Los tipos de parámetros existentes se pueden cambiar, pero solo a un `supertipo` del tipo anterior. Por ejemplo, un parámetro `nat` se puede cambiar a un `int`.
- Los tipos de resultados existentes se pueden cambiar, pero solo a un `subtipo` del tipo anterior. Por ejemplo, un resultado `int` se puede cambiar a un `nat`.

> Si desea obtener más información sobre Candid, los supertipos y los subtipos, consulte la [guía de referencia](https://internetcomputer.org/docs/current/references/candid-ref).
## Cambios en la estructura de datos.
Otro ejemplo de cómo se puede perder datos es mediante el cambio de tipos de datos.

```motoko
stable var state : Int
```
En este ejemplo, la variable `state` es un `Int`, pero imaginemos que durante una actualización el tipo se cambia a `Text`.
```motoko
stable var state : Text
```
En este caso, el valor actual de `Int` se perderá. Una forma de evitar la pérdida de datos al cambiar los tipos de datos es mantener la variable original y crear una nueva variable para el nuevo tipo de datos. De esta manera, los datos originales no se perderán debido a las actualizaciones del canister.

## Firma de tipo estable.
La lista de todas las variables estables de un actor se llama **firma estable**. La representación textual de la **firma estable** se parece a una declaración de actor.
```motoko
actor {
  stable x : Nat;
  stable var y : Int;
  stable z : [var Nat];
};
```
> La firma estable de un actor se puede generar utilizando el compilador Motoko: [moc](https://internetcomputer.org/docs/current/motoko/main/compiler-ref).

La firma estable se utiliza para verificar automáticamente la compatibilidad de tipos antes de una actualización. Esto es posible comparando la firma del nuevo actor con la antigua y utilizando algunas reglas basadas en Candid. Para obtener más información, consulte la [sección de referencia sobre firmas estables](https://internetcomputer.org/docs/current/motoko/main/upgrades#stable-type-signatures).
## Sección de metadatos.
El compilador Motoko incrusta la **interfaz Candid** y la **firma estable** de un canister como metadatos, registrados en secciones personalizadas adicionales de Wasm de un binario compilado.

Estos metadatos se pueden exponer selectivamente por el IC y se pueden utilizar herramientas como `dfx` para verificar la actualización.
```
$ dfx canister metadata [OPTIONS] <CANISTER_NAME> <METADATA_NAME>
```
## Verificación de compatibilidad de actualización
Al actualizar un canister, `dfx` descargará automáticamente los metadatos del módulo antiguo y los comparará con el nuevo módulo:
- Compara la interfaz Candid para asegurarse de que no haya cambios que rompan la compatibilidad.
- Compara las firmas estables para asegurarse de que no se perderán datos.

Si está realizando un cambio que rompe la compatibilidad, recibirá una advertencia.

<p align="center"> <img src="assets/candid_warning.png" width="800px" style="border: 2px solid black;"></p>
<p align="center"> El tipo de advertencia que encontrará. </p>

Esta verificación no garantiza que la actualización se llevará a cabo. Todavía puede haber problemas durante el proceso de actualización. Sin embargo, garantiza que si la actualización se lleva a cabo, no romperá los clientes existentes ni perderá datos que se hayan marcado como `stable`.
