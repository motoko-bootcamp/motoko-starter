import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Hash "mo:base/Hash";
import Error "mo:base/Error";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Nat "mo:base/Nat";
actor Verifier {

    public type StudentProfile = {
        name : Text;
        Team : Text;
        graduate : Bool;
    };

    let studentProfilesStore : HashMap.HashMap<Principal, StudentProfile> = HashMap.HashMap<Principal, StudentProfile>(0, Principal.equal, Principal.hash);

    // STEP 1 - BEGIN

    public shared ({ caller }) func addMyProfile(profile : StudentProfile) : async Result.Result<(), Text> {
        studentProfilesStore.put(caller, profile);
        return #ok;
    };

    public shared ({ caller }) func seeAProfile(p : Principal) : async Result.Result<StudentProfile, Text> {
        switch (studentProfilesStore.get(p)) {
            case (?profile) { return #ok(profile); };
            case null { return #err("No profile found"); };
        };
    };

    public shared ({ caller }) func updateMyProfile(profile : StudentProfile) : async Result.Result<(), Text> {
        switch (studentProfilesStore.get(caller)) {
            case (?_) { studentProfilesStore.put(caller, profile); return #ok; };
            case null { return #err("No profile found"); };
        };
    };

    public shared ({ caller }) func deleteMyProfile() : async Result.Result<(), Text> {
        switch (studentProfilesStore.get(caller)) {
            case (?_) { studentProfilesStore.delete(caller); return #ok; };
            case null { return #err("No profile found"); };
        };
    };


    // system func preupgrade() : async () {
    // TODO
    // }
     
    // system func postupgradde() : async () {
    // TODO
    // };

    // STEP 1 - END
    // STEP 2 - BEGIN

    type simpleCalculatorInterface = actor {
        add : shared (n : Nat) -> async Nat;
        sub : shared (n : Nat) -> async Nat;
        reset : shared () -> async Nat;
    };

    public func test(canisterId : Principal) : async Result.Result<(), Text> {
        let  simpleCalculator : simpleCalculatorInterface = actor(Principal.toText(canisterId));
        try {
            let result_3 = await simpleCalculator.reset();
            let result_1 = await simpleCalculator.add(1);
            let result_2 = await simpleCalculator.sub(2);
            if(result_2 == - 1) {
                return #ok;
            } else {
                return #err("Wrong result");
            };
        } catch (e) {
            return #err(Error.message(e));
        };
    };

};