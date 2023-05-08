# Capítulo 2: Conceptos comunes de programación.
## 📦 Variables 
Una variable es un valor que tiene un nombre arbitrario, definido por una declaración. <br/>
En Motoko, variables pueden ser declaradas usando la palabra clave `let` o `var`, seguido del operador de asignación `=`

- Las variables declaradas con `let`son inmutables, lo que significa que su valor no puede ser cambiado una vez asignado. 
```motoko
let n = 1;
```
- Las variables declaradas con `var` son mutables, su valor puede ser reasignado a un valor nuevo en cualquier momento usando el operador de reasignación `:=`.

```motoko
var n = 1;
n := 2;
```

La sintaxis convencional es usar `lowerCamelCase` para el nombre de variables y usar espacios alrededor del signo `=`. Además, la declaración de una variable termina con un semicolon `;` Cuando declaramos una variable no olvides acabar la declaración con `;` de otra manera Motoko se quejara.

Si probamos el siguiente código:
```motoko
let n = 1;
n := 2;
```

En el código anterior podemos ver que se produce un intento de reasignación del valor de una variable inmutable - lo que resulta en un error. El mensaje de error en este caso será `type error [M0073], expected mutable assignment target`. Este mensaje indica que la variable a la cual se le intentó asignar un valor es inmutable por lo cual no puede ser modificada.
## 🍎 Tipos
El lenguaje  **Motoko** hace un gran énfasis en los tipos y es mas estricto respecto a estos comparado con otros lenguajes de propósito-general como **JavaScript** o **Python**. Esta dureza tiene su fin, ya que esto ayuda a prevenir errores y problemas. 

**Motoko** tiene tipos estáticos, lo que significa que cada variable es asignada con un tipo específico, el cual es determinado antes de que el programa se ejecute. El compilador revisa cada uso de las variables para evitar errores que se puedan dar en la ejecución. <br/>

Para asignar un tipo a una variable usamos el símbolo `:` , esto es llamado **type annotation**.
```motoko
let age : Nat = 20;
let message : Text = "Of all the acts, the most complete is that of building";
let open : Bool = false;
```

Por lo general puedes omitir la declaración de tipo - el compilador de  **Motoko** automáticamente adivinara el tipo de la variable basándose en el primer valor que le hayas otorgado, esto se llama **type inference**.
```
let age = 20;   // Will be assigned type Nat
```
> Para la duración del Bootcamp  es recomendable declarar todas las variables para hacer las cosas más claras, especialmente si eres nuevo en los lenguajes tipados.
## 💬 Comentarios.
Un comentario de solo una línea es escrito empezando la línea con `//`.
```motoko
// Hello! It is recommended to use comments to make your code more readable.
```

Un comentario puede ser de líneas múltiples, en ese caso necesitarás añadir `//` en cada línea.
```motoko
//  Sometimes you'll have a lot to say
//  In those cases 
//  You can use more than one line
```
## ⚙️ Funciones
Esta sección se centra en funciones que son definidas en el cuerpo de un actor usando la sintaxis `actor {}`. Cualquier función que está fuera de la sintaxis `actor {}` será cubierta en futuros capítulos.
### Un ejemplo simple
Para introducir funciones - revisemos un ejemplo: aquí tenemos un actor que es responsable de llevar un registro de un counter. 
```motoko
actor Counter {
    var count : Nat = 0;

    public func setCount(n : Nat) : async Nat {
        count := n;
        return count;
    };

};
```

La palabra clave `func` es usada para declarar funciones, seguido por el nombre dado a la función, en este caso `increaseCount`. Igual que con las variables As for variables, la sintaxis convencional es usar `lowerCamelCase` para el nombre de las funciones.  <br/>

### Function type
Cuando se define una función en Motoko, los tipos de argumentos y el tipo de retorno son usados para determinar el tipo de la función. Por ejemplo, la función setCount tiene el siguiente tipo:
```motoko
setCount : (n : Nat) -> async Nat;
```
Para declarar una función en Motoko, debes especificar los tipos de los argumentos y de los valores de retorno. Los argumentos de la función se encuentran entre paréntesis `()`, y en este caso, la función toma un argumento  `n` de tipo `Nat`. Después de los argumentos de la función, el valor del retorno es especificado : `async Nat`.

