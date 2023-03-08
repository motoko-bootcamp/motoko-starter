# Introduction
##  What is a canister?
There is one word you absolutely cannot forget from this entire week. Are you ready for it? 
It's... 🥁... **CANISTER**! 

The Internet Computer is a platform that hosts a large number of applications, all of those applications run smoothly within special containers called **canisters**. 

<p align="center"> <img src="./assets/chapter-1/canister_overview.png" width="800px" style="border: 2px solid black;"> </p>
<p align="center"> Overview of a canister.</p>

- Developers build applications by writing the source code for those canisters. An application can be built into one or several canisters depending on the architecture.
- Users will interact with applications by sending messages to canisters.
- The Internet Computer is responsible to smoothly and safely run all the canisters deployed on the platform in parallel.


## WebAssembly and why do we need Motoko? 
Before we dive into Motoko - we actually need to explain another term: WebAssembly.


On a more technical level, a canister is composed of:
- A **WebAssembly module** which is a piece of compiled code from languages such as Rust or Motoko. This is the code that is installed in the canister and is ultimately running. 
- A **WebAssembly memory** - also called memory pages. This is where the state of the canister is stored and files are stored (photos, videos, tokens...). Code runs by the WebAssembly module will modify the memory.

WebAssembly is like a virtual machine that helps run special instructions, called bytecode. It's great for building efficient apps because it's fast,  efficient, and works all kinds of devices.
<br/> The [DFINITY Foundation](https://dfinity.org/) has created a new language called Motoko, which is a programming language specifically designed for creating applications on the Internet Computer. **Why do we need another language?**
<br/> Have we've seen, canisters run using WebAssembly modules. 
Since Motoko can directly convert its code into [WebAssembly](https://webassembly.org/), it is an incredible language for building on the Internet Computer.

> It's worth noting that WebAssembly, or "WASM" for short, was co-designed by [Andreas Rossberg](https://github.com/rossberg), who joined the DFINITY Foundation early in 2017 to work on its canister smart contract execution environment and is also the original designer of the Motoko language. The standard is maintained by the [World Wide Web Consortium](https://www.w3.org/). 
## The actor model.
## Update & Query calls.
## Fuel on the Internet Computer: cycles.