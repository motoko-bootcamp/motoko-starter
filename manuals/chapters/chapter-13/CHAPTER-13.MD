# Chapter 13: Playing with time in Motoko.
## 🕣 Time
A challenge that comes with a distributed system such as the Internet Computer is the notion of time. Each node has it's own internal horloge. To respected determinisn, the time provided to the canister is the **system time** - a value agreed upon by the subnet. The **system time** is represented as nanoseconds since 1970-01-01.

In Motoko, the type `Time` is an aliast for `Int`.
```motoko
public type Time = Int;
```
The Time module gives us access to the `now()` function that returns the system time.
```motoko
import Time "mo:base/Time";
actor {
    public type Time = Time.Time;
    public func whatTimeIsIt() : async Time.Time {
        Time.now();
    };
};
```

The time returned by `Time.now()` is constant within a message execution. 
```motoko
import Time "mo:base/Time";
import Debug "mo:base/Debug";
actor {
    public type Time = Time.Time;

    func doSomething() :  () {
        Debug.print("Doing some work");
    };

    public func whatTimeIsIt() : async (Time, Time) {
        let a = Time.now();
        doSomething();
        let b = Time.now();
        return (a, b);
    };
};
```
The value of `a` and `b` will be the same. Try it out [here](https://m7sm4-2iaaa-aaaab-qabra-cai.ic0.app/?tag=4264079271).
## ⏰ Timer
Sometimes you need to run tasks a on regular basic (every minute/hour/day...). To run cronic tasks, you can use the [Timer library](https://internetcomputer.org/docs/current/motoko/main/base/Timer). 

This library defines two types:
1. `Duration` represents a delay before executing the job. The delay provided can be as small as possible but the resolution cannot be faster than the block rate. 
```motoko
type Duration = {#seconds : Nat; #nanoseconds : Nat}
```
2. `TimerId` is an ID to identify the timer.
```motoko
type TimerId = Nat
```

This library exposes different methods:
- `setTimer` allows  you to set a `job` that will be executed once in the future after the given duration `d` has passed.
```motoko
func setTimer(d : Duration, job : () -> async ()) : TimerId
```
```motoko
let oneHourInSeconds = 60 * 60;
func endExam() : async () {
    Debug.print("🔚")
};
let id = setTimer(#seconds(oneHourInSeconds), endExam);
```

- `recurringTimer` allows you to set a `job` that will be executed chronically everytime the given duration `d` has passed. 
```motoko
func recurringTimer(d : Duration, job : () -> async ()) : TimerId
```
```motoko
let oneDayInSeconds = 60 * 60 * 24;
func study() : async () {
    Debug.print("🙇")
};
let studyId = reccuringTimer(#seconds(oneDayInSeconds), study);
```
- `cancelTimer` will cancel an active timer. If the `id` provided is not recognized nothing happens.
```motoko
let cancelTimer : TimerId -> ()
```
```motoko
func quitSchool() {
    cancelTimer(studyId);
};
```
## 🫀 Heartbeat
A canister can exposes a system function `heartbeat`. This function is automatically triggered by the protocol at every round of execution, approximately every second.

```motoko
import Debug "mo:base/Debug";
import Time "mo:base/Time";
actor {

    public type Time = Time.Time;

    var count : Nat = 0;
    var times : [Time] = [] 

    system func heartbeat() : async () {
        count += 1;
        if(count % 100 == 0) {
            // Every 10O invocations of the heartbeat function.
            times := Array.append<Time>(times, [Time.now()]);
        } 
    };
}
```

> The **heartbeat** functionality is being replace by **timers** due to prohibitive costs.