> Te preguntarás porque el tipo de retorno de la función `setCount` es `async Nat` en vez de simplemente`Nat`? <br/> El término`async` significa asíncrono,  lo que significa que en el **Actor model** que vimos anteriormente, canisters o actors se comunican entre sí asíncronamente. Cuando un canister envía una solicitud a otro (o cuando usuarios llaman a una función), habrá un breve periodo de espera antes de que se reciba una respuesta
. <br/> 
Programación asíncrona te permite ejecutar tu código en una manera non-blocking. El tipo de retorno`async Nat` para la función `setCount` indica que el caller deberá esperar por unos momentos antes de recibir el valor de retorno. Eventualmente, la respuesta será tendrá un tipo de valor `Nat`, pero con un retraso debido a la naturaleza asíncrona de la comunicación entre canisters. **Todas las funciones públicas declaradas en el cuerpo de un actor deben tener un tipo de retorno `async`**. 

### Cuerpo y retorno
- Las llaves `{}` son usadas para el cuerpo de la función. El cuerpo de la función es un conjunto de instrucciones que son ejecutadas cuando la función es llamada.
En nuestro ejemplo, para `setCount` tenemos 2 instrucciones:
1. Asignar el valor de  `count` al valor de `n`. 
2. Retornar el valor de `count`.

Motoko permite omitir el `return` al final del cuerpo de la función, ya que un bloque siempre es evaluado a su última expresión. Lo que significa que podríamos reescribir el código de la siguiente forma y seguirá siendo válido:
```motoko
public func setCount(n : Nat) : async Nat {
    count := n;
    count;
};
```
### Public vs Private
Hasta ahora solo hemos visto las funciones `public`. Sin embargo, en Motoko también puedes definir funciones `private`. 
```motoko
private func add(n : Nat, m : Nat) : Nat {
    return (n + m)
};
```
Ahora la función está marcada como `private`, lo que significa que esta solo puede ser usada por el actor y no puede ser llamada directamente por usuarios o canisters externos.

Normalmente las funciones `private` son usadas como ayudantes de otras funciones, que generalmente son definidas como `public`. Por lo que podríamos escribir el siguiente código.

```motoko
actor {
    var count : Nat = 0;

    private func add(n : Nat, m : Nat) : Nat {
        return (n + m)
    };

    public func addCount(n : Nat) : async Nat {
        let newCount = add(count,n);
        count := newCount;
        return count;
    };
}
```

> Podemos remover la palabra clave `private` ,una función en Motoko por defecto es declarada private a no ser que se especifique lo contrario (i.e a menos que se declare `public`).

## 🕹️ Control flow.
Control flow se refiere al orden en el cual el programa es ejecutado y el orden que sigue. Este decide que declaraciones, instrucciones o llamadas de funciones son ejecutadas y en qué orden, basándose en decisiones hechas en el momento de ejecución. <br/>

