# Chapters
## Introduction
- Installation & prerequesites.
- Motoko Playground.
## Chapter 1: Fundamental Concepts
- What is a canister?
- WebAssembly and why do we need Motoko?
- The actor model.
- Update vs Query.
- Fuel on the Internet Computer: cycles.
## Chapter 2: Common programming concepts. (MB)
- Variables & Mutability.
- Types.
- Functions.
- Comments.
- Control flow.
## Chapter 3: Primitive Types in Motoko. (MB)
- `Nat`.
- `Int`.
- `Bool`.
- `Text`.
- `Char`.
- `Float`.
- `Blob`.
- `Nat8`, `Nat16`, `Nat32`, `Nat64`, `Int8`, `Int16`, `Int32`, `Int64`.
## Chapter 4: Candid the language of the Internet Computer.
- Why do we need Candid? 
- What is an IDL?
- The Candid file (`.did`).
## Chapter 5: Modules and the Base library (MB)
## Chapter 6: Storing data in our first data structures. (MB)
- `Array`.
- `Buffer`.
- `List`.
- `HashMap`.
- `TrieMap`.
## Chapter 7: Non-primitives Types. (MB)
- Tuples.
- Records.
- Variants.
- Arrays.
- Mutable Arrays.
- Iterators.
## Chapter 8: Advanced Types. (MB)
- Optional types.
- Generic types.
- Recursive types.
- Shared types.
## Chapter 9: Handling errors.
- The `Result` type.
- The `Error` type.
- Trap. 
- Try/Catch.
## Chapter 10: Identity on the Internet Computer.
- Digital signatures.
- Messages.
- The concept of Principal.
- PEM File.
- Accessing the message & the caller.
- The `Principal` type in Motoko.
- The Anonymous principal.
## Chapter 11: Intercanister calls.
- Calling an actor by reference.
- Importing from another canister 
    - Locally
    - Mainnet
- Async values.
- Atomicity & commit point.
## Chapter 12: Upgrading a canister.
- Stable memory vs Heap memory.
- Stable variables.
- Stable types.
- Interface changes.
- Data structure changes.
- Stable type signature.
- Metadata section.
- Verifying upgrade compatibility.
## Chapter 13: Playing with time.
- `Time`
- `Timer` 
- `Heartbeat`
## Chapter 14: Mastering randomnes.
- The issue when dealing with randomness in a deterministic system.
- The `Random` library in Motoko and how to use it.
## Chapter 15: Managing multiple canisters with actor classes.
- Actor classes.
- The management canister.
- Creating a canister factory.
## Chapter 16: Binary operations in Motoko.
- Binary operations.