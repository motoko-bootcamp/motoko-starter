# Chapter 10: Identity on the Internet Computer.
## Your keys = Your identity 

Whether you are interacting with the Internet Computer using [Internet Identity](https://internetcomputer.org/docs/current/tokenomics/identity-auth/what-is-ic-identity), `dfx`, or even [Plug wallet](https://plugwallet.ooo/), your identity is represented by a key pair consisting of:

<p align="center"> <img src="./assets/identity_recap.png" width="600px" style="border: 2px solid black;"> </p>

- A **private key**, which grants you access to all the ICPs you own, allows you to manage canisters, and enables you to access your identity across various applications.
- A **public key**, from which your **principal** is derived.

## Managing identities with dfx
We can use `dfx` to create, delete and manage our identities, those identities are used to deploy, manage and interact with the canisters we deploy.

### Creating an identity
To generate a new identity you can run the following command
```bash
$ dfx new identity <NAME>
```
> You can include the --disable-encryption flag when executing the command to prevent encryption of the file containing your private key. Otherwise, the file will be encrypted, and you will be prompted for a password every time a command requiring a signature is used.

The private key generated for this identity will be automatically saved in the `.config/dfx/identity/<NAME> directory`. This private key is stored as a PEM file, a specific format used for storing keys. The file may be encrypted or unencrypted, based on the flag you choose.

For example, the PEM file corresponding to the `default` identity, which is an identity automatically created when you install `dfx`, has a private key stored within that resembles the following:
```
-----BEGIN EC PRIVATE KEY-----
MHQCAQEEIPkmcU+rvYCcvylnVClTrleDyWqmelhQmigzMvq8zFC3oAcGBSuBBAAK
oUQDQgAE5knNEHs+kzvCteeu4e650NzqGvLhlzoWXXKupjCreV1dhuH5oIHIVyoM
ldnRBAE39QwyGwkQoxWhmo+Sl9F4zA==
-----END EC PRIVATE KEY-----
```  
### Switching between identities
To check the current used identity, execute:
```bash
$ dfx identity whoamis 
```
To view other available identities, run:
```bash
$ dfx identity list
```
Finally, switch the active identity using:
```bash
$ dfx identity use <NAME> 
```
## From Public Key to Principal
With `dfx`, you can access a unique identifier for each identity called **principal**:
```motoko
$ dfx identity get-principal
2ujkt-fujau-bunuv-gt4b6-2s27j-cv5qi-kddkp-jl7m4-wdj3e-bqdrt-qqe
```
A principal identifies entities interacting with the Internet Computer and is directly derived from the public key. These entities can be users or canisters. Different types of principals include:
A principal is a public identifier used to identify entities that can interact with the Internet Computer. The principal is derived directly from the public key. These entities are either users or canisters. We distinguish different types of principals:
- **Self-authenticating IDs** (User): Derived directly from a user's public key, such as your dfx identity's principal. These principals are 29 bytes long.
- **Opaque IDs** (Canister): A canister's principal is its canister ID, determined automatically based on its subnet and the number of deployed canisters.
- **Anonymous ID** (Anonymous): The default caller when an unauthenticated user calls functions, such as fetching information from a canister before logging in. The canister recognizes the caller as the Anonymous ID since the user's principal is unknown until login.

> Two [additional principal types](https://internetcomputer.org/docs/current/references/ic-interface-spec#id-classes) exist but are rarely encountered. They are used internally by the protocol or reserved for future use.

## Principal in Motoko
In Motoko, principals are a primitive type called `Principal`. <br/>
Within an actor, access the principal of a function caller using the `shared (message)` syntax placed between the `public` and `func` keywords. This enables message inspection, where `message.caller` represents the principal of the calling entity (user or canister).


```motoko
actor {
    public shared (message) func whoIsCalling() : async Principal {
        let p = message.caller;
        return p;
    };
};
```
> Message is a special object that is available to all `public shared functions`. As of today, it is only used for accessing the `caller` property but it might have other use cases in the future.

Use object destructuring to access the caller directly for shorter syntax:
```motoko
actor {
    public shared ({ caller }) func returnCallerPrincipal() : async Principal {
        return caller;
    };
};
```
Use `Principal.toText()` and `Principal.fromText()` from the [Principal module](https://7po3j-syaaa-aaaal-qbqea-cai.ic0.app/base-library/primitive-types/principal.html?highlight=Principal#principal) to convert between `Principal` and its textual representation.

```motoko
let p : Principal = message.caller;
let textualRepresentation : Text = Principal.toText(p); // => "un4fu-tqaaa-aaaab-qadjq-cai"
let standardRepresentation : Principal = Principal.fromText(textualRepresentation); 
```

## The Anonymous identity
As mentioned earlier, the anonymous identity is associated with a specific principal and is used for unauthenticated calls to the Internet Computer. To determine if a caller is authenticated, use the `Principal.isAnonymous()` function, which returns a `Bool` indicating the user's anonymity.
```motoko
let p : Principal = message.caller;
let isAnonymous : Bool = Principal.isAnonymous(p);
if(isAnonymous){
    return ("Sorry only authenticated users can access this app!");
};
```

> The textual representation of the anonymous principal is `2vxsx-fae`. Make sure to remember it as you will often come accross it.