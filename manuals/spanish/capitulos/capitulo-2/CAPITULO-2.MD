# Capítulo 2: Conceptos de programación comunes.
## 📦 Variables 
Una variable es un valor que tiene un nombre arbitrario, definido por una declaración. <br/>
En Motoko, las variables se pueden declarar usando la palabra clave `let` o `var`, seguida del operador de asignación `=`.

- Las variables declaradas con `let` son inmutables, lo que significa que su valor no puede cambiarse una vez que se asignan.```motoko
let n = 1;
```
- Las variables declaradas con `var` son mutables, lo que significa que su valor se puede reasignar a un nuevo valor en cualquier momento utilizando el operador de reasignación `:=`.
```motoko
var n = 1;
n := 2;
```
La convención de sintaxis es utilizar `lowerCamelCase` para los nombres de las variables y utilizar espacios alrededor del signo `=`. Además, una declaración de variable termina con un punto y coma `;`. Cuando declares una variable, no olvides terminar la declaración con `;`, de lo contrario Motoko mostrará un error.

Si intentamos el siguiente código:
```motoko
let n = 1;
n := 2;
```

Se intenta reasignar un valor a una variable inmutable, por eso se producirá un error. El mensaje de error específico será `type error [M0073], expected mutable assignment target`. Este mensaje indica que la variable que se está reasignando es inmutable y no se puede cambiar.

## 🍎 Tipos
El lenguaje **Motoko** hace mucho énfasis en los tipos y es más estricto en su aplicación en comparación con otros lenguajes de propósito general como **JavaScript** o **Python**. Esta rigurosidad sirve a un propósito, ya que ayuda a prevenir errores e problemas.

**Motoko** tiene tipos estáticos, lo que significa que a cada variable se le asigna un tipo específico, que se determina antes de que se ejecute el programa. El compilador verifica cada uso de la variable para evitar errores que puedan ocurrir durante la ejecución del programa. <br/>

Para asignar un tipo a una variable, utilizamos el símbolo `:`, esto se llama **anotación de tipo**.
```motoko
let age : Nat = 20;
let message : Text = "Of all the acts, the most complete is that of building";
let open : Bool = false;
```

Por lo general, se puede omitir la declaración de tipo - el compilador de **Motoko** adivinará automáticamente el tipo de la variable en función del primer valor que proporciones, esto se llama **inferencia de tipo**.```
let age = 20;   // Will be assigned type Nat
```
> Durante la duración del Bootcamp, se recomienda mantener todas las declaraciones de tipo para hacer las cosas más claras, especialmente si eres nuevo en los lenguajes con tipos.

## 💬 Comentarios.
Un comentario de una sola línea se escribe iniciando la línea con `//`.
```motoko
// Hello! It is recommended to use comments to make your code more readable.
```

Un comentario puede abarcar varias líneas, en ese caso deberás agregar `//` en cada línea.
```motoko
//  Sometimes you'll have a lot to say
//  In those cases 
//  You can use more than one line
```
## ⚙️ Funciones
Esta sección se centra únicamente en las funciones que se definen dentro del cuerpo de un actor utilizando la sintaxis `actor {}`. Cualquier función que esté fuera de la sintaxis `actor {}` se cubrirá en capítulos futuros.

### Un ejemplo sencillo
Para introducir las funciones, veamos un ejemplo: aquí hay un actor que es responsable de llevar un contador.
```motoko
actor Counter {
    var count : Nat = 0;

    public func setCount(n : Nat) : async Nat {
        count := n;
        return count;
    };

};
```

La palabra clave `func` se utiliza para declarar funciones, seguida del nombre que se le da a la función, en este caso `increaseCount`. Al igual que con las variables, la convención de sintaxis es utilizar `lowerCamelCase` para los nombres de las funciones.  <br/>

### Tipo de función
Al definir una función en Motoko, los argumentos y el tipo de retorno tipados se utilizan para determinar el tipo de la función en su conjunto. Por ejemplo, la función `setCount` tiene el siguiente tipo:
```motoko
setCount : (n : Nat) -> async Nat;
```
Para declarar una función en Motoko, debes especificar los tipos de los argumentos y los valores de retorno. Los argumentos de la función se encierran entre paréntesis `()`, y en este caso, la función toma un argumento `n` de tipo `Nat`. Después de los argumentos de la función, se especifica el tipo de retorno: `async Nat`.

> Es posible que te preguntes por qué el tipo de retorno de la función `setCount` es `async Nat` en lugar de simplemente `Nat`. <br/> El término `async` significa asíncrono, lo que significa que, en el modelo de actores que discutimos anteriormente, los canisters o actores se comunican entre sí de manera asíncrona. Cuando un canister envía una solicitud a otro (o cuando un usuario llama a una función), habrá un breve período de espera antes de que el llamante reciba una respuesta. <br/> 
La programación asíncrona te permite ejecutar tu código de forma no bloqueante. El tipo de retorno `async Nat` para la función `setCount` indica que el llamante debe esperar unos momentos antes de recibir el valor de retorno. Eventualmente, la respuesta será un valor de tipo `Nat`, pero con un retraso debido a la naturaleza asíncrona de la comunicación entre canisters. **Todas las funciones públicas declaradas en el cuerpo de un actor deben tener un tipo de retorno `async`**. 

