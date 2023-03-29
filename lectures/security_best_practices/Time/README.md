# Time

In this example, we look into to the intricacies of utilising the ```Time.now()``` API.

First, we have ```factorial``` canister, which on input ```n``` returns ```n!```. This canister will serve as some external computation that is timed. 

In our first canister ```only_timestamp```, we only use the ```Time.now()``` to timestamp the external computation. This is done via the `set_timestamps` method.  

In our second canister ```timestamp_counter```, we use a combination of ```Time.now()``` and logical counter, to distinguish between events having same timestamp. 

### Example 

```
$ dfx deploy 

$  dfx canister call factorial computation '(50)'
(
  30_414_093_201_713_378_043_612_608_166_064_768_844_377_641_568_960_512_000_000_000_000 : int,
)

$ dfx canister call only_timestamp set_timestamps '(100)' 

(
  vec {
    1_674_216_764_405_523_000 : int;
    1_674_216_764_405_523_000 : int;
    1_674_216_764_405_523_000 : int;
    1_674_216_764_405_523_000 : int;
    1_674_216_764_405_523_000 : int;
    1_674_216_764_405_523_000 : int;
    1_674_216_764_405_523_000 : int;
    1_674_216_764_405_523_000 : int;
    1_674_216_764_405_523_000 : int;
    1_674_216_764_405_523_000 : int;
  },
)

$ dfx canister call only_timestamp set_timestamps '(1000)'
(
  vec {
    1_674_216_849_118_353_000 : int;
    1_674_216_849_118_353_000 : int;
    1_674_216_849_118_353_000 : int;
    1_674_216_849_118_353_000 : int;
    1_674_216_849_118_353_000 : int;
    1_674_216_849_118_353_000 : int;
    1_674_216_849_746_234_000 : int;
    1_674_216_850_372_272_000 : int;
    1_674_216_850_995_143_000 : int;
    1_674_216_851_616_195_000 : int;
  },
)

$ dfx canister call timestamp_counter  set_timestamps '(1000)'
(
  vec {
    record { 0 : nat; 1_674_216_887_015_302_000 : int };
    record { 1 : nat; 1_674_216_887_015_302_000 : int };
    record { 2 : nat; 1_674_216_887_015_302_000 : int };
    record { 3 : nat; 1_674_216_887_015_302_000 : int };
    record { 4 : nat; 1_674_216_887_015_302_000 : int };
    record { 5 : nat; 1_674_216_887_015_302_000 : int };
    record { 6 : nat; 1_674_216_887_640_725_000 : int };
    record { 7 : nat; 1_674_216_888_268_482_000 : int };
    record { 8 : nat; 1_674_216_888_892_334_000 : int };
    record { 9 : nat; 1_674_216_889_518_710_000 : int };
  },
)
```