import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Prelude "mo:base/Prelude";
import Time "mo:base/Time";
import Invoice "canister:invoice"
actor Secret {

    public type Time = Time.Time;
    private let password = "42";

    let userToInvoiceId = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);


    // Reveal the password only if the caller has paid 🤫
    public shared ({ caller }) func getPassword() : async Result.Result<Text, Text> {
        switch(userToInvoiceId.get(caller)) {
            case(null){
                let invoiceId = await Invoice.createInvoice();
                userToInvoiceId.put(caller, invoiceId);
                return #ok("Your invoice has been created with id: " # Nat.toText(invoiceId) # ". Please pay it to get the password.");
            };  
            case (? id) {
                switch(await Invoice.checkStatus(id)){
                    case(null){
                        return #err("Critical error: invoice not found for id " # Nat.toText(id));
                    };
                    case(? invoiceStatus){
                        switch(invoiceStatus){
                            case(#Paid){
                                return #ok(password);
                            };
                            case(#Unpaid){
                                return #err("Your invoice has not been paid yet. Please pay it to get the password.");
                            };
                        };
                    };
                }
            };
        };
    
    };




};