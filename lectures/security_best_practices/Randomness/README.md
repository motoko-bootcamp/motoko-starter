# Randomness

In this example, we have two versions of a ```Randomness``` actor exposing a ```random_bytes``` method, which accepts an input number ```n``` and returns random ```n``` bytes. 

In canister ```random_no_reseed```, the ```Finite``` class is seeded only once with ```Random.blob()```. Hence, the ```random_bytes``` method start returning ```null``` bytes, once the fresh randomness of ```32 bytes``` is exhausted. 

In canister ```random_reseed```, the ```Finite``` class is reseeded everytime the fresh randomness is exhausted. Thus, ```random_bytes``` can generate random bytes for lengths greater than 32. 

### Example 

```
$ dfx deploy 

$ dfx canister call random_no_reseed random_bytes '(20)'
(
  vec { opt (35 : nat8); opt (80 : nat8); opt (237 : nat8); opt (169 : nat8); opt (166 : nat8); opt (47 : nat8); opt (59 : nat8); opt (48 : nat8); opt (10 : nat8); opt (142 : nat8); opt (24 : nat8); opt (0 : nat8); opt (219 : nat8); opt (5 : nat8); opt (251 : nat8); opt (141 : nat8); opt (149 : nat8); opt (144 : nat8); opt (147 : nat8); opt (162 : nat8);},
)

$ dfx canister call random_no_reseed random_bytes '(40)'
(
  vec { opt (183 : nat8); opt (28 : nat8); opt (209 : nat8); opt (73 : nat8); opt (88 : nat8); opt (210 : nat8); opt (103 : nat8); opt (29 : nat8); opt (240 : nat8); opt (227 : nat8); opt (108 : nat8); opt (113 : nat8); opt (4 : nat8); opt (62 : nat8); opt (88 : nat8); opt (246 : nat8); opt (233 : nat8); opt (230 : nat8); opt (149 : nat8); opt (219 : nat8); opt (119 : nat8); opt (64 : nat8); opt (33 : nat8); opt (135 : nat8); opt (17 : nat8); opt (127 : nat8); opt (66 : nat8); opt (235 : nat8); opt (223 : nat8); opt (208 : nat8); opt (145 : nat8); opt (70 : nat8); null; null; null; null; null; null; null; null;},
)

$ dfx canister call random_reseed random_bytes '(90)'
(
  blob "\a9\1f\87am\c4\80(\d4\7f\f9\84\9c\1f\16J\16\12y\f5\83\1e%\d7\0d;)\e3\f5\c3iQ!\86-\dd\8b\97HO\dd^\ce\f8\e0$\08 \97\b1\be\c4F\00\ca$\edR\18\eb\03\97p\11\87Bc{\ab\e4#*\99\0fF\de^e\9e\0d\f9\92\9bD8\01\e9\c2\91\1b",
)
```
