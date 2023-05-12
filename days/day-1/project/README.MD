# Calculator ➕✖️➖➗
On your first day of class, you enter the halls, eager to embark on the journey of a lifetime. Little do you know that you have forgotten to bring one essential tool to class — a **calculator**. 😳 <br/> 

Your professor, a renowned expert in the community, begins the day's lesson by presenting a series of complex mathematical problems that require the use of a calculator. The students around you huddle together, pulling out their calculators to tackle the challenge. 💪 <br/>

As you search your bag in vain for your calculator, you realize that you have inadvertently left it behind. Instead of panicking or admitting defeat, your resourceful nature kicks in. You decide to rely on your intelligence and aptitude in Motoko to create your own calculator. 🧑‍💻
## 🧑‍🏫 Requirements 
Your task is to create the code for a **calculator**, which is implemented as a canister. 
<br/> The canister should have a public interface that allows users to perform calculations. The canister has a memory variable called `counter` which represents the result of the most recent calculation.
## 📒 Steps
1. Define a mutable variable called `counter` of type `Float` to store the result of the most recent calculation.
2. Implement the `add` function, which accepts a value `x` of type `Float`, increments the counter, and returns its new value.
```motoko
add : shared(x : Float) -> async Float;
```
3. Implement the `sub` function, which accepts a value `x` of type `Float`, decrements the counter, and returns its new value.
```motoko
sub : shared(x : Float) -> async Float;
```
4. Implement the `mul` function, which accepts a value `x` of type `Float`, multiplies it with the counter, and returns the new value of the counter.
```motoko
mul : shared(x : Float) -> async Float;
```
5. Implement the `div` function, which accepts a value `x` of type `Float`, divides the counter by `x`, and returns the new value of the counter. Ensure to guard against division by zero.
```motoko
div : shared(x : Float) -> async ?Float;
```
6. Implement the `reset` function, which sets the value of counter to zero, effectively resetting it.
```motoko
reset: shared () -> async ();
```
7. Implement the `see` function, which serves as a query and returns the current value of counter.
```motoko
see: shared query () -> async Float;
```
8. Implement the `power` function, which accepts a value `x` of type `Float`, raises the counter to the power of `x`, and returns the new value of the counter.
```motoko
power: shared (x : Float) -> async Float;
```
9. Implement the `sqrt` function, which calculates the square root of the counter and returns the new value of the counter.
```motoko
sqrt: shared () -> async Float;
```
10. Implement the `floor` function, which returns the largest integer less than or equal to the counter.
```motoko
floor: shared () -> async Int;
```
11. Deploy the `Calculator` on the Internet Computer.
## 📺 Interface
> At the end of the project, your canister should implement the following interface.
```motoko
actor {
    add : shared(x : Float) -> async Float;
    sub : shared(x : Float) -> async Float;
    mul : shared(x : Float) -> async Float;
    div : shared(x : Float) -> async ?Float;
    reset: shared () -> async ();
    see: shared query () -> async Float;
    power: shared (x : Float) -> async Float;
    sqrt: shared () -> async Float;
    floor: shared () -> async Int;
};
```