Podemos distinguir tres constructores comunes de control flow en Motoko: dichas expresiones son `if else` , `loops` y `switch`.
### If/else
La declaración `if` permite al programa tomar decisiones y ejecutar un bloque de código específico solo si la condición se cumple. La declaración opcional  `else` permite una alternativa si la condición no se cumple. 
```motoko
    func isEven(n : Nat) : Bool {
        if(n % 2 == 0){
            return true
        } else {
            return false
        };
    };
```
En este caso, la condición `n % 2` será probada en la ejecución y dependiendo del valor de `n` devolverá `true` o `false`.
En algunos casos el bloque `else`puede ser removido sin modificar el comportamiento del código.
```motoko
    func isEven(n : Nat) : Bool {
        if(n % 2 == 0){
            return true;
        };
        return false;
    };
```
En otros casos, se puede agregar los bloques `else if` para comprobar condiciones adicionales.
```motoko
    func checkNumber(i : Int) : Text {
        if(n < 0) {
            return ("The number is negative.");
        } else if (n == 0) {
            return("The number is zero.");
        } else if (n < 10) {
            return("The number is one digits.");
        } else if (n < 100) {
            return("The number is two digits.");
        } else {
            return ("The number is three or more digits.");
        }
    };
```
Debes recordar que la declaración `else if` es usada después de la declaración `if` inicial  para comprobar condiciones adicionales, y solo el bloque de código relacionado con la primera condición que devuelva true será ejecutado.
### Loops (bucles)
Loops permite la ejecución de un código hasta que cierta condición se cumpla. Se pueden encontrar distintos tipos de bucles ,como bucles`for`y bucles `while`:
- Bucles `for` en Motoko usan un iterador del tipo `Iter`. Discutiremos sobre el tipo `Iter` más Adelante en otro capítulo, pero para resumir, los objetos `Iter` facilitan el recorrer un bucle y la colección de datos.
```motoko
var count : Nat = 0;
for (x in Iter.range(0, 10)) {
    count += 1;
};
```
En este ejemplo, `Iter.range(0, 10)` recorre todos los números naturales entre 0 y 10, incluyendo ambos números.

Alternativamente, puedes usar los bucles `while`, los cuales se ejecutan siempre y cuando una condición se cumpla y devuelva true.

```motoko
var count : Nat = 0;
while (count < 10) {
    count += 1;
};
```
En este caso, el bucle se seguirá ejecutando hasta que la variable `count` siga siendo menor que 10.
### Switch/case
La expresión `switch` en Motoko es un constructor que controla el flujo del código basándose en el  input. Comienza con la palabra clave `switch` , seguido del input entre paréntesis `()`, y un bloque de código encerrado entre llaves `{}`.
```motoko
let x = 3;
switch(x) {
    //
};
```
Dentro de este bloque de código, la palabra clave `case` es usada para definir patrones y expresiones encerradas dentro de llaves `{}`. El input es comparado a cada valor especificado en cada caso, y si se encuentra una coincidencia, la expresión correspondiente a cada  `case` es ejecutada.
```motoko
let x = 3;
switch(x) {
    case(0) {
        // This corresponds to the case x == 0
        return ("x is equal to 0");
    };
    case (1) {
        // This corresponds to the case x == 1
        return ("x is equal to 1");
    };
    case (2) {
        // This corresponds to the case x == 2
        return ("x is equal to 2");
    };
    case (_) {
        // This corresponds to all other cases
        return ("x is above 2");
    };
};
```
En Motoko, es obligado incluir una declaración  `case(_)` para cada posible valor del input en una expresión `switch`. Es por eso que case(`_`) a veces es usado como un catch-all case para manejar cualquier valor de un input que no coincide con ningún otro case. El símbolo de raya baja (`_`) es un comodín que coincide con cualquier valor, por lo que `case(_)` coincidirá con cualquier valor del input.

La expresión `switch/case` se usa mejor con variantes.

```motoko
type Day = {
    #Monday;
    #Tuesday;
    #Wednesday;
    #Thursday;
    #Friday;
    #Saturday;
    #Sunday;
};
let day = #Monday;

switch(day) {
    case(#Monday){
        return ("Today is Monday");
    };
    case(#Tuesday){
        return ("Today is Tuesday");
    };
    case(#Wednesday){
        return ("Today is Wednesday");
    };
    case(#Thursday){
        return ("Today is Thursday");
    };
    case(#Friday){
        return ("Today is Friday");
    };
    case(#Saturday){
        return ("Today is Saturday");
    };
    case(#Sunday){
        return ("Enjoy your Sunday");
    };
};
```
En este ejemplo, definimos una variante de tipo `Day`, declarando una variable `day` con dicho tipo , y después esta será usada como nuestro input para la expresión `switch`. La expresión switch es un poderoso controlador de flujo que permite la coincidencia de patrones, proporcionando una concisa y leíble manera de manejar múltiples casos basados en el valor del input.