### Cuerpo y retorno
- Las llaves `{}` se utilizan para el cuerpo de la función. El cuerpo de la función es un conjunto de instrucciones que se ejecutan cuando se llama a la función.
En nuestro ejemplo, para `setCount` tenemos 2 instrucciones:
1. Asignar el valor de `count` al valor de `n`. 
2. Devolver el valor actual de `count`.

Motoko permite omitir el `return` al final del cuerpo de la función, porque un bloque siempre se evalúa como su última expresión. Lo que significa que podríamos reescribir el código de la siguiente manera y seguiría siendo válido:
```motoko
public func setCount(n : Nat) : async Nat {
    count := n;
    count;
};
```
### Público vs Privado
Hasta ahora solo hemos visto funciones `públicas`. Sin embargo, en Motoko también puedes definir funciones `privadas`.
```motoko
private func add(n : Nat, m : Nat) : Nat {
    return (n + m)
};
```
La función ahora está marcada como `privada`, lo que significa que solo puede ser utilizada por el actor y no puede ser llamada directamente por usuarios o canisters externos.

Por lo general, las funciones `privadas` se usan como ayudantes en otras funciones, que generalmente se definen como `públicas`. Por ejemplo, podríamos escribir lo siguiente.
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

> Podemos eliminar la palabra clave `private`, una declaración de función se define como `privada` por defecto en Motoko a menos que se declare lo contrario (es decir, a menos que se declare `public`).

## 🕹️ Control de flujo.
El control de flujo se refiere al orden en que se ejecuta un programa y el orden que sigue. Decide qué declaraciones, instrucciones o llamadas de función se ejecutan y en qué orden, en función de las condiciones o decisiones tomadas durante la ejecución. <br/>

Discutimos tres constructos de control de flujo comunes en Motoko: expresiones `if else`, expresiones `loops` y expresiones `switch`.
### If/else
La instrucción `if` permite que el programa tome una decisión y ejecute un bloque de código específico solo si se cumple una condición específica. La instrucción opcional `else` proporciona una alternativa si no se cumple la condición. 
```motoko
    func isEven(n : Nat) : Bool {
        if(n % 2 == 0){
            return true
        } else {
            return false
        };
    };
```
En este caso, se probará la condición `n % 2` en tiempo de ejecución y, según el valor de `n`, devolverá `true` o `false`.
En muchos casos, el bloque `else` se puede eliminar sin modificar el comportamiento del bloque de código.
```motoko
    func isEven(n : Nat) : Bool {
        if(n % 2 == 0){
            return true;
        };
        return false;
    };
```
En otros casos, se pueden agregar bloques `else if` para verificar condiciones adicionales.
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
Ten en cuenta que las sentencias `else if` se utilizan después de la sentencia `if` inicial para verificar condiciones adicionales, y solo se ejecutará el bloque de código asociado a la primera condición que se evalúe como verdadera.

### Bucles
Los bucles permiten la ejecución repetida de un bloque de código hasta que se cumpla una condición específica. Hay varios tipos de bucles, como los bucles `for` y los bucles `while`:
- Los bucles `for` en Motoko utilizan un iterador del tipo `Iter`. Profundizaremos en el tipo `Iter` en un capítulo posterior, pero para resumir, los objetos `Iter` facilitan el bucle a través de colecciones de datos.
```motoko
var count : Nat = 0;
for (x in Iter.range(0, 10)) {
    count += 1;
};
```
En este ejemplo, `Iter.range(0, 10)` itera a través de todos los números naturales entre 0 y 10, inclusive de ambos límites.

Alternativamente, puedes usar bucles `while`, que se ejecutan mientras se cumpla la condición especificada.

```motoko
var count : Nat = 0;
while (count < 10) {
    count += 1;
};
```
En este caso, el bucle continuará ejecutándose hasta que la variable `count` ya no sea menor que 10.
### Switch/case
La expresión `switch` en Motoko es un constructo de control de flujo que coincide con patrones basados en su entrada. Comienza con la palabra clave `switch`, seguida de la expresión de entrada encerrada entre paréntesis `()`, y un bloque de código encerrado entre llaves `{}`.
```motoko
let x = 3;
switch(x) {
    //
};
```
Dentro del bloque de código, se utiliza la palabra clave `case` para definir patrones y expresiones encerradas entre llaves `{}`. La entrada se compara con los patrones especificados en cada caso, y si se encuentra una coincidencia, se ejecuta la expresión dentro del bloque correspondiente de `case`.
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
En Motoko, es obligatorio incluir una declaración `case(_)` para cada valor de entrada posible en una expresión `switch`. Es por eso que a veces se utiliza el patrón `case(_)` como un caso comodín para manejar cualquier valor de entrada que no coincida con ninguno de los otros casos. El símbolo de guión bajo (`_`) es un comodín que coincide con cualquier valor, por lo que el patrón `case(_)` coincidirá con cualquier valor de entrada.

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
En este ejemplo, definimos un tipo variante `Day`, declaramos una variable `day` con ese tipo y luego lo usamos como entrada en nuestra expresión `switch`. La expresión `switch` es un constructo de control de flujo poderoso que permite el patrón de coincidencia, proporcionando una forma concisa y legible de manejar múltiples casos basados en el valor de entrada.
