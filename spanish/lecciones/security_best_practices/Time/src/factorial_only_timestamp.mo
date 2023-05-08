import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Time "mo:base/Time";
import Factorial "canister:factorial";

actor Timestamper {

//   let factorial = actor "wfg2r-bqaaa-aaaab-qadfq-cai" : actor {
//     computation : Int  -> async Int;
//   };

  let timestamps : [var Int] = Array.init<Int>(10, 0);

  public func set_timestamps(n : Nat) : async [Int] {

    for (i in Iter.range(0,9)){
      let j : Int = i * n;
      let _ = await Factorial.computation(j);
      timestamps[i] := Time.now();
    };
    
    Array.freeze<Int>(timestamps);
  
  };

};
