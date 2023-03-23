# Chapter 12: Identity on the Internet Computer.
## The concept of Principal.
A principal is a public identifier used to identify entities that can interact with the Internet Computer. These entities are either users or canisters. We distinguish different types of principals
- **Self-authenticating ids** (User): for an user, a principal is directly derived from it's public key. For instance, you can read the principal of your `dfx` identity. These Principals are 29 bytes long.
```motoko
$ dfx identity get-principal
2ujkt-fujau-bunuv-gt4b6-2s27j-cv5qi-kddkp-jl7m4-wdj3e-bqdrt-qqe
```
- **Opaque ids** (Canister): for a canister, the principal is the canister ID. The ID is automatically determined when the canister is created based on the subnet the canister is in and the number of canisters already deployed.
- **Anonymous id** (Anonymous): is the default caller used when an unauthenticated user calls functions. For instance, if you need to present information from a canister on a webpage before the user logs in, you would call functions to fetch the information, and your canister would recognize the caller as the Anonymous id because the user's Principal is unknown until they log in.

> There actually exist [two other types of principals](https://internetcomputer.org/docs/current/references/ic-interface-spec#id-classes) which you will never encounter. Those are used internally by the protocol or reserved for future potential usages. 

Principals in Motoko are a primitive type called `Principal`. 
## Accessign the user principal
Within your actor, you can access the principal of the person calling your function by adding the `shared (message)` syntax. This keyword needs to be placed immediately before the `func` keyword and after the `public` keyword. This allows you the inspect the message. 
The message as a property `caller` that you can access by using `message.caller`. This property corresponds to the principal of the entity (user or canister) calling the function.

> Message is a special object that is available to all `public shared functions`. As of today, it is only used for accessing the `caller` property but it might have other use cases in the future.

```motoko
actor {

    public shared (message) func returnCallerPrincipal() : async Principal {
        let p = message.caller;
        return p;
    };
};
```
Principals have a textual representation. We can convert a `Principal` to his textual representation by using `Principal.toText()` from the [Principal module](https://internetcomputer.org/docs/current/motoko/main/base/Principal). Alternatively, we can get a `Principal` from his textual representation by using `Principal.fromText()`.

```motoko
let p : Principal = message.caller;
let textualRepresentation : Text = Principal.toText(p); // => "un4fu-tqaaa-aaaab-qadjq-cai"
let standardRepresentation : Principal = Principal.fromText(textualRepresentation); 
```

It can be useful to know if the caller is authenticated or not. There is dedicated function `Principal.isAnonymous` that returns a `Bool` indicating if the user is anonymous or not. 
```motoko
let p : Principal = message.caller;
let isAnonymous : Bool = Principal.isAnonymous(p);
if(isAnonymous){
    return ("Sorry only authenticated users can access this app!");
};
```
> The textual representation of the anonymous principal is `2vxsx-fae`. Make sure to remember it as you will often come accross it.

One last tip! We can use object destructuring to directly access the caller on a message - that allows for a shorter syntax. 
```motoko
actor {

    public shared ({ caller }) func returnCallerPrincipal() : async Principal {
        return caller;
    };
};
```
## The Anonymous principal.
## PEM File.