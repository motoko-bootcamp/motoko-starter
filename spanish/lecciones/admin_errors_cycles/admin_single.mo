shared ({ caller = creator }) actor class MyCanister() = {

    stable var owner : Principal = creator;

    public shared ({ caller }) func admin_function () : async Text {
        assert(caller == owner);        
        "Hello, admin!";
    };

    public shared ({ caller }) func get_owner () : async Principal {
        owner;
    };

    public shared ({ caller }) func set_owner (
        newOwner : Principal,
    ) : async () {
        assert(caller == owner);
        owner := newOwner;
    };

}