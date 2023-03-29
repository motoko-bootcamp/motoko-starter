import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Time "mo:base/Time";
import Factorial "canister:factorial";

actor Timestamper {

//   let factorial = actor "oqjvn-fqaaa-aaaab-qab5q-cai" : actor {
//     computation : Int  -> async Int;
//   };

  var timestamps : [var (Nat, Int)] = Array.init<(Nat, Int)>(10, (0,0)); 

  public func set_timestamps(n : Nat) : async [(Nat, Int)] {
    var counter = 0;

    for (i in Iter.range(0,9)){
      let j : Int = i * n;
      let _ = await Factorial.computation(j);
      timestamps[i] := (counter, Time.now());
      counter += 1;
    };

    Array.freeze<(Nat,Int)>(timestamps);

  };

};
