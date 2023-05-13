# The Verifier 👨‍🏫
## Introduction
Imagine that you are now an instructor at [Motoko School](https://twitter.com/MotokoSchool), where you are currently overseeing a cohort of more than 200 dedicated students!  🤯 <br/>
As part of the program, you have assigned these ambitious learners to tackle 4 distinct projects, each designed to challenge their skills and knowledge. Upon completion, it falls on your shoulders to meticulously review and evaluate their work, ultimately determining whether they have met the criteria for [graduation](../../../README.MD#🎓-graduation). <br/>
Fortunately, as an adept Motoko developer yourself, you possess the expertise and confidence to streamline this verification process by leveraging automation. This innovative approach will not only save you valuable time but also pave the way for the future of **Motoko Bootcamp**. 
## 🧑‍🏫 Requirements 
Your task is to create the code for an **instructor**, which is implemented as a canister. The idea is for the student to input his canister id and get automatically verified by the canister. If the canister id submitted fulfill the requirements then the students will automatically graduate; just imagine the HOURS of work you will save! <br/>

> For the purpose of this Bootcamp, we will not attempt to build a verifier that test all 4 previous projects. We will only attempts to verify a simple version of the calculator you've implemented during Day 1. The code for this simple calculator has already been implemented for you, and can be found [here](../project/calculator/calculator.mo).

## Part 1: Storing the students information.
The idea in this section is to build the code for storing informations about students. 
### Step-by-step
A student profile is defined as follows:
```motoko
public type StudentProfile = {
    name : Text;
    team : Text;
    graduate : Bool;
};
```
1. Define a variable named `studentProfileStore`, which is a `HashMap` for storing student profile. The keys in this map are of type `Principal` and represent the identity of students, while the values are of type `StudentProfile`. 
2. Implement the `addMyProfile` function which accepts a `profile` of type `StudentProfile` and adds it into the `studentProfileStore`. This function assumes that the `caller` is the student corresponding to the profile.
```motoko
addMyProfile: shared (profile : StudentProfile) -> async Result.Result<(), Text>;
```
3. Implement the `seeAProfile` query function, which accepts a principal `p` of type `Principal` and returns the optional corresponding student profile.
```motoko
seeAProfile : query (p : Principal) -> async Result.Result<StudentProfile, Text>;
```
4. Implement the `updateMyProfile` function which allows a student to perform a modification on its student profile. If everything works, and the profile is updated the function should return a simple unit value wrapped in an `Ok` result. If the `caller` doesn't have a student profile the function should return an error message wrapped in an `Err` result. 
```motoko
updateMyProfile : shared (profile : StudentProfile) -> async Result.Result<(), Text>;
```
5. Implement the `deleteMyProfile` function which allows a student to delete its student profile. If everything works, and the profile is deleted the function should return a simple unit value wrapped in an `Ok` result. If the `caller` doesn't have a student profile the function should return an error message wrapped in an `Err` result. 
```motoko
deleteMyProfile : shared () -> async Result.Result<(), Text>;
```
## Part 2: Testing of the simple calculator.
The goal of this section is to write the code for testing the functionality of the simple calculator (you don't need to write the code for this one! I've already done it). We will will test threee functions:
- The `reset` function.
- The `add` function.
- The `sub` function.

If these three functions are correctly implemented, it indicates a successful test, validating the canister. During the calculator testing, we will perform inter-canister calls, considering three different scenarios:

- Scenario 1: The calls to the calculator are executed correctly, but the returned results are not as expected. For example, if calling reset followed by add(1) returns 2 instead of the expected result.
- Scenario 2: The calls to the calculator are executed correctly, and the returned results match our expectations.
- Scenario 3: The calls to the calculator fail. This could be due to reasons such as the calculator not implementing the add function, not being deployed on the network, or running out of computation cycles.

To handle the different scenario, we define the `TestResult` type as follows:
```motoko
public type TestResult = Result.Result<(), TestError>;
public type TestError = {
    #UnexpectedValue : Text;
    #UnexpectedError : Text;
};
```
1. Implement the `test` function that takes a `canisterId` of type `Principal` and returns the result of the test of type `TestResult`. Make sure to distringuish between the two types of errors.
- UnexpectedValue should be returned whenever the calculator returns a wrong value. For instance, if a call to `reset` followed by `add(1)` returns 2.
- UnexpectedError should be returned for all other types of errors. For instance, if the function `add` is not even implemented as part of the canister's interface.
```motoko
test: shared (canisterId : Principal) -> async TestResult;
```
## Part 3: Verifying the controller of the calculator.
In this section we want to make sure that the owner of the verified canister is actually the student that registered it. Otherwise, a student could use the canister of another one.
### Step-by-step
Implement the `verifyOwnership` function that takes a `canisterId` of type `Principal` and a `principalId` of type `Principal` and returns a boolean indicating if the `principalId` is among the controllers of the canister corresponding to the `canisterId` provided.
```motoko
verifyOwnership : shared (Principal, Principal) -> async Bool;
```

> Tip: To implement step 3, you'll need to make an intercanister call to the management canister by using the `canister_status` method, which will return information on the canister among which are the list of controllers. The management canister is defined in the [ic.mo](./verifier/ic.mo). However, currently, the `canister_status` method can only be accessed when the calling canister is also the controller of the canister whose status you want to check. To overcome this limitation, you'll need to use a `try/catch` block to catch the error returned by the management, access the error message with `Error.message(e)` and then parse the message using the `parseControllersFromCanisterStatusErrorIfCallerNotController` method. I recommend reading the [dedicated topic on the forum](https://forum.dfinity.org/t/getting-a-canisters-controller-on-chain/7531/15)

```motoko
func parseControllersFromCanisterStatusErrorIfCallerNotController(errorMessage : Text) : [Principal] {
    let lines = Iter.toArray(Text.split(errorMessage, #text("\n")));
    let words = Iter.toArray(Text.split(lines[1], #text(" ")));
    var i = 2;
    let controllers = Buffer.Buffer<Principal>(0);
    while (i < words.size()) {
      controllers.add(Principal.fromText(words[i]));
      i += 1;
    };
    Buffer.toArray<Principal>(controllers);
  };
```
## Part 4: Graduation! 🎓
In this sections the idea is to let students submit their work and automatically verify the canister. If the tests are passed then the `graduation` field of the student is automatically changed.
### Step-by-step
Implement the `verifyWork` function that takes a `canisterId` of type `Principal` and a `principalId` of type `Principal` that corresponds to the identity of the student and perfoms the necessary verifications on the canister. If all the criteria for graduations are validated; then the `graduation` field of the student is updated accordingly. This function will returns  a `Ok` result indicating if the submitted project has been successfuly verified. This function will return a text message wrapped in an `Err` message in case the verification fails or something unexpected happens.

```motoko
verifyWork: shared (canisterId : Principal, principalId: Principal) -> async Result.Result<(), Text>;
```

## 📺 Interface
> At the end of the project your canister should implement the following interface:
```motoko
actor Verifier {
    // Part 1
    addMyProfile : shared StudentProfile -> async Result.Result<(),Text>;
    updateMyProfile : shared StudentProfile -> async Result.Result<(),Text>;
    deleteMyProfile : shared () -> async Result.Result<(),Text>;
    seeAProfile : shared Principal -> async Result.Result<StudentProfile, Text>;

    //Part 2
    test : shared Principal -> async TestResult;

    //Part 3
    verifyOwnership : shared (Principal, Principal) -> async Bool;

    //Part 4
    verifyWork : shared (Principal, Principal) -> async Result.Result<(), Text>;
};
```
