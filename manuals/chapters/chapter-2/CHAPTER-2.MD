# Chapter 2: Common programming concepts.
## 📦 Variables 
A variable is a value that has an arbitrary name, defined by a declaration. <br/>
In Motoko, variables can be declared using either the `let` or `var` keyword, followed by the assignment operator `=`

- Variables declared with `let` are immutable, meaning that their value cannot be changed once they are assigned. 
```motoko
let n = 1;
```
- Variables declared with `var` are mutable, their value can be reassigned to a new value at any time using the reassignment operator `:=`.

```motoko
var n = 1;
n := 2;
```

The syntax convention is to use `lowerCamelCase` for variable names and to use spaces around the `=` sign. Also, a variable declaration ends with a semicolon `;` Whenever you declare a variable don't forget to end the declaration with `;` otherwise Motoko will complain.

If we try the following code:
```motoko
let n = 1;
n := 2;
```

An attempt is made to reassign a value to an immutable variable - that's why an error will occur. The specific error message will be `type error [M0073], expected mutable assignment target`. This  message indicates that the variable being reassigned is immutable and cannot be changed.
## 🍎 Types
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
## 💬 Comments.
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
## ⚙️ Functions
This section focuses solely on functions that are defined within the body of an actor using the `actor {}` syntax. Any function that is outside the `actor {}` syntax will be covered in future chapters.
### A simple example
To introduce functions - let's look at an example: here is an actor that is responsible to keep track of a  counter. 
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

### Function type
When defining a function in Motoko, the typed arguments and return type are used to determine the type of the function as a whole. For example, the function setCount has the following type:
```motoko
setCount : (n : Nat) -> async Nat;
```
To declare a function in Motoko, you must specify the types of the arguments and return values. Function arguments are enclosed in parentheses `()`, and in this case, the function takes an argument `n` of type `Nat`. After the function arguments, the return type is specified : `async Nat`.

> You might be wondering why the return type for the `setCount` function is `async Nat` instead of simply `Nat`? <br/> The term `async` stands for asynchronous, which means that in the **Actor model** we discussed earlier, canisters or actors communicate with each other asynchronously. When one canister sends a request to another (or when a user calls a function), there will be a brief waiting period before the caller receives a response. <br/> 
Asynchronous programming allows you to run your code in a non-blocking manner. The `async Nat` return type for the `setCount` function indicates that the caller must wait for a few moments before receiving the return value. Eventually, the response will be a value of type `Nat`, but with a delay due to the asynchronous nature of the communication between canisters. **All public functions declared in the body of an actor must be of return type `async`**. 

### Body and return
- The curly brackets `{}` are used for the function body. The body of the function is a set of instructions executed when the function is being called.
In our example, for `setCount` we have 2 instructions:
1. Assign the value of `count` to the value of `n`. 
2. Return the current value of `count`.

Motoko allows to omit the `return` at the end of the body of the function, because a block always evaluates to its last expression. Which means, we could rewrite the code in the following way and it would still be valid:
```motoko
public func setCount(n : Nat) : async Nat {
    count := n;
    count;
};
```
### Public vs Private
So far we've only seen `public` functions. However, in Motoko you can also define `private` functions. 
```motoko
private func add(n : Nat, m : Nat) : Nat {
    return (n + m)
};
```
The function is now marked `private`, this means that it can only be used by the actor himself and cannot be called directly by users or external canisters.

Usually `private` functions are used as helpers in other functions, that are generally defined as `public`. For instance we could write the following.

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

> We can remove the `private` keyword , a function declaration defaults to a private function in Motoko unless declared otherwise (i.e unless declared `public`).

## 🕹️ Control flow.
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
Loops enable the repeated execution of a code block until a specific condition is fulfilled. There are various types of loops, such as `for` loops and `while` loops:
- `for` loops in Motoko use an iterator of the `Iter` type. We will delve into the `Iter` type in a later chapter, but to summarize, `Iter` objects facilitate looping through collections of data.
```motoko
var count : Nat = 0;
for (x in Iter.range(0, 10)) {
    count += 1;
};
```
In this example, `Iter.range(0, 10)` iterates through all natural numbers between 0 and 10, inclusive of both boundaries.

Alternatively, you can use `while` loops, which executes as long as the specified conditions remains true.

```motoko
var count : Nat = 0;
while (count < 10) {
    count += 1;
};
```
Here, the loop will continue to execute until the `count` variable is no longer less than 10.
### Switch/case
The `switch` expression in Motoko is a control flow construct that matches patterns based on its input. It begins with the `switch` keyword, followed by the input expression enclosed in parentheses `()`, and a code block enclosed in curly braces `{}`.
```motoko
let x = 3;
switch(x) {
    //
};
```
Within the code block, the `case` keyword is used to define patterns and expressions enclosed in curly braces `{}`. The input is compared to the patterns specified in each case, and if a match is found, the expression within the corresponding `case` block is executed.
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
In Motoko, it is mandatory to include a `case(_)` statement for every possible input value in a `switch` expression. This is why the case(`_`) pattern is sometimes used as a catch-all case to handle any input value that did not match any of the other cases. The underscore symbol (`_`) is a wildcard that matches any value, so the `case(_)` pattern will match any input value.

The `switch/case` expression is best used with variants.

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
In this example, we defined a variant type `Day`, declared a variable `day` with that type, and then used it as input in our `switch` expression. The switch expression is a powerful control flow construct that allows for pattern matching, providing a concise and readable way to handle multiple cases based on the input value.