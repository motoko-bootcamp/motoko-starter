# Capítulo 8: Tipos avanzados.
## ❓ Tipos opcionales
En Motoko, al igual que en muchos otros lenguajes de programación, hay un valor especial llamado `null` que se utiliza para representar la ausencia de un resultado. Esto es útil cuando se indica que una función no devuelve nada. El valor `null` es del tipo `Null`, que solo contiene un valor: `null`.

Considera un arreglo de nombres llamado `names` y una función llamada `find_name` que toma una lista de nombres como entrada y devuelve el índice de la primera aparición del nombre en el arreglo. Si no se encuentra el nombre, la función debe devolver `null` en lugar de un índice. De esta manera, la función indica que no encontró el nombre sin producir un error.

El siguiente código no es válido en Motoko:

```motoko
let names : [Text] = ["Motoko", "Rust", "JavaScript", "TypeScript"];
public func find_name(name : Text) : async Nat {
    var index : Nat = 0;
    for(language in names.vals()){
        if (language == name){
            return index;
        };
        index +=1;
    };
    return null; // We haven't found any match so we return null.
};
````
Motoko lanza un error porque `null` no es del tipo `Nat`. Para indicar que una función puede devolver un valor `Nat` o `null`, necesitamos una forma de expresar que el tipo de retorno de la función puede ser una de dos posibilidades. El valor de retorno específico de la función depende de la entrada, que es desconocida de antemano, por lo que no podemos predecir si la función devolverá un `Nat` o un `null` hasta que se ejecute.

Podemos usar un tipo opcional, `?T`, para expresar esto. En nuestro caso, usaríamos `?Nat`. Podemos reescribir nuestro código usando esta notación:
```motoko
let names : [Text] = ["Motoko", "Rust", "JavaScript", "TypeScript"];
public func find_name(name : Text) : async ?Nat {
    var index : Nat = 0;
    for(language in names.vals()){
        if (language == name){
            return ?index;
        };
        index +=1;
    };
    return null; // We haven't found any match so we return null.
};
```

El tipo opcional, indicado por `?`, se puede usar con cualquier otro tipo, como `?Text`, `?Int`, `?Bool`, y más.

Además, el tipo opcional se usa a menudo con el patrón `switch/case` en Motoko. Este patrón te permite manejar un valor opcional y ejecutar diferentes partes de tu código dependiendo de si el valor de entrada es `null` o no. Puedes usar el patrón `switch/case` para verificar si un valor opcional está presente y realizar diferentes acciones en función de eso, lo que resulta en un código más elegante y seguro.
```motoko
public func handle_null_value(n : ?Nat) : async Text {
    switch(n) {
        // Check if n is null 
        case(null){
            return ("The argument is null"); 
        };
        case(? something){
            return ("The argument is : " # Nat.toText(something));
        };
    };
};
```
Por último, la biblioteca Base proporciona un módulo **Option** para operar con valores opcionales. Por ejemplo, puedes usar la función `Option.get()` para desempaquetar un valor opcional con un valor predeterminado:
```motoko
import Option "mo:base/Option";
actor {
    public func always_return_a_nat(n : ?Nat) : async Nat {
        return(Option.get(n, 0))
    };
}
```
Esta función toma un valor `?Nat` como entrada y devuelve un `Nat`. Si proporcionas un valor `Nat` como entrada, devolverá el mismo valor. Sin embargo, si proporcionas `null`, devolverá el valor predeterminado, establecido en 0.
## 👤 Tipo genérico
Un tipo genérico, generalmente escrito como `T`, te permite escribir funciones y código que pueden adaptarse a diferentes tipos. Cuando hablamos de `T`, se refiere a **cualquier tipo que desees**. Esto significa que puedes crear una sola función o clase que pueda manejar varios tipos de entradas o datos, sin tener que escribir un código separado para cada tipo.

Imaginemos que tenemos una tarea por delante: determinar si el tamaño de un arreglo es par o no. Vamos a escribir una función llamada `isArrayEven` que toma un arreglo como entrada y devuelve un valor `Bool` que indica si el tamaño de ese arreglo es par o no.
```motoko
public func isArrayEven(array : [Nat]) : async Bool {
    let size = array.size();
    if(size % 2 == 0){
        return true;
    } else {
        return false;
    };
};
```
Esta función funciona como se pretende, pero está limitada a arreglos llenos de `Nat`. Entonces, ¿qué pasa si queremos verificar el tamaño de un arreglo lleno de `Text` o `Int`? <br>
Un enfoque sería crear una función separada para cada tipo posible:
- `isArrayEvenNat`
- `isArrayEvenText`
- `isArrayEvenInt`

Como puedes imaginar, esto rápidamente se vuelve difícil de manejar y mantener. Una solución mejor es utilizar el poder de los genéricos. Con los genéricos, podemos escribir una sola función que funcione para cualquier tipo de arreglo. Es una forma más elegante y eficiente de resolver el problema. ¡Así que abracemos a nuestro nuevo amigo - los genéricos - y hagamos que nuestro código sea más dinámico y flexible!
```motoko
func isArrayEven<T>(array : [T]) : Bool {
    let size = array.size();
    if(size % 2 == 0){
        return true;
    } else {
        return false;
    };
};
```
Observa `<T>` después del nombre de la función. Significa que esta función ahora depende del tipo de `T`. Necesitamos especificar el tipo de `T` cuando queremos usar la función.
```motoko
let array : [Nat] = [1,2,3,4];
let bool : Boolean = isArrayEvent<Nat>(array); // Replace T with the actual type when you use the function. 
```

Ya hemos utilizado genéricos al trabajar con `Buffer` y `Array` sin mencionarlo.
- El tipo `Buffer<T>` es una clase genérica y necesitamos proporcionar un tipo al crear un nuevo búfer.
    ```motoko
    let b = Buffer.Buffer<Nat>(2);
    ```

- `Array.append<T>` es una función genérica y necesitamos proporcionar el tipo de los elementos de los arreglos que estamos concatenando.
    ```motoko
    let array1 = [1, 2, 3];
    let array2 = [4, 5, 6];
    Array.append<Nat>(array1, array2) // [1, 2, 3, 4, 5, 6];
    ```
## 🤫 Tipos compartidos
Cuando se envía o recibe información desde un `actor` en Motoko, se utilizan tipos de datos específicos llamados **tipos compartidos**. Estos **tipos compartidos** se utilizan en funciones `públicas` que pueden ser accedidas por otros actores. Por lo tanto, los **tipos compartidos** son los tipos de datos que se pueden usar como entrada o salida para estas funciones públicas, lo que permite que diferentes actores se comuniquen entre sí. <br/>

Si intentamos implementar [el siguiente actor](https://m7sm4-2iaaa-aaaab-qabra-cai.ic0.app/?tag=2185064550):
```motoko
actor {
  var mutableArray : [var Nat] = [var 1, 3, 5, 7]; 

  public func showArray() : async [var Nat] {
    return mutableArray
  };
}
```
Nos encontraremos con el siguiente error: `Error en el archivo Main.mo:3:28 la función compartida tiene un tipo de retorno no compartido [var Nat] el tipo [var Nat] es o contiene un tipo no compartido var Nat`.

Una regla muy importante a recordar: **todo estado mutable siempre es privado de un actor.**

En resumen, todo lo que puedas modificar en el estado de tu contenedor debe considerarse privado y no podrás compartirlo con otros actores. <br/>

<p align="center"> <img src="../../../../manuals/chapters/chapter-8/assets/mutable_state_actor.png" width="800px" style="border: 2px solid black;"></p>
<p align="center"> Si es una variable, ¡no puedes compartirlo fuera del actor!</p>


> Para obtener una descripción completa de todos los tipos compartidos, [consulta el libro de Motoko](https://web3.motoko-book.dev/internet-computer-programming-concepts/async-data/shared-types.html?highlight=Shared%20types#shared-types).

## 🔃 Tipos recursivos
Lee [esta sección](https://web3.motoko-book.dev/advanced-types/recursive-types.html) del libro de Motoko.
