# Chapter 15: Managing multiple canisters with actor classes.
## Actor classes.
## The management canister 👨‍💼
The management canister is used on the IC to perform the following operations:
- Create canisters from another canister.
- Install code inside other canisters (that you have control over!).
- Get informations on canister such as:
    - The status of a canister (running, stopping, stopped).
    - A SHA256 hash of the module installed on the canister.
    - The controllers of the canister.
    - The memory size taken by the canister.
    - The cycle balance of the canister.
- Create [ECDSA](https://internetcomputer.org/docs/current/references/ic-interface-spec#ic-sign_with_ecdsa) signatures derived from the canister.
- Create [http_request](https://internetcomputer.org/docs/current/references/ic-interface-spec#ic-sign_with_ecdsa) 
- Interact with [the Bitcoin API](https://internetcomputer.org/docs/current/references/ic-interface-spec#ic-bitcoin-api)
- And way more! 

> The IC management canister doesn't actually exists as a "canister". It doesn't contain a wasm module or memory - it's only an interface to make it easier to communicate with a management API on the IC. The IC management canister address is aaaaa-aa.  

Here is an example of how to use the managament canister inside an other actor.
```motoko
actor {
    let managementCanister = actor {
        create_canister : {} -> async {canister_id : Principal};
        stop_canister : { canister_id : Principal } -> async ();
        delete_canister : { canister_id : Principal } -> async ();
    };

// Create - Stop - Burn 🥲
    public func createStopBurn() : async () {
        let cid = await mangagementCanister.create_canister;
        await IC.stop(cid);
        await IC.delete_canister(cid) 
    };
};
```

Once you've created other canisters from within your canister you can install a wasm module inside of them. This requires that the module is already loaded inside your main canister. This pattern is used by a lot of applications on the IC to create multicanister dApps (OpenChat...)! 
## Creating a canister factory.