# Calculator ➕✖️➖➗
## 🧑‍🏫 Requirements 
Your task is to create the code for a calculator, which is implemented as a canister. 
<br/> The canister should have a public interface that allows users to perform calculations. The canister has a memory variable called `counter` which represents the result of the most recent calculation.
## 📺 Interface
Your canister should implement the following interface:
```motoko
actor {
    add : shared(x : Float) -> async Float;
    sub : shared(x : Float) -> async Float;
    mul : shared(x : Float) -> async Float;
    div : shared(x : Float) -> async Float;
    reset: shared () -> async ();
    see: shared query () -> async Float;
    power: shared (x : Float) -> async Float;
    sqrt: shared () -> async Float;
    floor: shared () -> async Int;
};
```
## 📒 Steps
1. Define a mutable variable called `counter` of type `Float` that will be used to store the result of the most recent calculation.
2. Implement `add`, which accepts a value `x` of type `Float` and performs addition. 
3. Implement `sub`, which accepts a value `x` of type `Float` and performs subtraction.
4. Implement `mul`, which accepts a value `x` of type `Float` and performs multiplication.
5. Implement `div`, which accepts a value `x` of type `Float` and performs division. Make sure to guard against division by 0.
6. Implement `reset`, which reset the value of  `counter` by setting its value to zero.
7. Implement a `query` function `see` that returns the value of `counter`.
8. Implement `power`, which accepts a value `x` of type `Float` and returns the value of `counter` to the power of `x`.
9. Implement `sqrt`, which accepts a value `x` of type `Float` and returns the square root of `counter`.
11. Implement `floor`, which returns the largest integer less than or equal to `counter`.
12. Deploy the `Calculator` on the Internet Computer.
## Verification
WIP
