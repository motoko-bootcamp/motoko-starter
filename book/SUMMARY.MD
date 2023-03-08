# Chapters
## Introduction
- Installation & prerequesites.
- Motoko Playground
## Chapter 1: Fundamental Concepts
- What is a canister?
- WebAssembly and why do we need Motoko?
- The actor model.
- Update vs Query.
- Fuel on the Internet Computer: cycles.
## Chapter 2: Common programming concepts.
- Variables & Mutability.
- Types.
- Functions.
- Comments.
- Control flow.
## Chapter 3: Primitive Types in Motoko.
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
## Chapter 5: Interacting with a canister
- From the CLI: using `dfx`.
- From the Candid UI.
- From a frontend.
## Chapter 6: The Motoko Base library 
- What is it and how do you use it?
- How to find the documentation & the source code?
## Chapter 7: Debugging in Motoko.
- The `Debug` module.
## Chapter 8: Storing data in our first data structures.
- `Array`.
- `Buffer`.
- `List`.
- `HashMap`.
- `TrieMap`.
## Chapter 9: Non-primitives Types.
- Tuples.
- Records.
- Variants.
- Arrays.
- Mutable Arrays.
- Iterators.
## Chapter 10: Advanced Types.
- Optional types.
- Generic types.
- Recursive types.
- Shared types.
## Chapter 11: Handling errors.
- The `Result` type.
- The `Error` type.
- Trap. 
- Try/Catch.
## Chapter 12: Identity on the Internet Computer.
- Digital signatures.
- Messages.
- The concept of Principal.
- PEM File.
- Accessing the message & the caller.
- The `Principal` type in Motoko.
- The Anonymous principal.
## Chapter 13: Managing modules in Motoko.
- Module types
- Creating our custom type.
- Adding public functions.
- Classes.
- Using tools to manage modules: Vessel & MOPS.
## Chapter 14: Intercanister calls.
- Calling an actor by reference.
- Importing from another canister (locally)
- Importing from another canister (mainnet)
- Async values.
## Chapter 15: Breaking down advanced concepts.
- Orthogonal persistence.
- Structural typing.
- Atomicity & commit point.
## Chapter 16: Playing with time in Motoko.
-`Time`
-`Timer` 
-`Heartbeat`.
## Chapter 17: Upgrading a canister.
- Stable memory vs Heap memory.
- Stable variables.
- Stable types.
- Interface changes.
- Data structure changes.
- Stable type signature.
- Metadata section.
- Verifying upgrade compatibility.
## Chapter 18: Stable data structures.
- RB TRee
- Tree
- Converting a non-stable type to stable.
## Chapter 19: Managing multiple canisters with actor classes.
- Actor classes.
- Creating a canister factory.
## Chapter 20: Randomness.
- The issue when dealing with randomness in a deterministic system.
- The `Random` library in Motoko and how to use it.
## Chapter 21: Binary operations in Motoko
- Bounded types.
- Binary operations.
## Chapter 22: HTTP Request to access a canister through a browser.
- Difference between HTTP request & HTTP outcalls.
- What are boundary nodes?
- The asset canister or creating your own canister that handles HTTP requests.
- What is the difference between ic0.app & raw.ic0.app?
- HTTP Request in Motoko.
## Chapter 23: HTTP Outcalls.
## Chapter 24: Threshold ECDSA.
## Chapter 25: Bitcoin Integration.
# Appendices
## Appendix 1: Deploying & managing canisters.
## Appendix 2: Unlocking the power of DAOs with canisters.
- Current DAOs and their limitations.
- From smart contracts to canisters.
- How can we trust a canister?
- Overview of the biggest DAO on the Internet Computer: the NNS.
## Appendix 3: A new chapter in digital identity: Internet Identity.
- Username & passwords.
- Login with BigTech
- WebAuthentication.
- Delegations
- Canister signature
- How does Internet Identity work?
- The issue with Cross-dApp communication.
## Appendix 4: Handling payments on the Internet Computer.
- The ICP Ledger.
- The ICRC_1 standard.
- The Invoice canister (depreceated?)
## Appendix 5: Unlocking the power of NFTs on the Internet Computer
- Current NFTs and their limitations.
- From smart contracts to canisters.
- New possibilities for NFTs.
## Appendix 6: A guide to multi-canister scaling