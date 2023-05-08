# Appendix 1: Deploying and managing a canister.
In this appendix, we will deploy, interact and mange a canister. To illustrate all those interactions we will deploy a canister called `Counter` and experiment with it.You just need to follow along and copy the code!
## Prequesites
Make sure that you have  `dfx` installed.
```motoko
$ dfx --version
dfx 0.12.0
```
> Your version can be different, as long as it is above 0.12.0. If not, run `dfx upgrade`. 
## Generating the project
We first need to deploy a canister. Follow the instructions:
1. Generate a new folder called `first_project`.
```bash
$ mkdir first_project
```
2. Move into your newly generated folder.
```bash
$ cd first_project
```
3. Create two files `dfx.json` & `main.mo`
```bash
$ touch dfx.json && touch main.mo
```
4. Copy & paste the following code in your `dfx.json` file
```json
{
    "canisters": {
      "Counter": {
        "main": "main.mo",
        "type": "motoko"
      }
    }
  }
```
`dfx.json` is a configuration file used by `dfx` to gather information about your project. Each project has one dfx.json file, even if it contains multiple canisters. <br/>

Within the `dfx.json` file, you can specify the list of canisters using the keyword "canisters" followed by a curly brace `{`. Each canister in the list is separated by a comma `,` .

In the provided example, there is only one canister named `Counter`. It is of type `motoko` and the main file is located in the same folder with the name `main.mo`. The main file always contains the `actor{}` definition. <br/>

> One `main.mo` file = One actor = One canister.

6. Copy & paste the following code in your `main.mo` file
```motoko
actor Counter {
    var i : Int = 0;

    public func add(j : Int) : async Int {
        i := i + j;
        i;
    };

    public func div(j : Int) : async Int {
        i := i / j;
        i;
    };

    public func reset() : async () {
        i := 0;
    };

    public query func show() : async Int {
        i;
    };
};
```

7. Start your local replica
```bash
$ dfx start
Running dfx start for version 0.12.0
Using the default definition for the 'local' shared network because /Users/seb/.config/dfx/networks.json does not exist.
Dashboard: http://localhost:57765/_/dashboard
```

> You can click and access the dashboard. It will give you information about your local replica (replica version, canisters deployed, number of consensus rounds since start..)

8. Create an empty canister for `Counter`.
```bash
$ dfx canister create Counter
Creating a wallet canister on the local network.
The wallet canister on the "local" network for user "seb" is "rwlgt-iiaaa-aaaaa-aaaaa-cai"
Creating canister Counter...
Counter canister created with canister id: rrkah-fqaaa-aaaaa-aaaaq-cai
```
`dfx` will automatically create a wallet for your `identity`. A wallet is necessary to hold cycles, which are necessary to create canisters. Only canisters can hold cycles and not your identity - that's why you need this wallet which acts as a proxy when you create and deploy canisters.

9. Compile your code into WASM. 
```bash
$ dfx build Counter
Building canisters...
Shrink WASM module size.
``` 
After this step, your Motoko file is compiled into a WebAssembly module, which size is optimised. You can find the module under `.dfx/canister/Counter/Counter.wasm`

