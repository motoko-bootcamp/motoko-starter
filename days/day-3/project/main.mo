import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Result "mo:base/Result";
actor Enclyclopedia {

    public type Result<A,B> = Result.Result<A, B>;

    public type Contributor = {
        name: Text;
        reputation : Nat;  
    };

    let contributors : HashMap.HashMap<Principal, Contributor> = HashMap.HashMap<Principal, Contributors>(0, Principal.equal, Principal.hash);

    public shared ({ caller }) func addContributor (name: Text) : async Result<(), Text> {
        let principal = caller;
        let contributor = { name = name; reputation = 0 };
        switch(contributors.get(caller)){
            case null {
                contributors.put(caller, contributor);
                return #ok();
            };
            case _ {
                return #err("You are already a contributor");
            };
        };
    };




};