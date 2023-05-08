import Array "mo:base/Array";
import Option "mo:base/Option";
import HashMap "mo:base/HashMap";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Hash "mo:base/Hash";
import Text "mo:base/Text";

shared ({ caller = creator }) actor class MyCanister() = {

    let owner : Principal = creator;
    let usernames : HashMap.HashMap<Principal, Text> = HashMap.HashMap<Principal, Text>(0, Principal.equal, Principal.hash);

    public shared ({ caller }) func add_username(name : Text) : async () {
      usernames.put(caller, name);
    };

    // By using a variant type, we can even be explicit about certain error cases.
    type Errors = {
        #Restricted;
        #NotFound;
    };

    public shared ({ caller }) func rename (
        newName : Text,
        user : Principal
    ) : async Result.Result<Text, Errors> {
        if (caller != owner) {
            return #err(#Restricted);
        };
        switch(usernames.get(user)) {
            case (?_) {
                usernames.put(user, newName);
                return #ok("Name changed!");
            };
            case null {
                return #err(#NotFound);
            };
        };
    }




};