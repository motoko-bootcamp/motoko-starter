import Random "mo:base/Random";
import Array "mo:base/Array";
import Iter "mo:base/Iter";

actor Randomness {
  public func random_bytes(n : Nat) : async [?Nat8] {

    let byteArray : [var ?Nat8] = Array.init<?Nat8>(n, ?0);
    
    let entropy = await Random.blob();
    var f = Random.Finite(entropy);

    for(i in Iter.range(0,n-1)){
      byteArray[i] := f.byte();
    };
    
    Array.freeze<?Nat8>(byteArray);
  
  };

};