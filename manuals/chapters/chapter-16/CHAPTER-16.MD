# Chapter 16: Binary operations in Motoko
## 🧮 Binary operations
Motoko supports Bitwise operations (manipulation of the bits) through bounded integers (`Nat8`,`Nat16`, `Nat32`, `Nat64` & `Int8`,`Int16`, `Int32`, `Int64`).
- AND (Symbol `&`): This operation takes two binary values and performs a logical AND operation on each pair of corresponding bits. The result is a binary value where each bit is set to 1 only if the corresponding bits in both operands are set to 1.
```motoko
let a = 31 : Nat8;  // Binary 0011111
let b = 33  : Nat8; // Binary 0100001
let c = a & b (1)  // Binary 0000001 
assert(c == 1) // true
```
- OR (Symbol `|` ): This operation takes two binary values and performs a logical OR operation on each pair of corresponding bits. The result is a binary value where each bit is set to 1 if either or both corresponding bits in the operands are set to 1.
```motoko
let a = 31 : Nat8;  // Binary 0011111
let b = 33  : Nat8; // Binary 0100001
let c = a | b (63)  // Binary  0111111
```
- XOR (Symbol `^`): This operation takes two binary values and performs a logical XOR (exclusive OR) operation on each pair of corresponding bits. The result is a binary value where each bit is set to 1 if only one of the corresponding bits in the operands is set to 1.
```motoko
let a = 31 : Nat8;  // Binary 0011111
let b = 33  : Nat8; // Binary 0100001
let c = a ^ b (62)  // Binary  0111110
```
- Shift Left (Symbol `<<`): This operations moves the bits to the left by a specified number of positions, adding zeros to the right.
```motoko
let a = 64 : Nat8; //    binary 01000000
let c = a << 1 (128) //  binary 10000000 
```
- Shift right (Symbol `>>`): This operations moves the bits to the right by a specified number of positions, adding zeros to the left.
```motoko
let a = 64 : Nat8; //    binary  01000000
let c = a << 1 (32) //   binary  00100000
```
- Rotation left (Symbol `<<>`): This operations shifts the bits of a binary value to the left by a specified number of positions, and then rotating the shifted bits back to the right end of the value.
```motoko
let a = 128 : Nat8;     //  binary  1000000
a <<> 1 (1)             //  binary  0000001 
```
- Rotation right (Symbol `<>>`): This operations shifts the bits of a binary value to the right by a specified number of positions, and then rotates the shifted bits back to the left end of the value. 
```motoko
let a = 64 : Nat8;      // binary 001000000
a <>> 1 (32)            // binary 000100000
```
