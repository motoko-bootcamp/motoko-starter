# MotoCoin 🪙
As your first week at the prestigious [Motoko School](https://twitter.com/MotokoSchool) comes to an end, you're in awe of the wealth of knowledge and collaborative spirit that surrounds you. The school is a hub of innovation and creativity, drawing the brightest minds from around the world to master the art of building on the Internet Computer.  🏗️

One evening, while exploring the school's virtual library, you stumble upon a hidden section filled with stories of the school's successful alumni. You're fascinated by their accomplishments, yet you notice a common theme: many have built incredible wealth, but only a few have given back to the school. 🫢

At the same time, you overhear a conversation about the school's financial struggles and its inability to provide adequate resources for students in need. This revelation weighs heavily on your mind, and you feel compelled to find a solution that bridges the gap between the school's prosperous alumni and its underfunded programs. 💸

Inspired by the alumni stories, you envision a digital token that connects the past, present, and future of the **Motoko School** – the **MotoCoin**. This token would allow alumni and other investors to invest in the school's future while supporting its present needs. 🌱

You share your idea with a group of enthusiastic students, and together, you begin working tirelessly to bring **MotoCoin** to life. Built on the Internet Computer, following the latest **ICRC_1** standard, the **MotoCoin** would be a decentralized and transparent ledger enabling investors, students, contributors to contribute to the school's growth and success. 🚀
## 🧑‍🏫 Requirements 
Your task is to create a ledger for a token that can be used as a currency for the school. The ledger is implemented as a canister and must follow the [ICRC_1](https://internetcomputer.org/docs/current/developer-docs/integrations/icrc-1/) standard.
## 📺 Interface
```motoko
actor {
    // Returns the name of the token 
    icrc1_name : shared query () -> async (Text);

    // Returns the symbol of the token 
    icrc1_symbol : shared query () -> async (Text);

    // Returns the number of decimals the token uses
    icrc1_decimals : shared query () -> async (Nat8);

    // Returns the default transfer fee
    icrc1_fee : shared query () -> async (Nat);

    // Returns the total number of tokens on all accounts 
    icrc1_total_supply : shared query () -> async (Nat);

    // Returns the minting account if this ledger supports minting and burning tokens.
    icrc1_minting_account : shared query () -> async (?Account);

    // Returns the balance of the account given as an argument.
    icrc1_balance_of : shared query (Account) -> async (Nat);

    // Transfers tokens
    icrc1_transfer : shared (TransferArgs) -> async (Result<Nat, TransferError>);


    // Returns the list of metadata entries for this ledger. 
    icrc1_metadata : shared query () -> async ([(Text, Value)]);

    // Returns the list of supported_standards
    icrc1_supported_standards : shared query () -> async ([{
        name : Text;
        url : Text;
    }]);
}
```
## 📒 Steps
Because, it's day 4, this time you'll have less guidance. But in order to complete the project you'll need to respect the following instructions: 
- The name of the token is **MotoCoin**.
- The symbol is **MOC**.
- The decimal is 8.

> You can find [some help](https://olm72-siaaa-aaaal-qbtpa-cai.ic0.app/internet-computer-standards/icrc1.html) in the MotokoBook.