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

    // Returns the default transfer fee
    balanceOf : shared query (account : Account) -> async (Nat);

    // Transfer tokens to another account
    transfer : shared (from: Account, to : Account, amount : Nat) -> async Result.Result<(), Text>;

    // Airdrop 1000 MotoCoin to any student that is part of the Bootcamp.
    airdrop : shared () -> async Result.Result<(),Text>;
}
```
## 📒 Pasos
1. Define una variable llamada `ledger`, que es un `TrieMap`. En esta estructura de datos, las claves son de tipo `Account` y los valores son de tipo `Nat` y representan el saldo de cada cuenta. Puedes usar las funciones auxiliares en `account.mo` para ayudarte.
2. Implementa `name`, que devuelve el nombre del token como un `Text`. El nombre del token es `MotoCoin`.
3. Implementa `symbol`, que devuelve el símbolo del token como un `Text`. El símbolo del token es `MOC`.
4. Implementa `totalSupply`, que devuelve el número total de tokens `MOC` en circulación.
5. Implementa `balanceOf`, que toma una `Account` y devuelve el saldo de esta cuenta.
6. Implementa `transfer` que acepta tres parámetros: un objeto `Account` para el remitente (`from`), un objeto `Account` para el destinatario (`to`) y un valor `Nat` para la cantidad a transferir. Esta función debe transferir la cantidad especificada de tokens de la cuenta del remitente a la cuenta del destinatario. Esta función debe devolver un mensaje de error envuelto en un resultado `Err` si el remitente no tiene suficientes tokens en su cuenta principal.
7. Implementa `airdrop` que agrega 100 MotoCoin a la cuenta principal de todos los estudiantes que participan en el Bootcamp.

Para implementar airdrop, usa la función `getAllStudentsPrincipal` en el canister con el ID `rww3b-zqaaa-aaaam-abioa-cai`, esto devuelve la lista de todos los principales de los estudiantes que participan en el Bootcamp.
```motoko
getAllStudentsPrincipal : shared () -> async [Principal];
```

