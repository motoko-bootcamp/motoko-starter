import Cycles "mo:base/ExperimentalCycles";
import Result "mo:base/Result";

shared ({ caller = creator }) actor class MyCanister() = {

    let price : Nat = 1_000_000_000;

    public query func cycle_balance() : async Nat {
        return Cycles.balance();
    };

    
    public shared ({ caller }) func pay_order() : async Result.Result<Text, Text> {
        let cycles = Cycles.available();
        if (cycles < price) {
            return #err("Not enough!");
        } else {
            ignore Cycles.accept(price);
            return #ok("Thanks! Here is your order.")

        };
    };

};
