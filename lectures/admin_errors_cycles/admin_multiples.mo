import Array "mo:base/Array";
import Option "mo:base/Option";

shared ({ caller = creator }) actor class MyCanister() = {

    stable var admins : [Principal] = [creator];

    func is_admin (
        principal : Principal,
    ) : Bool {
        switch (Array.find<Principal>(admins, func (x) { x == principal })) {
            case (?a) true;
            case _ false;
        };
    };

    public shared func get_admins () : async [Principal] {
        admins;
    };

    public shared ({ caller }) func remove_admins (
        removals : [Principal],
    ) : async () {
        assert(is_admin(caller));
        admins := Array.filter<Principal>(admins, func (admin) {
            Option.isNull(Array.find<Principal>(removals, func (x) { x == admin }));
        });
    };

    public shared ({ caller }) func addAdmins (
        newAdmins : [Principal]
    ) : async () {
        assert(is_admin(caller));
        admins := Array.append(admins, Array.filter<Principal>(newAdmins, func (x) {
            Option.isNull(Array.find<Principal>(admins, func (y) { x == y }));
        }));
    };

    public shared ({ caller }) func admin_function () : async Text {
        assert(is_admin(caller));
        "Hello, admin!";
    };

};