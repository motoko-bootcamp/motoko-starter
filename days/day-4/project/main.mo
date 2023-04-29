import Account "account";
import TrieMap "mo:base/TrieMap";
import Trie "mo:base/Trie";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Option "mo:base/Option";
actor MotoCoin {

    public type Account = Account.Account;
    let ledger : TrieMap.TrieMap<Account, Nat> = TrieMap.TrieMap<Account, Nat>(Account.accountsEqual, Account.accountsHash);
    var airdropDone : Bool = false;

    public query func name() : async Text {
        return "MotoCoin";
    };

    public query func symbol() : async Text {
        return "MOC";
    };

    public func totalSupply() : async Nat {
        var total : Nat = 0;
        for ((account, balance) in ledger.entries()) {
            total := total + balance;
        };
        return total;
    };

    public shared ({ caller }) func transfer(
        from : Account,
        to : Account, 
        amount : Nat
        ) : async Result.Result<(), Text> {
            if(not Account.accountBelongToPrincipal(from, caller)) {
                return #err("This account does not belong to you");
            };
            switch(ledger.get(from)){
                case(null){
                    return #err("This account does not exist");
                };
                case(? balance){
                    if(balance < amount) {
                        return #err("Insufficient balance");
                    };
                    ledger.put(from, balance - amount);
                    let balanceTo = Option.get(ledger.get(to), 0);
                    ledger.put(to, balanceTo + amount);
                    return #ok(());
                };
            };
    };
    
    public type bootcampInterface = actor {
        getAllStudentsPrincipal : shared () -> async [Principal];
    };

    let bootcampActor : bootcampInterface = actor("rww3b-zqaaa-aaaam-abioa-cai");

    public func airdrop() : async () {
        let students = await bootcampActor.getAllStudentsPrincipal();
        let amount = 100;
        for (student in students.vals()) {
            let defaultAccount : Account = { owner = student; subaccount = null };
            let balance = Option.get(ledger.get(defaultAccount), 0);
            ledger.put(defaultAccount, balance + amount);
        };
        airdropDone := true;
        return;
    };



};