# Chapter 3: Primitive Types in Motoko.
<p align="center"> <img src="./assets/chapter-3/motoko_primitives_types.png" width="800px" style="border: 2px solid black;"> </p>
<p align="center"> A few primitive types</p>
Primitive types are fundamental core data types that are not composed of more fundamental types.

## 🔢 Nat
`Nat` is used for **unbounded** natural numbers (1,2,3,4,...♾️). By default all positive whole numbers are casted to `Nat`.
```motoko
let n : Nat = 1;
```
Is equivalent to 

```motoko
let n = 1; // Will be casted to Nat automatically
```
**Unbounded** means that value of type `Nat` will never [overflow](https://www.youtube.com/watch?v=WN8i5cwjkSE). The memory representation used will grow to accommodate any finite number. Motoko also has the concept of **bounded** natural numbers (`Nat8`, `Nat16`, `Nat32`, `Nat64`) that we will cover later. If you try to assign a negative number to a `Nat` the program will trap. 

```motoko
let n : Nat = -1;
```
This line will return an error: `literal of type Int does not have expected type Nat`.

`Nat` supports usual operations:
- Addition: you can add two numbers using the addition operator `+`

```motoko
let a : Nat = 1 + 1;    // 2
```
- Subtraction: you can subtract two numbers using the subtraction operator `-`
```motoko
let a : Nat = 10 - 2;   // 8
```
> Be careful with substractions. `Nat` only plays with the positive numbers. If the result of the subtraction is less than zero, it won't fit. The value will no longer be of the `Nat` type and that could cause trouble if your program is expecting a value of the `Nat` type. 

- Multiplication: you can multiply two numbers using the multiplication operator `*`
```motoko
let a : Nat = 10 * 10;  // 100
```
- Division and modulo: to divide two numbers, you can use the division operator `/` and to find the remainder of a divided by b, you can use the modulo operator `%`
```motoko
let a : Nat = 10 / 2;   // 5
let b : Nat = 3 % 2;    // 1
```
## ➖ Int.
Integers represents whole numbers that can be positive or negative. The same mathematical operations seen earlier (addition, multiplication, subtraction, division, and modulo) can be performed on both `Int` and `Nat`.

```motoko
let i : Int = -3; 
let j : Int = 5;
```

> Since `Int` includes positive and negative whole numbers it includes all value of type `Nat`. We say that `Nat` is a subtype of `Ìnt`.

`Ìnt` is also an unbounded type and has bounded equivalents that we will cover later (`Int8`, `Int16`, `Int32`, `Int64`).
## 🚦 Bool.
A `Bool` is either `true` or `false`. `Bool` stands for boolean and this data type only contains two values.
```motoko
let light_on : Bool = true;
let door_open : Bool = false;
````

Booleans can be used and combined with logical operators:

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

`Nat` and `Int` supports comparison operators, which compare two integers and returns a `Bool`: 
- The `==` (equality) operator which indicates if two values are equal.
- The `!=` (not equal) operator which indicates if two values are different.
- The `<` (less than) and `>` (more than) operators.
- The `<=` (less than or equal to) and `>=` (more than or equal to) operators.

```motoko
3 < 5   // true
1 >= 1  // true
1 != 1  // false
2 == 10/5   // true
```
> The `==` operator is very different from the `=` operator. The first will test if two values are equal while the later will asign a value to a variable.
## 💬 Text
In Motoko, strings can be written surrounded by double quotes `"`
```motoko
"Hello Motoko Bootcamp!"
```
The type for string is `Text` (pretty easy to remember).
```motoko
let welcomePhrase : Text = "Hello Motoko Bootcamp!";
```

We can use the concatenation operator `#` to join two `Text` together.
```motoko
let firstName : Text = "Motoko";
let surname : Text = "Bootcamp";
let completeName : Text = firstName # surname;
```

We can access the size of a `Text` by calling the `.size()` method.
```motoko
let name : Text = "Motoko";
let size = name.size()  // 6
```
## 🔤 Char
A value of type `Text` is actually composed of values from another type: `Char`. A `Text` is the concatenation of multiple characters. Characters are single-quote delimited `'`
```motoko
let character_1 : Char = 'c';
let character_2 : Char = '8';
let character_3 : Char = '∏';
```
`Char` are represented by their [Unicode code points](https://deliciousbrains.com/how-unicode-works/). We can use the `Char` module from the Base library to check the unicode value. 
```motoko
import Char "mo:base/Char";
import Debug "mo:base/Debug";
actor {
    let a : Char = 'a';
    Debug.print(debug_show(Char.toNat32(a)));   // 97
}
```
We can easily iterate over all the characters in a `Text`, by calling the `chars()` method. We can then use this iterator to create a `for` loop.
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
> Notice how when we iterate `letter` is a `Char` and we need to convert it back to `Text` to use `Debug.print`.

The `Char` module also contains a few functions that can be used to test properties of characters:
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
## Float.
`Float` are numbers that have a decimal part.
```motoko
let pi = 3.14;
let e = 2.71;
```
If you want to use `Float` for whole numbers, you need to add the type descriptor otherwise they would automatically be casted to `Ìnt` or `Nat`. 
```motoko
let f : Float = 2;
let n = 2;  // Automatically casted to type Nat
```

`Float` are implemented on 64-bits folowing the [IEEE 754 representation](https://www.geeksforgeeks.org/ieee-standard-754-floating-point-numbers/). Due to the limited precision, operations may result in numerical errors.
```motoko
0.1 + 0.1 + 0.1 == 0.3 // => false
```
```motoko
1e16 + 1.0 != 1e16 // => false
```
## Blob.
WIP
## Nat8, Nat16, Nat32, Nat64, Int8, Int16, Int32, Int64.
WIP
## Unit type
The last type we will mention in this chapter is the unit type `()`. This type is also called the empty tuple type. It's useful in several places, for example in functions to indicate that a function does not return any specific type.<br/>
WIP