# Chapter 12: Upgrading a canister. 
Upgrading a canister is a common task. However, there are a few things to consider before doing so, notably:
- Could the upgrade cause data loss?
- Could the upgrade break the dApp due to interface changes?
## Stable memory vs Heap memory.
A canister has access to two types of memories: 
1. A wasm heap which is constrained to 4 GiB because currently the runtime of canisters [wasmtime](https://github.com/bytecodealliance/wasmtime) has only 32 bit addressing. This limit will be increased when [wasm64](https://github.com/WebAssembly/memory64) is supported by the runtime. The heap is a “pile" of memory, it is space available to the canister to allocate and de-allocate as needed. The heap is wiped during upgrades. The heap is the fastest memory available to the canister.

2. A [stable memory](https://internetcomputer.org/docs/current/references/ic-interface-spec#system-api-stable-memory) that can currently store up to 48GiB of storage. Everything in stable memory will survive upgrades. Accessing data in stable memory is slower compared to accessing memory in the heap because stable memory is not directly accessible within the runtime environment. Instead, accessing stable memory requires calling an external API.

> Developers who are new to the IC often ask the question: which memory should I use? Unfortunately, there is no one-size-fits-all answer to this question. The optimal choice depends on the requirements of your application (safety during upgrade over performances) and the amount of memory you'll need. If you are interested, [read & join the discussion over this topic that is constantly evolving](https://forum.dfinity.org/t/motoko-stable-memory-in-2022/10433). 
## Stable variables.
When a canister is upgraded, the state is lost by default. This means all data application data will be lost, unless it's handled to persist when the canister is upgraded. <br/>
This can be achieved by storing the data in stable variables, which will persist upgrades. To declare a variable as stable we use the `stable` keyword.
```motoko
stable var m : Int = 0;
```
The value of `m` will persits upgrades and not be lost. 
A stable variable is stored in the stable memory.
## Stable types.
Unfortunately, not all variables can be declared as stables. 
```motoko
stable let map = HashMap.HashMap<Principal, Student>(1, Principal.equal, Principal.hash);
```
If we try with the `HashMap` type that we've seen earlier we will encounter an error: `variable map is declared stable but has non-stable type`. 

All primitives types are stable:
- `Nat` 
- `Text`
- `Ìnt`
- All bounded numbers: `Nat8`, `Nat16`, `Nat32`, `Nat64`, `Int8`, `Int16`, `Int32`, `Int64`.
- `Float`
- `Char`
- `Bool`
- `Array`

An object that contains methods (i.e a Class) cannot be stable. That's why `HashMap` & `TrieMap` cannot be declared as stable structures.

> It is possible to rewrite some libraries to convert them to stable types. For instance, [StableBuffer](https://github.com/canscale/StableBuffer) is a remake of the `Buffer` type allowing it to be called stable. 
## Interface changes.
Another challenge when upgrading a canister in a distributed environment like the Internet Computer is that other canisters might be relying on the interface of the canister being upgraded.

Let's imagine that we have two canisters:
1. Canister A is the canister that we want to upgrade. It contains many public functions but we will just focus on `getDiploma`.
```motoko
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Time "mo:base/Time";
actor School {

    type Diploma = {
        delivery_time : Time.Time;
        teacher : Principal;
        promotion : Nat;
    };

    let diplomas = HashMap.HashMap<Principal, HashMap>(0, Principal.equal, Principal.hash);

    public func getDiploma(p : Principal) : async ?Diploma {
        return diplomas.get(p);
    };

};
```

2. Canister B is the client canister that is relying on the interface of Canister A. We have to imagine that somewhere in the code of Canister B the `getDiploma` function of Canister A is called.
[TODO : Change canister ID];
```motoko
actor dApp {
    type Diploma = {
        delivery_time : Time.Time;
        teacher : Principal;
        promotion : Nat;
    };

    // We define the other canister in the code here.
    let schoolActor : actor {
        getDiploma(p : Principal) -> async ?Diploma;
    } =  actor("3db6u-aiaaa-aaaah-qbjbq-cai"); 

    public func shared ({ caller }) isAuthorized() :  async Bool {
        let answer = await schoolActor.getDiploma(caller);
        switch(answer){
            case(null){
                return false;
            };
            case(? some){
                return true;
            };
        };
    };
};
```
Suppose we're upgrading canister A and we decide to remove the `getDiploma` function. If we do that, it will cause problems for canister B because it relies on that function. But it's not just removing the function that could cause issues. If we modify the function's signature to something like this:

```motoko
getDiploma(p : Principal) -> async Result.Result<Diploma, Text>;
```
That change alone would also break canister B's code.
Whenever a canister on the IC is upgraded, it causes a risk to all relying canisters, we have to find a way to not break things! <br/>

That's where the magic of **Candid** comes into play! <br/> 
Candid defines a formalism and precise rules to make sure that any modification of the interface (adding new methods, changing function signatures, expecting additional arguments...) doesn't break existing clients.

For instance, evolving the signature of the `getDiploma` function from 
```motoko
getDiploma(p : Principal) -> async ?Diploma;
```
to
```motoko
getDiploma(p : Principal, bootcampYear: ?Nat) -> async ?Diploma;
```
Would not cause an issue, when reading messages from old clients, who do not pass that argument, a `null` value is assumed.

> In the following, all types and interfaces are exprimed in Candid format.

Let's look at more examples of what can and can't be done. Imagine the following service
```
service counter : {
  add : (nat) -> ();
  subtract : (nat) -> ();
  get : () -> (int) query;
}
```
The function `add` could evolve from 
```
add : (nat) -> ();
```
to 
```
add : (int) -> ();
```
This is possible because every `nat` is also an `int`. If a client provides a `Nat` it will be compatible with the new expected type. We say that `int` is a supertype of `nat`. However evolving the other way wouldn't be possible since all `int` are not `nat`. 

Additionally the function `add` and `substract` could evolve from
```
add : (nat) -> ();
subtract : (nat) -> ();
```
to 
```
add : (nat) -> (new_val : nat);
subtract : (nat) -> (new_val : nat);
```
This is possible because any new returned value that is not expected by old clients will simply be ignored. However, adding new (non-optional) parameters wouldn't be possible. 

To safely upgrade a canister, follow those rules:
- New methods can freely be added. 
- Existing methods can return additional values. Old clients will simply ignore additional values.
- Existing methods can shorten their parameter list. Old clients will send the extra argument(s) but they will be ignored.
- Exisiting methods can only add optional types as new parameters (type `opt`). When reading messages from old clients, who do not pass that argument, a `null` value is assumed.
- Existing parameter types may be changed, but only to a `supertype` of the previous type. For instance a `nat` parameter can be changed to a `int`. 
- Existing result types may be changed, but only to a `subtype` of the previous type. For instance an `int` result can be changed to a `nat`. 

> If you want more information on Candid, supertypes and subtypes, check the [reference guide](https://internetcomputer.org/docs/current/references/candid-ref).
## Data structure changes.
Another example of how data can be lost, is by changing the data types. 

```motoko
stable var state : Int
```
In this example the variable `state` is `Int`, but let's imagine that during an update the type is changed to `Text`
```motoko
stable var state : Text
```
In this case the the current `Int` value will be lost. One way to avoid the data loss when changing the data types is to keep the original variable, and create a new variable for the new data type. This way the original data will not be lost due to canister upgrades.
## Stable type signature.
The list of all stable variables of an actor is called the **stable signature**. The textual representation of the **stable signature** looks similar to an actor declaration.
```motoko
actor {
  stable x : Nat;
  stable var y : Int;
  stable z : [var Nat];
};
```
> The stable signature of an actor can be generated using the Motoko compiler: [moc](https://internetcomputer.org/docs/current/motoko/main/compiler-ref).

The stable signature is used to automatically check type compability before an upgrade. This is possible by comparing the signature of the new actor with the old one and using some rules based on Candid. For more information, see the [reference section on stable signatures](https://internetcomputer.org/docs/current/motoko/main/upgrades#stable-type-signatures).
## Metadata section.
The Motoko compiler embeds the **Candid interface** and **stable signature** of a canister as canister metadata, recorded in additional Wasm custom sections of a compiled binary.

This metadata can be selectively exposed by the IC and used by tools such as `dfx` to verify upgrade.
```
$ dfx canister metadata [OPTIONS] <CANISTER_NAME> <METADATA_NAME>
```
## Checking upgrade compatibility
When you upgrade a canister, `dfx` will automatically download the metadata of the old module and compare it with the new module:
- Compare the Candid interface to make sure there is no breaking change.
- Compare the stable signatures to make sure there won't be data loss.

If you are making a breaking change you will receive a warning. 

<p align="center"> <img src="assets/candid_warning.png" width="800px" style="border: 2px solid black;"></p>
<p align="center"> The type of warning you will encounter. </p>

This verification doesn't guarantee that the upgrade will go through. A problem can still happen during the upgrade process. However, it does guarantee that if the upgrade goes through you won't break existing cliens or lose data that was marked as `stable`. 