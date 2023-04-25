# Chapter 15: Mastering randomnes.
## The issue with randomness
Dealing with randomness on the Internet Computer is tricky: all nodes needs to agree on the state of a canister so the randomness needs to be shared between all of them. At the same time, if the randomness can be guessed by any third party it could be disastrous for any dApps that uses it for any type of betting mechanism.
## The random beacon
## The `Random` library in Motoko