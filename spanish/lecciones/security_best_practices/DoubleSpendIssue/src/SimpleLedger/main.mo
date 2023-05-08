import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import Option "mo:base/Option";
import Result "mo:base/Result";


actor SimpleLedger{

let accounts : HashMap.HashMap<Principal, Nat> = HashMap.fromIter(Iter.fromArray([]), 5, Principal.equal, Principal.hash);

    public shared ({caller}) func deposit(amount : Nat, account: ?Principal) : async Result.Result<Text, Text>{
        let acc=Option.get(account, caller);

        let current_balance = accounts.get(acc);
        switch (current_balance){
            case (?balance){
                accounts.put(acc, balance + amount);
            };
            case (_){
                accounts.put(acc, amount);
            }
        };
        return #ok("Deposited " # Nat.toText(amount) # " to " # Principal.toText(acc));
    };

    public shared ({caller}) func get_balance (account: ?Principal) : async Result.Result<Text, Text>{
        let acc=Option.get(account, caller);

        let current_balance = accounts.get(acc);
            switch (current_balance){
                case (?balance){
                    return #ok("Ledger Balance of account: " # Principal.toText(acc) # " is " # Nat.toText(balance));
                };
                case (_){
                    return #ok("Ledger Balance of account: " # Principal.toText(acc) # " is " # Nat.toText(0));
                }
            }   
    };

};