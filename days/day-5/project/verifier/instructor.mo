import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Hash "mo:base/Hash";
actor Verifier {

    public type StudentProfile = {
        name : Text;
        Team : Text;
        graduate : Bool;
    };

    let studentProfilesStore : HashMap.HashMap<Principal, StudentProfile> = HashMap.HashMap<Principal, StudentProfile>(0, Principal.equal, Principal.hash);

};