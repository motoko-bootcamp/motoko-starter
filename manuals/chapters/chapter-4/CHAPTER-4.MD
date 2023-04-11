# Chapter 4: Candid the language of the Internet Computer.
## Why do we need Candid? 
Let's imagine the following situation:

- We are writing a canister in **Motoko** and we have defined a value `n` of type Nat.
```motoko
let n : Nat = 5;
```
- We know  another canister that exposes a public function `square` that returns the `square` of the number provided - this canister is written in **Rust**.

We want to compute the square of our value `n`, but we are very lazy and we don't want to implement the `square` function in the **Motoko** canister, instead we want to make use of the already existing function in the **Rust** canister. That's possible and it will make use of **intercanister-calls** (a more advanced concept that we will see in more details in another lesson).

The problem is the following: `n` is of type `Nat` and the `square` function only accepts value of type `u128`. But, in **Motoko**, the type `u128` doesn't exist! It it is like trying to communicate in Spanish with someone that speaks Chinese.

<p align="center"> <img src="./assets/rust_motoko_situation.png" width="600px" style="border: 2px solid black;"> </p>
<p align="center"> Communication can be hard sometimes...</p>

> Composing services (i.e canisters) written in different languages is central to the vision of the **Internet Computer**. How do we solve this fundamental communication issue between canisters?

## What is an IDL?
We need to introduce an **Interface Description Language (IDL)**. An interface description language (**IDL**) is a generic term for a language that lets a program written in one language communicate with another program written in another unknown language.

**Candid** is an **IDL** describing the public services deployed in canisters on the **Internet Computer**. The Candid interface allows inter-operation between services, and between services and frontends, independently of the programming language used. <br/>

Candid solves the problem we raised earlier by enabling a mapping between types in different languages. 

<p align="center"> <img src="./assets/candid_mapping.png" width="600px" style="border: 2px solid black;"> </p>

## Candid file (.did)
A **Candid** file is a file with the .did extension - we can define the interface of the `square` canister with the following .did file:
```candid
service : {
  square: (nat) -> (nat) query;
}
```

In this case, our service has a unique function named `square`. This function takes a `nat` and returns a `nat`. Notice that we also used the keyword `query`.

<p align="center"> <img src="./assets/candid_solved.png" width="600px" style="border: 2px solid black;"> </p>
<p align="center"> Candid is the common ground for all canisters to solve their misunderstanding!</p>

The `nat` used here is not the same as the `Nat` type in **Motoko**, or any type in **Rust**. If the `square` canister was written in Motoko the Candid interface would be exactly the same. The description of the service is independent of the language it was written in - this is key!

Candid solves the problem we've raised earlier by enabling a mapping between types in different languages.

<p align="center"> <img src="./assets/candid_mapping.png" width="600px" style="border: 2px solid black;"> </p>

The type `u128` will be converted to `nat` which is then converted to `Nat` in the **Motoko** canister. This makes it possible to write the following code:

```motoko
actor {
    let n : Nat = 5;

    //We define the other canister in our own code.
    let rustActor : actor = {
        square : Nat -> Nat;    // We use Motoko types here  
    };

    public func getSquareOfN() : async Nat {
        await rustActor.square(n);  // This is how you can call another canister - pretty cool, right?! 
    };

};
```
> Candid is sometimes called "**the language of the Internet Computer**" as it how canisters communicate with each other. You will rarely have to write Candid but it's important to understand why Candid was created, how to read it, and how it works since you'll encounter Candid files in the projects you will work on. 
## Interacting with a canister
To follow along this part, it is strongly recommended that you deploy locally the sample greet application that is shipped with `dfx`.
1. Generate the code for this project by running
```bash
$ dfx new greet
```
2. Start your local replica.
```bash
$ dfx start --clean
```
3. Open another terminal tab & deploy the project.
```bash
$ dfx deploy 
```
The Candid interface is automatically generated when building a Motoko project, but it can also be written manually. In its simplest form, the Candid DID file contains a service description. When the project is deployed, the `greet.did` file will contain the following service description:
```candid
service : {
  greet: (text) -> (text) query;
}
```
> You can find the .did file under .dfx/local/canisters/greet_backend. If you don't see it make sure that you have built & deployed the project.

The greet dApp has one public function: `greet(text)`. From the service description we can see, that the greet() function takes a text and returns another text, and the service is a query function (faster execution). 

