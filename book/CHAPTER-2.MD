# Chapter 2: Common programming concepts.
## Variables
A variable is a value that has an arbitrary name, defined by a declaration. <br/>
In Motoko, variables can be declared using either `let` or `var` keyword, followed by the assignment operator `=`

- Variables declared with `let` are immutable, meaning that their value cannot be changed once they are assigned. 
```motoko
let n = 1;
```
- Variables declared with `var` are mutable, their value can be reassigned to a new value at any time using the reassignment operator `:=`.

```motoko
var n = 1;
n := 2;
```

The syntax convention is to use `lowerCamelCase` for variable names & 
to use spaces around the `=` sign. Also, a variable declaration declaration ends with a semicolon `;` Whenever you declare a variable don't forget to end the declaration with `;` otherwise Motoko will complain.

If we try the following code:
```motoko
let n = 1;
n := 2;
```

An attempt is made to reassign a value to an immutable variable - that's why an error will occur. The specific error message will be `type error [M0073], expected mutable assignment target`. This  message indicates that the variable being reassigned is immutable and cannot be changed.

## Types
The **Motoko** language places a strong emphasis on types and is more strict in enforcing them compared to other general-purpose languages like **JavaScript** or **Python**. This strictness serves a purpose, as it helps prevent errors and issues. 

**Motoko** has static types, this means that each variable is assigned a specific type, which is determined before the program runs. The compiler checks each use of the variable to avoid errors that may occur during runtime. <br/>

To assign a type to a variable we use the `:` symbol, this is called **type annotation**.
```motoko
let age : Nat = 20;
let message : Text = "Of all the acts, the most complete is that of building";
let open : Bool = false;
```

You can generally omit the type declaration - the **Motoko** compiler will automatically guess the type to the variable based on the first value that you provide this is called **type inference**.
```
let age = 20;   // Will be assigned type Nat
```
> For the duration of the Bootcamp it is recommended to keep all type declarations to make things clearer, especially if you are new to typed languages.
## Comments.
A one-line comment is written by starting the line with `//`.
```motoko
// Hello! It is recommended to use comments to make your code more readable.
```

A comment can span into multiple lines, in that case you'll need to add `//` on each line.
```motoko
//  Sometimes you'll have a lot to say
//  In those cases 
//  You can use more than one line
```
## Functions.
### A simple example
To introduce functions - let's look at an example: here is an actor that is responsible to keep track of a counter. 
```motoko
actor Counter {
    var count : Nat = 0;

    public func setCount(n : Nat) : async Nat {
        count := n;
        return count;
    };

};
```

The keyword `func` is used to declare functions, followed by the name given to the function, in that case `increaseCount`. As for variables, the syntax convention is to use `lowerCamelCase` for function names.  <br/>

In Motoko, to when you declare a function you have to indicate the types of the arguments and return values.
- The parenthesis `()` are used for function arguments (inputs to the function). In this case,  this function takes a value `n` of type `Nat` as argument.
- After the function arguments, we annotate the return type of this function with `: async Nat`.


> You might be wondering why the return type for the `setCount` function is `async Nat` instead of simply `Nat`? <br/> The term `async` stands for asynchronous, which means that in the **Actor model** we discussed earlier, canisters or actors communicate with each other asynchronously. When one canister sends a request to another (or when a user calls a function), there will be a brief waiting period before the caller receives a response. <br/> 
Asynchronous programming allows you to run your code in a non-blocking manner. The `async Nat` return type for the `setCount` function indicates that the caller must wait for a few moments before receiving the return value. Eventually, the response will be a value of type `Nat`, but with a delay due to the asynchronous nature of the communication between canisters. **All public functions declared in the body of an actor must be of return type `async`**. 


- The curly brackets `{}` are used for the function body. The body of the function is a set of instructions executed when the function is being called.  T
In our example, for `setCount` we have 2 instructions:
1. Assign the value of `count` to the value of `n`. 
2. Return the current value of `count`.

Motoko allows to omit the `return` at the end of the body of the function, because a block always evaluates to its last expression. Which means, we could rewrite the code in the following way and it would still be valid:
```motoko
public func setCount(n : Nat) : async Nat {
    count := ;
    count;
};
```
### Public vs Private
WIP
### Function type
WIP
## Control flow.
Control flow refers to the order in which a program is executed and the order that it follows. It decides which statements, instructions or function calls are executed and in what order, based on conditions or decisions made during the run time. <br/>

We discuss three common control flow constructs in Motoko: `if else` expressions, `loops` expressions and `switch` expressions.
### If/else
The `if` statement allows the program to make a decision and execute a certain block of code only if a specific condition is met. The optional `else` statement provides an alternative if the condition is not met. 
```motoko
    func isEven(n : Nat) : Bool {
        if(n % 2 == 0){
            return true
        } else {
            return false
        };
    };
```
In this case, the condition `n % 2` will be tested at runtime and depending on the value of `n` will returns `true` or `false`.
In many cases the `else` block can be removed without modyfing the behavior of the code block.
```motoko
    func isEven(n : Nat) : Bool {
        if(n % 2 == 0){
            return true;
        };
        return false;
    };
```
In other cases, you can add `else if` blocks to check additional conditions.
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
Note that `else if` statements are used after the initial `if` statement to check additional conditions, and only the code block associated with the first condition that evaluates to true will be executed.
### Loops
Loops allow a block of code to be executed repeatedly until a specific condition is met. There are several types of loops, including `for` loops & `while` loops.
 - `for` loops in Motoko involves using an iterator of type `Iter`. If you are not familiar with `Iter`, don't worry it's a concept that we will explain later on.
```motoko
var count : Nat = 0;
for (x in Iter.range(0,10)){
    count += 1;
};
```
In this case, `Iter.range(0,10)` will loop over all natural numbers between 0 and 10 including both of the bounds. 
- You can also use `while` loops, in that case the loop will execute as long as the condition is met.
 ```motoko
var count : Nat = 0;
while (count < 10) {
    count += 1;
};
```
### Switch/case
WIP