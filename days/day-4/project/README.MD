# MotoCoin 🪙
As your first week at the prestigious [Motoko School](https://twitter.com/MotokoSchool) comes to an end, you're in awe of the wealth of knowledge and collaborative spirit that surrounds you. The school is a hub of innovation and creativity, drawing the brightest minds from around the world to master the art of building on the Internet Computer.  🏗️

One evening, while exploring the school's virtual library, you stumble upon a hidden section filled with stories of the school's successful alumni. You're fascinated by their accomplishments, yet you notice a common theme: many have built incredible wealth, but only a few have given back to the school. 🫢

At the same time, you overhear a conversation about the school's financial struggles and its inability to provide adequate resources for students in need. This revelation weighs heavily on your mind, and you feel compelled to find a solution that bridges the gap between the school's prosperous alumni and its underfunded programs. 💸

Inspired by the alumni stories, you envision a digital token that connects the past, present, and future of the **Motoko School** – the **MotoCoin**. This token would allow alumni and other investors to invest in the school's future while supporting its present needs. 🌱

You share your idea with a group of enthusiastic students, and together, you begin working tirelessly to bring **MotoCoin** to life. Built on the Internet Computer, the **MotoCoin** would enable investors, students, contributors to participate to the school's growth and success. 🚀
## 🧑‍🏫 Requirements 
Your task is to create a ledger for a token that can be used as a currency for the school. The ledger is implemented as a canister.
## 📺 Interface
We define the following types:
```motoko
type Subaccount = Blob;
type Account = {
    owner : Principal;
    subaccount : ?Subaccount;
};
```
Your canister should implement the following interface:
```motoko
actor {
    // Returns the name of the token 
    name : shared query () -> async Text;

    // Returns the symbol of the token 
    symbol : shared query () -> async Text;

    // Returns the the total number of tokens on all accounts
    totalSupply : shared query () -> async Nat;

    // Returns the balance of the account
    balanceOf : shared query (account : Account) -> async (Nat);

    // Transfer tokens to another account
    transfer : shared (from: Account, to : Account, amount : Nat) -> async Result.Result<(), Text>;

    // Airdrop 100 MotoCoin to any student that is part of the Bootcamp.
    airdrop : shared () -> async Result.Result<(),Text>;
}
```
## 📒 Steps
1. Define a variable called `ledger`, which is a `TrieMap`. In this datastructure, the keys are of type `Account` and the values are of type `Nat` and represent the balance of each account. You can use the helper functions in `account.mo` to help you.
2. Implement `name` which returns the name of the token as a `Text`. The name of the token is `MotoCoin`.
3. Implement `symbol` which returns the symbol of the token as a `Text`. The symbol of the token is `MOC`.
4. Implement `totalSupply` which returns the total number of `MOC` token in circulation.
5. Implement `balanceOf` which takes an `account` and returns the balance of this account. If the account has never interacted with the ledger before, you will return 0.
6. Implement `transfer` that accepts three parameters: an `Account` object for the sender (`from`), an `Account` object for the recipient (`to`), and a `Nat` value for the amount to be transferred. This function should transfer the specified amount of tokens from the sender's account to the recipient's account. This function should return an error message wrapped in an `Err` result if the caller has not enough token in it's main account.
7. Implement `airdrop` which adds 100 MotoCoin to the main account of all students participating in the Bootcamp.

To implement airdrop - use the function `getAllStudentsPrincipal` on the canister with id `rww3b-zqaaa-aaaam-abioa-cai`, this returns the list of all principals of the students participating in the Bootcamp.
```motoko
getAllStudentsPrincipal : shared () -> async [Principal];
```

