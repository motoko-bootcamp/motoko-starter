import Cycles "mo:base/ExperimentalCycles";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Result "mo:base/Result";

shared ({ caller = creator }) actor class MyCanister () = {

    public shared ({ caller }) func get_order (
        pay : Bool,
    ) : async Result.Result<Text, Text> {
        Debug.print("Current balance: " # Nat.toText(Cycles.balance()));
        let shop : actor {  pay_order : () -> async Result.Result<Text, Text>; } = actor("renrk-eyaaa-aaaaa-aaada-cai");
        if (pay) {
            Cycles.add(1_000_000_100);
        };
        let order = await shop.pay_order();
        Debug.print("Unused balance: " # Nat.toText(Cycles.refunded()));
        order
    };

};