> If you wanna know what is actually inside the module. You can [convert your WASM to the WAT format](https://webassembly.github.io/wabt/demo/wasm2wat/), it's a textual representation for the WASM binary.

10. Install the WASM inside the canister.
```bash
$ dfx canister install Counter
Creating UI canister on the local network.
The UI canister on the "local" network is "ryjl3-tyaaa-aaaaa-aaaba-cai"
Installing code for canister Counter, with canister ID rrkah-fqaaa-aaaaa-aaaaq-cai
```
**Congratulations! Your canister in now deployed.**

The **Candid** interface, allows inter-operation between services, and between services and frontends. **Candid** is also very useful for calling the canisters from different places:

- Using the terminal with `dfx`.
- Using the **Candid UI**.
- Using a frontend (webpage) with the **JavaScript Agent**.

## Using the terminal
The Candid interface allows you to call backend services or functions from the command line. This is useful for administrative tasks that do not require a front end or for testing the back end. In the example of the `Counter` dApp, you can call the `add` method by running the following command:

```bash
$ dfx canister call Counter add '(3)'
(3 : int) 
```
As you can probably guess from the previous example, the format for calling canisters using `dfx` is the following:
```bash
dfx canister call NAME_OF_CANISTER NAME_OF_FUNCTION '(ARGUMENTS)'
```
Notice that you should put your arguments betwen `'()'` and the format for arguments is the **Candid** syntax, the returned type is `int` and not `Int` like in Motoko. This distinction will matter more when we will deal with complex arguments (object, tuples, arrays..).

If you want to call a canister on the main net, you need to add the `--network ic` flag:
```bash
dfx canister --network ic call NAME_OF_CANISTER NAME_OF_FUNCTION '(ARGUMENTS)'
```

As we've seen before, we can **trap** the canister if we try to divide by 0.
```bash
$ dfx canister call Counter div '(0)'
Error: Failed update call.
Caused by: Failed update call.
  The Replica returned an error: code 5, message: "Canister rrkah-fqaaa-aaaaa-aaaaq-cai trapped: integer division by 0"
```
An important thing to note, is that the canister persits it's state by default. If we send another command:

```bash
$ dfx canister call Counter add '(5)'
(8 : int)
```
We can see that the value of `counter` is 8 - which corresponds to the two commands we've run so far. 
This property is called **orthogonal persistence**. Orthogonal persistence creates an illusion that a program runs forever without crashing or losing state. If you don't send command to your canister, it will kept the value of `counter` to 8 forever. 

> The term "**orthogonal persistence**" may sound complex, but in practice, it simply means that you can focus on writing code without the need to build a database to store the state. The state is automatically persisted by 
default, eliminating the need for additional storage infrastructure.

11. Copy & paste the following code in your `main.mo` file
```motoko
actor Counter {
    var i : Int = 0;

    public func add(j : Int) : async Int {
        i := i + j;
        i;
    };

    public func sub(j : Int) : async Int {
        i := i - j;
        i;
    };

    public func mult(j : Int) : async Int {
        i := i * j;
        i;
    };

    public func div(j : Int) : async Int {
        i := i / j;
        i;
    };

    public func reset() : async () {
        i := 0;
    };

    public query func show() : async Int {
        i;
    };
};
```

12. Recompile the code 
```motoko
$ dfx build Counter
```

13. Upgrade the canister with the new module
```motoko
$ dfx canister install Counter --mode upgrade
```

Now that we have upgraded our canister, if we look at the value of `counter` (
```motoko
$ dfx canister call Counter show 
(0 : int)
```

Yes, orthogonal persistence has limitations! <br/> 
Whenever we upgrade our canister, the state is wiped out and we start from 0 again. We will see in a future chapter that we can solve this issue, by using **stable memory** which is a memory that persists between upgrades. 

In the meantime, or more information about how to call canisters from the command-line, you can read the [documentation](https://internetcomputer.org/docs/current/references/cli-reference/dfx-canister) or simply run: 
```bash
$ dfx canister --help
```
## Using the Candid UI
While the command-line can be very practical, there's also an easier way to call the backend services, and that's by using the Candid UI. When a project is deployed, besides the Candid interfaces, an asset canister running the Candid UI is also deployed. The built process will show the URL in the console, but the URL can also be found in `/.dfx/local/canister_ids.json`:
```json
{
  "Counter": {
    "local": "rrkah-fqaaa-aaaaa-aaaaq-cai"
  },
  "__Candid_UI": {
    "local": "ryjl3-tyaaa-aaaaa-aaaba-cai"
  }
}
```
In this case the URL to the Candid UI is http://127.0.0.1:4943/?canisterId=ryjl3-tyaaa-aaaaa-aaaba-cai&id=rrkah-fqaaa-aaaaa-aaaaq-cai

> It's possible that the URL for the Candid UI may be different on your machine. Make sure to adjust the URL accordingly based on the canister IDs in your own file.

Simply click the **Query** button, and see the response in the 
**Output Log**.

**Local or Live?** 
One important confusion to avoid is the difference between the local & live Candid UIs:
- The live Candid UI is unique for the entire Internet Computer - you can access the interface of any dApp (assuming that the candid file has been shipped). By using the live Candid UI you can directly modify the state of a canister. 
- The local Candid UI that we tried earlier is only deployed on your local replica. It can only give you access to the canister that you've deployed locally.

> The CandidUI (live or local) is running in a canister.
