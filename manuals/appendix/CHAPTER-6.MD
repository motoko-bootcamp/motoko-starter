# Chapter 6: Debugging in Motoko.
**Debug** is a module that provides utility functions for debugging and printing informations. 
[See the documentation page](https://internetcomputer.org/docs/current/motoko/main/base/Debug).

## Print
```motoko
func print(text : Text)
```
`Debug.print()` will print text to the output stream (i.e your terminal).
```motoko
import Debug "mo:base/Debug";
actor {
    Debug.print("Hello!");
};
```
<p align="center"> <img src="./assets/chapter-7/debug_print.png" width="800px" style="border: 2px solid black;"></p>
<p align="center"> The text will be printed in the same tab that is running your replica. Make sure to check out the correct place!</p>

> Unfortunately, `print` can only be used locally. On the mainnet or when using Motoko Playground there is no concept of output stream so `Debug.print` has no effect.

`Debug.print()` only accepts a value of type `Text` as input. If you have any  object, you can use the `debug_show` command to automatically convert it to `Text`. 
```motoko
let array : [Nat] = [19, 8, 2, 5];
Debug.print(debug_show(array));
```
You can also use convertion functions
```motoko
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";
actor {
    let n : Nat = 5;
    Debug.print(Nat.toText(n));
}
```
## Trap
```motoko
func trap(errorMessage : Text) : None
```
WIP