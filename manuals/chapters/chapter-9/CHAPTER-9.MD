# Chapter 9: Handling errors.
In Motoko, when something doesn't work as expected, there are various ways to show that an error has occurred. Some methods include:
- Using the `Result` type.  
- Throwing error with the `throw` keyword or the `Error` library.
- Trapping the program. 

In this section we will see different options and learn when to use each one for managing errors effectively.
## 🚥 The `Result` type.
The `Result` type is extremly useful in Motoko to handle errors, it is defined as a variant type. 
```motoko
type Result<Ok, Err> = {#ok : Ok; #err : Err}
```
With `Ok` and `Err`, you can specify the types to return based on success or failure. For example, when creating a Result type for student graduation:

```motoko
type Score = Nat; // The score of a student. 
type ExamFailed = {
    #ScoreTooLow : Nat;     //  The score of the student. 
    #Absent;    //  One reason for not passing an exam.
    #Cheated;   //  Another reason for not passing an exam.
};
```
- If a student graduates, their score is returned. The score is of type `Score`, which is an alias for `Nat`.
- If a student fails, a variant indicating the reason for failure is returned. The variant is of type `ExamFailed`.

Now we can use those new types to replace `Ok` and `Err`.
```motoko
type ExamResult = Result.Result<Score, ExamFailed>;
```
In cases like our example, using a variant type for `Err` is quite common. It allows for better management of different error types and makes pattern matching easier. This means anyone reviewing the error can better understand its specific cause!
```motoko
func sendMessageToStudent(result : ExamResult) : Text {
    switch(result) {
        case(#ok(score)){
            return ("Congrats 🎉 - you have graduated with a score of : " # Nat.toText(score));
        };
        case(#err(failure)){
            switch(failure){
                (#ScoreTooLow(score)){
                    return ("Unfortunately your score is below requirements. Next time you'll graduate! You had a score of : " # Nat.toText(score));
                };
                case(#Absent){
                    return ("You were absent at the exam. Please schedule another time.");
                };
                case(#Cheated){
                    return("Cheating is a short-term gain that leads to long-term pain");
                };
            };
        };
    };
};
```
### When should I use the Result type?
Using `Result` to report errors in your API offers a significant benefit: it allows other developers and programs to handle errors predictably. That's why `Result` is often used for expected errors in your program when you want to return a value. `Result` will not impact the normal behavior of the program.
## 🪤 Trap & assertions
A **trap** is a type of error that occurs during the execution of a message and cannot be resolved. The most common causes of traps are:
- Division by zero.
```motoko
let a : Nat = 5;
let b : Nat = 0;
let c = a / b;
```
- Index is out of bounds. 
```motoko
let names : [Text] = [];
```
- Assertion failure
```motoko
assert(false);
```
In some situations, it can be useful to trap on purpose, with a defined message.

The best way to do so if to use the `Debug.trap()` method from the [Debug library](https://internetcomputer.org/docs/current/motoko/main/base/Debug) which allows you to pass an error message along the `trap`.
```motoko
func trap(errorMessage : Text) : None
```
### Assertions
Using the `assert` keyword to construct assertions lets you check if a certain condition is met. If the condition inside `assert()` is `false`, the program will stop running. If it's `true`, the program will continue as normal.
```motoko
assert(2 == 1);  // always traps
```
```motoko
assert n % 2 == 0; // traps only when n not even
```
```motoko
assert(true) // never traps
```
### When should I use a Trap?
Traps immediately stop the current task (i.e message) being executed by a canister, but they don't prevent the canister from handling future requests. Traps should be used for unexpected situations. For example, the `unwrap` function below:
```motoko
/// Unwraps the value of the option.
public func unwrap<T>(option : ?T) : T {
    switch option {
        case (?value)
            value;
        case null
            Debug.trap("Value is null - impossible to unwrap")
    }
};
```
> Traps have a very useful feature: if a function traps, the canister's state will be reverted. This will be discussed further in the context of [inter-canister calls](../chapter-11/CHAPTER-11.MD#commit-point-and-rollbacks).
## 🔀 Handling asynchronous errors with the `Error` type and try/catch.
> In this section the term **error** refers specifically to any value of type `Error`.

In Motoko, error handling can be a bit confusing, especially if you are used to error handling in other programming languages. Here are some key points to keep in mind:

- Errors can be thrown using the `throw` keyword.
- Errors can be handled using the `try/catch` pattern.
- An error is of type `Error`, which can also be manipulated using the Error library.

However, error handling in Motoko can only be done in an asynchronous context. This means that you can only throw or catch errors in the body of a shared function.
In this example, we define an actor that contains two functions: `throwErrorSync` and `throwErrorAsync`. 
```motoko
import Error "mo:base/Error";
actor {
  // Misplaced throw 
  func throwErrorSync() : () {
    throw Error.reject("This will not work")
  };

  // Can throw an error in a shared/public function - this error will be consumed by another canister/user calling this function.
  public func throwErrorAsync() : async () {
    throw Error.reject("This will not work")
  };
}
```
> You can see this example [in the Motoko Playground](https://m7sm4-2iaaa-aaaab-qabra-cai.ic0.app/?tag=907568632) - note the `misplaced throw` message in the body of `throwErrorSync`.

The `try/catch` pattern in Motoko is particularly useful when you are attempting to call another canister and want to handle any possible errors that may occur during the call. This can include situations such as:

- The target canister is not live or cannot be reached.
- The function being called does not exist on the target canister.
- The function being called traps, either due to a programming error or because it has run out of resources.
- The function being called throws an error that needs to be handled.

Assuming this is our canister A - deployed with canister id: 
```motoko
actor {
    public func foo() : async Text {
        return "foo"
    };   
}
```
Assuming this is our canister B
```motoko
actor {

    let canisterA = actor("xxx") : actor {
        foo : shared () -> async Text;
    };

    public func fooFromCanisterA() : async Text {
        try {
            let foo = await canisterA.foo()
            return foo;
        } catch (e) {
            return "An error occured when calling canister A".
        };
    };   
}
```
In the provided example, we have two canisters: **Canister A** and **Canister B**. 
- **Canister A** has a single public function `foo` that returns the text "foo". 
- **Canister B** has a public function `fooFromCanisterA` that attempts to call the `foo` function on **Canister A** using the `try/catch` pattern. If the call to `canisterA.foo()` is successful, the function returns the value of `foo`. If an error occurs during the call, it is caught by the catch block, and the function returns the text `"An error occurred when calling canister A"`.

This example illustrates how the `try/catch` pattern can be used to handle errors when calling functions on other canisters, ensuring that your program continues to execute gracefully even if an error occurs during the call.

## 🤔 Final words 
Dealing with all these different situations and ways of handling unexpected issues can be confusing at first, especially when it comes to the `actor` model and asynchronous contexts. But don't stress if you don't get it all right away. The best way to understand it is to get some practice and as you'll encounter different situations your understanding will strengthen! 