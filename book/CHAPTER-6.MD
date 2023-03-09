# Chapter 6: Modules 
## The base library
So far, we've only looked at operations that are built-in to the language (additions, subtractions, concatenation...). <br/> 
To perform more complex operations, we'll need to import and use modules, especially those from the [Base library](https://internetcomputer.org/docs/current/motoko/main/base/).

The Base library is a set of modules & functions that provide functions for commonly used types (such as `Bool`, `Nat`, `Int`, `Text` and more..).

A module is a collection of code written by someone else that you can use in your own program. <br/>
In future chapters, we will explore different methods for importing modules and even creating our own modules, but for today we will focus on importing modules from the Base library.

The source code for this library is available on Github and is maintained by engineers from the DFINITY foundation and community members.
Each module has its own documentation page, where you can learn about the available functions. For example, here is the documentation page for the `Nat` module.

<p align="center"> <img src="./assets/chapter-6/base_library_nat.png" width="800px" style="border: 2px solid black;"></p>
<p align="center">  </p>

> The source code is meant to understand how a specific module was written, whereas the documentation is meant to understand how you can use a module.

There is a module for each type to perfom common staks, like converting between data types, transforming the data types, comparing the data type sand other functionalities: 
- A [module Nat](https://internetcomputer.org/docs/current/motoko/main/base/Nat) corresponding to operations on `Nat`.
- A [module Int](https://internetcomputer.org/docs/current/motoko/main/base/Int) corresponding to operations on `Int`.
- A [module Text](https://internetcomputer.org/docs/current/motoko/main/base/Text) corresponding to operations on `Text`.
- A [module Char](https://internetcomputer.org/docs/current/motoko/main/base/Char) corresponding to operations on `Char`.
- And way more..

[See the complete list of available libraries](https://internetcomputer.org/docs/current/motoko/main/base/).

## Importing from the Base library
Importing a module is done at the top of the file before the `actor` declaration.
```
import Nat "mo:base/Nat";
actor {
    public func convertToText(n : Nat) : async Text {
        return Nat.toText(n);
    };
};
```
## Experimental libraries
WIP