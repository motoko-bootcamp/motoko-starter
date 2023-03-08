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
    max: shared (x : Float) -> async Float;
    floor: shared () -> async Int;
};
```
## 📒 Steps
- Step 1️⃣: Define a mutable variable called `counter` of type `Float` that will be used to store the result of the most recent calculation.
- Step 2️⃣: Implement the following functions:
    - `add`, which accepts a value `x` of type `Float` and performs addition.
    - `sub`, which accepts a value `x` of type `Float` and performs subtraction.
    - `mul`, which accepts a value `x` of type `Float` and performs multiplication.
    - `div`, which accepts a value `x` of type `Float` and performs division. Make sure to guard against division by 0.
    - `reset`, which reset the value of  `counter` by setting its value to zero.
- Step 3️⃣: Implement a `query` function `see` that returns the value of `counter`.
- Step 4️⃣: Implement the following functions:
    - `power`, which accepts a value `x` of type `Float` and
    - `sqrt`, which accepts a value `x` of type `Float` and
    - `max` , which accepts a value `x` of type `Float` and
    - `floor`, which returns 
- Step 5️⃣: Deploy the canister on the Internet Computer.
## Verification
WIP