You can see more advanced uses of Candid in the [documentation](https://internetcomputer.org/docs/current/developer-docs/build/candid/candid-concepts) or in other examples [Motoko examples](https://github.com/dfinity/examples/tree/master/motoko).

The Candid interface, as previously mentioned, allows inter-operation between services, and between services and frontends. Candid is also very useful for calling the canisters from different places:
- Using the terminal with `dfx`. 
- Using the Candid UI. 
- Using a frontend (webpage) with the JavaScript Agent.  

<b> Let's take a look at those different methods! </b>

## <a id="using-the-terminal"> 📺 Using the terminal (dfx) </a>
The Candid interface allows you to call backend services or functions from the command line. This is useful for administrative tasks that do not require a front end or for testing the back end. In the example of the Greet dApp, you can call the greet() method by running the command:
```bash
$ dfx canister call greet_backend greet '("motoko")'
("Hello, motoko!")
```
The general structure for calling any method from any canister is as follows:
```bash
$ dfx canister call <CANISTER_NAME OR CANISTER_ID> <METHOD_NAME> '(ARGUMENT)'
```
If you want to call a canister on the main net, you need to add the --network ic flag:
```bash
$ dfx canister --network ic call <CANISTER_NAME OR CANISTER_ID> <METHOD_NAME> '(ARGUMENT)'
```
> Note that when using dfx you should always put your arguments between "**()**". The format for the arguments is the Candid format. 

For more information about how to call canisters from the command-line, see the [documentation](https://internetcomputer.org/docs/current/references/cli-reference/dfx-canister).

## <a id="candid-ui"> 📲 Candid UI </a>
While the command-line can be very practical, there's also an easier way to call the backend services, and that's by using the Candid UI. When a project is deployed, besides the Candid interfaces, an asset canister running the Candid UI is also deployed. The built process will show the URL in the console, but the URL can also be found in `greet/.dfx/local/canister_ids.json`:

```json
{
  "__Candid_UI": {
    "local": "r7inp-6aaaa-aaaaa-aaabq-cai"
  },
  "greet_backend": {
    "local": "rrkah-fqaaa-aaaaa-aaaaq-cai"
  },
  "greet_frontend": {
    "local": "ryjl3-tyaaa-aaaaa-aaaba-cai"
  }
}
```
In this case the URL to the Candid UI is http://127.0.0.1:4943/?canisterId=r7inp-6aaaa-aaaaa-aaabq-cai&id=rrkah-fqaaa-aaaaa-aaaaq-cai

> It's possible that the URL for the Candid UI may be different on your machine. Make sure to adjust the URL accordingly based on the canister IDs in your own file.

Simply click the **Query** buttons, and see the response in the Output Log.
<p align="center"> <img src="assets/candid_ui_local.png" width="600px" style="border: 2px solid black;"> </p>

<b> Local or Live? </b> <br/>
One important confusion to avoid is the difference between the local & live Candid UIs:

- The [live Candid UI](https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.ic0.app/) is unique for the entire Internet Computer - you can access the interface of any dApp (assuming that the candid file has been shipped). By using the live Candid UI you can directly modify the state of a canister. 

- The local Candid UI that we tried earlier is only deployed on your local replica. It can only give you access to the canister that you've deployed locally.

> By the way - the Candid UI (live or local) is also deployed in a canister.

## <a id="using-the-frontend"> 📑 Using Candid in the frontend </a>
The greet dApp has both a backend and a frontend, and the frontend accesses the backend services through the Candid interface. The project's source code is organized in the following three folders:

- declarations
- greet_backend 
- greet_frontend

Let's take a look at the frontend's JavaScript file located at `src/greet_frontend/src/index.js`. This file is responsible for handling the front-end logic of the greet dApp. The front-end and back-end are connected using the Candid interface which allows the front-end to access the back-end services.

```javascript
import { greet_backend } from "../../declarations/greet_backend";

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const button = e.target.querySelector("button");

  const name = document.getElementById("name").value.toString();

  button.setAttribute("disabled", true);

  // Interact with foo actor, calling the greet method
  const greeting = await greet_backend.greet(name);

  button.removeAttribute("disabled");

  document.getElementById("greeting").innerText = greeting;

  return false;
});
```
Two lines of code in this file are worth paying attention to. The first line is where the Candid service description is imported, and in this case, it's not the greet.did file but the index.js file. The Candid index.js is automatically generated when the project is built and imports the Motoko backend's services.

```javascript
import {greet_backend } from "../../declarations/greet_backend";
```
After importing the Candid interface we can now use the public backend service, which is illustrated in this line:

```javascript
const greeting = await greet_backend.greet(name);
```
The update function `greet()` is called with the name as a parameter, which will return the greeting message. The call is asynchronous so an **await** is added so the front end is waiting for a response before moving on. 

Several agents are developed by both DFINITY and the community to easily integrate the Candid interface in different programming languages. See the [documentation](https://internetcomputer.org/docs/current/developer-docs/build/agents/) for a list of the available agents.