import Random "mo:base/Random";
import Array "mo:base/Array";
import Iter "mo:base/Iter";

actor Randomness {
  public func random_bytes(n : Nat) : async [Nat8] {

    let byteArray : [var Nat8] = Array.init<Nat8>(n, 0);
    let entropy = await Random.blob();
    
    var f = Random.Finite(entropy);
    var i = 0;
    
    loop {
      
      if (i == n) {
        return Array.freeze<Nat8>(byteArray);
      } else {
        
        switch (f.byte()) {
        
          case (?byte) {
            byteArray[i] := byte;
            i := i + 1;
          };
          
          case null {
            let entropy = await Random.blob();
            f := Random.Finite(entropy);
          };
        
        };
      
      };
    
    };
  
  };

};
