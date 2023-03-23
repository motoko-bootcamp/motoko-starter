# Chapter 11: Handling errors.
## 🚥 The `Result` type.
The `Result` type is extremly useful in Motoko to handle errors, it is defined as a variant type. 
```motoko
type Result<Ok, Err> = {#ok : Ok; #err : Err}
```
It can be used by importing the [Result library](https://internetcomputer.org/docs/current/motoko/main/base/Result). 
The generics `Ok` and `Err` can be used to customize the types you want to return to return in case of success or error. 
Let's imagine the following situation: we want to create a `Result` type that indicates whether a student graduate or not. 
- If the student graduate we return the score of the student.
- If the student fails we return a variant that indicate the reason for failure (score too low, absent, cheating...).

```motoko
type Score = Nat; // The score of a student. 
type ExamFailed = {
    #ScoreTooLow : Nat;     //  The score of the student. 
    #Absent;    //  One reason for failing an exam.
    #Cheated;   //  Another one.
};
type ExamResult = Result.Result<Score, ExamFailed>;
```
It is common to use a variant type for `Err`. It enables a more granular control over the different types of errors and facilitate pattern matching.
```motoko
func sendMessageToStudent(result : ExamResult) : Text {
    switch(result) {
        case(#ok(score)){
            return ("Congrats 🎉 - you have graduated with a score of : " # Nat.toText(score));
        };
        case(#err(failure)){
            switch(failure){
                (#ScoreTooLow(score)){
                    return ("Unfortunately your score is below requirements. Next time you'll graduate! You had a score of : " # Nat.toText(score));};
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
`Result` is used for errors that are generally expected in your program and where you want to return something. In case of an unexpected and unrecoverable error you should `trap` your code. 
The best way to do so if to use the `Debug.trap()` method from the [Debug library](https://internetcomputer.org/docs/current/motoko/main/base/Debug) which allows you to pass an error message along the `trap`.
```motoko
func trap(errorMessage : Text) : None
```
Trapping can also be caused by `assert(false)`. Assertions allow you to conditionally trap when some Boolean test fails to hold, but continue execution otherwise.
```motoko
let n = 38;
assert n % 2 == 0; // traps when n not even
assert(false);  // always traps
```
## The `Error` type.
## Trap. 
## Try/Catch.