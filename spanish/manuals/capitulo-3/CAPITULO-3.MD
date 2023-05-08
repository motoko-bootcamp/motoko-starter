# Chapter 3:  Tipos primitivos en Motoko.
Los tipos primitivos son tipos de datos fundamentales que no están compuestos de más tipos fundamentales. <br/>

Los tipos de datos primitivos son todos los tipos de datos que no necesitan ser importados antes de ser usados en type annotation.
<p align="center"> <img src="./assets/motoko_primitives_types.png" width="800px" style="border: 2px solid black;"> </p>
<p align="center"> Unos cuantos tipos de datos primitivos en Motoko</p>

## 🔢 Nat
`Nat` es usado para los números naturales **unbounded** (1,2,3,4,...♾️). Por defecto todos los números enteros positivos son encapsulados como `Nat`.
```motoko
let n : Nat = 1;
```
Es lo mismo que 

```motoko
let n = 1; // Será reconocido como tipo Nat automáticamente
```
**Unbounded** significa que el valor de tipo `Nat` nunca [desbordara](https://www.youtube.com/watch?v=WN8i5cwjkSE). La representación en la memoria aumenta para albergar cualquier número finito. Motoko También tiene el concepto de número naturales **bounded**  (`Nat8`, `Nat16`, `Nat32`, `Nat64`) de los que hablaremos mas adelante. Si intentas asignar un número negativo a un `Nat`el programa se parará. 

```motoko
let n : Nat = -1;
```
Esta línea devolverá un error: `literal of type Int does not have expected type Nat`.

`Nat` soporta operaciones usuales:
- Suma: puedes sumar dos números usando el operador `+`

```motoko
let a : Nat = 1 + 1;    // 2
```
- Resta: puedes restar dos números usando el operador `-`
```motoko
let a : Nat = 10 - 2;   // 8
```
> Sé cuidadoso con la resta. `Nat`solo es aplicable para números positivos. Si el resultado de la resta es menor de cero, este no encaja. El valor no será más de tipo `Nat` y esto puede causar un problema si tu programa espera un valor de tipo `Nat`. 

-Multiplicación: puedes multiplicar dos números usando el operador `*`
```motoko
let a : Nat = 10 * 10;  // 100
```
- División y módulo: para dividir dos números, puedes usar el operador de división `/`  y para encontrar el resto de dividir a entre b, puedes usar el operador de modulo `%`
```motoko
let a : Nat = 10 / 2;   // 5
let b : Nat = 3 % 2;    // 1
```
## ➖ Int.
Los Integers representan números enteros que pueden ser positivos o negativos. Las mismas operaciones matemáticas que vimos anteriormente (suma, resta, multiplicación, división y módulo) pueden ser realizadas con ambos `Int` y `Nat`.

```motoko
let i : Int = -3; 
let j : Int = 5;
```

> Desde que `Int` incluye números enteros positivos y negativos incluye todos los valores de tipo `Nat`. Decimos que `Nat` es un subtipo de `Ìnt`.

`Ìnt`es también un tipo ilimitado y también tiene equivalentes limitadas que veremos más adelante (`Int8`, `Int16`, `Int32`, `Int64`).
## 🚦 Bool.
Un `Bool` puede ser `true` o `false`. `Bool` significa boolean y este tipo de dato solo contiene dos valores.
```motoko
let light_on : Bool = true;
let door_open : Bool = false;
````

Booleans pueden ser usados y combinados con operadores lógicos:

- `and`
```motoko
let result = false and false;   //false
```
```motoko
let result = true and false;    //false
```
```motoko
let result = false and true;    //false
```
```motoko
let result = true and true;     //true
```
- `or`
```motoko
let result = false or false;   //false
```
```motoko
let result = true or false;    //true
```
```motoko
let result = false or true;    //true
```
```motoko
let result = true or true;     //true
```
- `not`

```motoko
let result = not true;      //false
```
```motoko
let result = not false;     //true
```

`Nat` e `Int` soportan operadores de comparación, los cuales comparan dos integers y devuelven un `Bool`: 
- El operador `==` (igualdad) indica si dos valores son iguales.
- El operador `!=` (no igual) indica si dos valores son diferentes.
- Los operadores `<` (menor que) y `>` (mayor que).
- Los operadores `<=` (menor o igual que) y `>=` (mayor o igual que).

```motoko
3 < 5   // true
1 >= 1  // true
1 != 1  // false
2 == 10/5   // true
```
> El operador `==` es muy distinto del operador '=`.  El primero probará si dos valores son iguales mientras que el otro asignará un valor a una variable.
## 💬 Texto
En Motoko, strings pueden ser escritas entre comillas dobles `"`
```motoko
"Hello Motoko Bootcamp!"
```
El tipo para string es `Text`.
```motoko
let welcomePhrase : Text = "Hello Motoko Bootcamp!";
```

Podemos usar el operador de concatenación `#` para unir dos `Text` juntos.
```motoko
let firstName : Text = "Motoko";
let surname : Text = "Bootcamp";
let completeName : Text = firstName # surname;
```

Podemos acceder el tamaño de un `Text`llamando al método `.size()`.
```motoko
let name : Text = "Motoko";
let size = name.size()  // 6
```
## 🔤 Char
Un valor de tipo `Text` en sí está compuesto por valores de otro tipo llamado `Char`. Un `Text` es la concatenación de múltiples caracteres. Los caracteres son delimitados por comillas simples `'`
```motoko
let character_1 : Char = 'c';
let character_2 : Char = '8';
let character_3 : Char = '∏';
```
`Char` son representados por sus [Unicode code points](https://deliciousbrains.com/how-unicode-works/). Podemos usar el módulo `Char` desde la librería base para comprobar el valor unicode. 
```motoko
import Char "mo:base/Char";
import Debug "mo:base/Debug";
actor {
    let a : Char = 'a';
    Debug.print(debug_show(Char.toNat32(a)));   // 97
}
```
Podemos iterar fácilmente sobre todos los caracteres de un `Text`, llamando al método `chars()`. Podemos usar esta iteración para crear un bucle `for`.
```motoko
import Debug "mo:base/Debug";
import Char "mo:base/Char";
actor {
    let name : Text = "Motoko";
    for (letter in name.chars()){
        Debug.print(Char.toText(letter));
    };
};
```
> Date cuenta de cómo cada `letter` que iteramos es un `Char` y necesitamos convertirlo de vuelta a `Text`para usar `Debug.print`.

El módulo `Char` también contiene unas cuantas funciones que pueden ser usadas para probar las propiedades de los caracteres:
- `isDigit`
```motoko
Char.isDigit('9');  // true
```
- `isWhitespace`
```motoko
Char.isWhitespace('a'); // false
```
- `isLowercase`
```motoko
Char.isLowercase('c');  //  true
```
- `isUppercase`
```motoko
Char.isUppercase('D');  // true
```
- `isAlphabetic`
```motoko
Char.isAlphabetic('|'); // false
```
## 💥 Float.
`Float` son números con parte decimal.
```motoko
let pi = 3.14;
let e = 2.71;
```
Si quieres usar `Float`para números enteros, necesitas añadir la descripción de tipo de otra forma serán asignadas automáticamente a `Ìnt` o `Nat`. 
```motoko
let f : Float = 2;
let n = 2;  // Automatically casted to type Nat
```

`Float`son implementados en 64-bits siguiendo la [ represetacion IEEE 754](https://www.geeksforgeeks.org/ieee-standard-754-floating-point-numbers/).Debido al limite de precision, las operaciones pueden resultar en errores numericos.
```motoko
0.1 + 0.1 + 0.1 == 0.3 // => false
```
```motoko
1e16 + 1.0 != 1e16 // => false
```
## 🎛️ Tipos limitados
Motoko proporciona apoyo para los tipos limitados, los cuales son tipos integer con una precisión fijada. Estos tipos limitados pueden ser útiles por diversas razones:

- Eficiencia de la memoria: Los tipos limitados te permiten saber exactamente cuanta memoria ocupa tus datos.
- Tamaño exacto: Cuando sabes que una API devuelve un número exacto, puedes usar tipos limitados para asegurarte de que el número devuelto se representa con exactitud.
- Ejecución eficiente: si sabes que tus números requieren una aritmética de 64-bit, usar `Nat64` es más eficiente que usar `Nat`.
- Bitwise arithmetic: Los tipos limitados hacen más fácil el realizar operaciones de bits como `<<` o `XOR` en datos binarios.

### Nat8, Nat16, Nat32 and Nat64
Hay cuatro tipos naturales soportados por Motoko:`Nat8`, `Nat16`, `Nat32`, y `Nat64`.

El número en el nombre del tipo especifica el número de bits en la representación del tipo. Por ejemplo, `Nat32` representa un número natural de 32-bit.

Para declarar una variable limitada, debes especificar explícitamente el tipo para evitar que se le asigne el tipo `Nat automáticamente`:
```motoko
let n : Nat32 = 1;
```
Por el contrario, si tu declaras una variable sin especificar su tipo, se tomará por defecto el tipo `Nat`
```motoko
let n = 1; // Will be casted to Nat automatically
```
### Int8, Int16, Int32, y Int64
Motoko también soporta tipos integers, incluyendo `Int8`, `Int16`, `Int32`, y `Int64`. Los tipos integers limitados se comportan de forma similar a los tipos naturales limitados, excepto que si soportan números negativos. The number in the type name specifies the number of bits in the type representation. For example, `Int32` represents a 32-bit integer:
```motoko
let i : Int32 = -1;
```

## 🤖 Blob.
`Blob` significa  Binary Large Object (objeto binario largo). El tipo `Blob` representa una secuencia inmutable de bytes: son inmutables, iterables, pero no indexables y puede estar vacío. <br/>

Las secuencias de bytes en ocasiones son representadas como `[Nat8]`, i.e. un array de bytes, pero esta representación es menos compacta que `Blob`, tomando 4 bytes físicos para representar cada byte en la secuencia.
Si deseas manipular Blobs, es recomendado que conviertas `Blobs` a `[var Nat8]` o `Buffer<Nat8>`, usa los datos  y luego vuelve a convertirlos.

## 🫙 Unit type
El último tipo que mencionaremos en este capítulo es el tipo unit  `()`. Este tipo también se conoce como el tipo de la tupla vacía. Es útil en varias situaciones, como por ejemplo en funciones que indican que una función no devuelve un tipo específico.
```motoko
import Debug "mo:base/Debug";
actor {
    public func printMessage(message : Text) : async () {
        Debug.print(message);
        return();
    };
}
```
