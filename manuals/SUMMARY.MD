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
## Chapter 13: Stable data structures.
- RB TRee
- Tree
- Converting a non-stable type to stable.
## Chapter 14: Playing with time.
- `Time`
- `Timer` 
- `Heartbeat`
## Chapter 15: Mastering randomnes.
- The issue when dealing with randomness in a deterministic system.
- The `Random` library in Motoko and how to use it.
## Chapter 16: Managing multiple canisters with actor classes.
- Actor classes.
- The management canister.
- Creating a canister factory.
## Chapter 17: Binary operations in Motoko.
- Bounded types.
- Binary operations.
# Appendices
## Appendix 1: Deploying & managing canisters.
## Appendix 2: Unlocking the power of DAOs with canisters.
- Current DAOs and their limitations.
- From smart contracts to canisters.
- How can we trust a canister?
## Appendix 3: A new chapter in digital identity: Internet Identity.
- Username & passwords.
- Login with BigTech
- WebAuthentication.
- Delegations
- Canister signature
- How does Internet Identity work?
- The issue with Cross-dApp communication.
## Appendix 4: Overview of the biggest DAO on the Internet Computer: the NNS.
## Appendix 5: Handling payments on the Internet Computer.
- The ICP Ledger.
- The ICRC_1 standard.
## Appendix 6: Unlocking the power of NFTs on the Internet Computer
- Current NFTs and their limitations.
- From smart contracts to canisters.
- New possibilities for NFTs.
## Appendix 7: Debugging and testing with Motoko.
## Appendix 8: Common security issues and best practices.
## Appendix 9: HTTP Request to access a canister through a browser.
- Difference between HTTP request & HTTP outcalls.
- What are boundary nodes?
- The asset canister or creating your own canister that handles HTTP requests.
- What is the difference between ic0.app & raw.ic0.app?
- HTTP Request in Motoko.
