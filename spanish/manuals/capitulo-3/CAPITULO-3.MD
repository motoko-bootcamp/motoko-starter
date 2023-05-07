# Capítulo 3: Types primitivos en Motoko
Los tipos primitivos son tipos de datos fundamentales que no están compuestos de tipos más fundamentales. <br/>

Los tipos primitivos son todos los tipos que no necesitan ser importados antes de que se puedan utilizar en la anotación de tipos.
<p align="center"> <img src="../../../chapters/chapter-3/assets/motoko_primitives_types.png" width="800px" style="border: 2px solid black;"> </p>
<p align="center"> Algunos tipos primitivos en Motoko</p>

## 🔢 Nat
`Nat` se utiliza para números naturales **ilimitados** (1,2,3,4,...♾️). Por defecto, todos los números enteros positivos se convierten a `Nat`.
```motoko
let n : Nat = 1;
```
Es equivalente a

```motoko
let n = 1; // Will be casted to Nat automatically
```
**Unbounded** significa que el valor del tipo `Nat` nunca [desbordará](https://www.youtube.com/watch?v=WN8i5cwjkSE). La representación de memoria utilizada crecerá para acomodar cualquier número finito. Motoko también tiene el concepto de números naturales **acotados** (`Nat8`, `Nat16`, `Nat32`, `Nat64`) que cubriremos más adelante. Si intentas asignar un número negativo a un `Nat`, el programa se detendrá.

```motoko
let n : Nat = -1;
```
Esta línea devolverá un error: `literal of type Int does not have expected type Nat`.

`Nat` admite operaciones usuales:
- Adición: puedes sumar dos números utilizando el operador de adición `+`.

```motoko
let a : Nat = 1 + 1;    // 2
```

- Sustracción: puedes restar dos números utilizando el operador de sustracción `-`.
```motoko
let a : Nat = 10 - 2;   // 8
```
> Ten cuidado con las restas. `Nat` solo trabaja con números positivos. Si el resultado de la resta es menor que cero, no cabrá. El valor ya no será del tipo `Nat` y eso podría causar problemas si tu programa está esperando un valor del tipo `Nat`.

- Multiplicación: puedes multiplicar dos números utilizando el operador de multiplicación `*`.
```motoko
let a : Nat = 10 * 10;  // 100
```
- División y módulo: para dividir dos números, puedes utilizar el operador de división `/` y para encontrar el resto de la división de a por b, puedes utilizar el operador de módulo `%`.
```motoko
let a : Nat = 10 / 2;   // 5
let b : Nat = 3 % 2;    // 1
```
## ➖ Int
Los enteros representan números enteros que pueden ser positivos o negativos. Las mismas operaciones matemáticas vistas anteriormente (suma, multiplicación, resta, división y módulo) se pueden realizar tanto en `Int` como en `Nat`.

```motoko
let i : Int = -3; 
let j : Int = 5;
```
> Dado que `Int` incluye números enteros positivos y negativos, incluye todos los valores del tipo `Nat`. Decimos que `Nat` es un subtipo de `Int`.

`Ìnt` también es un tipo ilimitado y tiene equivalentes acotados que cubriremos más adelante (`Int8`, `Int16`, `Int32`, `Int64`).
## 🚦 Bool
Un `Bool` es `true` o `false`. `Bool` significa booleano y este tipo de dato solo contiene dos valores.
```motoko
let light_on : Bool = true;
let door_open : Bool = false;
````
Los booleanos se pueden usar y combinar con operadores lógicos:

- `and` (y)
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

`Nat` e `Int` admiten operadores de comparación, que comparan dos enteros y devuelven un `Bool`:
- El operador `==` (igualdad) que indica si dos valores son iguales.
- El operador `!=` (diferente) que indica si dos valores son diferentes.
- Los operadores `<` (menor que) y `>` (mayor que).
- Los operadores `<=` (menor o igual que) y `>=` (mayor o igual que).

```motoko
3 < 5   // true
1 >= 1  // true
1 != 1  // false
2 == 10/5   // true
```
> El operador `==` es muy diferente del operador `=`. El primero comprobará si dos valores son iguales, mientras que el último asignará un valor a una variable.

## 💬 Texto
En Motoko, las cadenas de texto se pueden escribir rodeadas de comillas dobles `"`
```motoko
"Hello Motoko Bootcamp!"
```
El tipo para una cadena es `Text`.
```motoko
let welcomePhrase : Text = "Hello Motoko Bootcamp!";
```

Podemos usar el operador de concatenación `#` para unir dos valores `Text`.
```motoko
let firstName : Text = "Motoko";
let surname : Text = "Bootcamp";
let completeName : Text = firstName # surname;
```

Podemos acceder al tamaño de un valor `Text` llamando al método `.size()`.
```motoko
let name : Text = "Motoko";
let size = name.size()  // 6
```
## 🔤 Char
Un valor del tipo `Text` está compuesto en realidad por valores de otro tipo: `Char`. Un `Text` es la concatenación de varios caracteres. Los caracteres se delimitan con comillas simples `'`.
```motoko
let character_1 : Char = 'c';
let character_2 : Char = '8';
let character_3 : Char = '∏';
```
`Char` se representan por sus [puntos de código Unicode](https://deliciousbrains.com/how-unicode-works/). Podemos usar el módulo `Char` de la biblioteca Base para verificar el valor Unicode.
```motoko
import Char "mo:base/Char";
import Debug "mo:base/Debug";
actor {
    let a : Char = 'a';
    Debug.print(debug_show(Char.toNat32(a)));   // 97
}
```
`Char` se representan por sus [puntos de código Unicode](https://deliciousbrains.com/how-unicode-works/). Podemos usar el módulo `Char` de la biblioteca Base para verificar el valor Unicode.
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
> Observa que cuando iteramos `letter` es un `Char` y necesitamos convertirlo de vuelta a `Text` para usar `Debug.print`.

El módulo `Char` también contiene algunas funciones que se pueden utilizar para probar propiedades de los caracteres:
- `isDigit` (es dígito)
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
`Float` son número que tienen partes naturales.
```motoko
let pi = 3.14;
let e = 2.71;
```
Si quieres utilizar `Float` para números enteros, necesitas agregar un descriptor de type o automaticamente será transformados a `Ìnt` o `Nat`. 
```motoko
let f : Float = 2;
let n = 2;  // Automatically casted to type Nat
```

Los `Float` se implementan en 64 bits siguiendo la [representación IEEE 754](https://www.geeksforgeeks.org/ieee-standard-754-floating-point-numbers/). Debido a la precisión limitada, las operaciones pueden dar lugar a errores numéricos.
```motoko
0.1 + 0.1 + 0.1 == 0.3 // => false
```
```motoko
1e16 + 1.0 != 1e16 // => false
```
## 🎛️ Types acotados
Motoko proporciona soporte para tipos acotados que son tipos de enteros con una precisión fija. Estos tipos acotados pueden ser útiles por varias razones:

- Eficiencia de memoria: los tipos acotados le permiten saber exactamente cuánta memoria ocupará sus datos.
- Tamaño exacto: cuando sabe que una API devuelve un número exacto, puede utilizar tipos acotados para asegurarse de que el número devuelto se represente con precisión.
- Eficiencia de ejecución: si sabe que sus números requieren aritmética de 64 bits, usar `Nat64` es más eficiente que usar `Nat`.
- Aritmética de bits: los tipos acotados facilitan la realización de operaciones de bits como `<<` o `XOR` en datos binarios.

### Nat8, Nat16, Nat32 y Nat64
Hay cuatro tipos naturales admitidos en Motoko: `Nat8`, `Nat16`, `Nat32` y `Nat64`.

El número en el nombre del tipo especifica la cantidad de bits en la representación del tipo. Por ejemplo, `Nat32` representa un número natural de 32 bits.

Para declarar una variable acotada, debe especificar el tipo explícitamente para evitar que se convierta automáticamente en un `Nat` regular:
```motoko
let n : Nat32 = 1;
```
En cambio, si declara una variable sin especificar su tipo, se convertirá automáticamente en un `Nat` regular.
```motoko
let n = 1; // Will be casted to Nat automatically
```
### Int8, Int16, Int32 y Int64
Motoko también admite tipos de enteros, incluidos `Int8`, `Int16`, `Int32` e `Int64`. Los tipos de enteros acotados se comportan de manera similar a los tipos naturales acotados, excepto que admiten valores negativos. El número en el nombre del tipo especifica la cantidad de bits en la representación del tipo. Por ejemplo, `Int32` representa un entero de 32 bits:
```motoko
let i : Int32 = -1;
```

## 🤖 Blob.
`Blob` representa un objeto binario grande. El tipo `Blob` representa una secuencia inmutable de bytes: son inmutables, iterables, pero no indexables y pueden estar vacíos. <br/>

Las secuencias de bytes también se representan a menudo como `[Nat8]`, es decir, una matriz de bytes, pero esta representación es actualmente mucho menos compacta que `Blob`, lo que hace que se necesiten 4 bytes físicos para representar cada byte lógico en la secuencia.
Si desea manipular Blobs, se recomienda convertir `Blobs` a `[var Nat8]` o `Buffer<Nat8>`, hacer la manipulación y luego convertirlos de vuelta.

## 🫙 Type unitario
El último tipo que mencionaremos en este capítulo es el tipo unitario `()`. Este tipo también se llama tipo de tupla vacía. Es útil en varios lugares, por ejemplo, en funciones para indicar que una función no devuelve ningún tipo específico.
```motoko
import Debug "mo:base/Debug";
actor {
    public func printMessage(message : Text) : async () {
        Debug.print(message);
        return();
    };
}
```
