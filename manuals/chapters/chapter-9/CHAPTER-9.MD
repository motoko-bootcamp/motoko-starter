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
## Asynchronous error with Try/Catch
## Trap & assertions
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
## The `Error` type.
WIP