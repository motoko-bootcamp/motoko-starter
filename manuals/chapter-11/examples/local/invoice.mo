import Buffer "mo:base/Buffer";
import Result "mo:base/Result";
actor Invoice {

    public type InvoiceId = Nat;
    public type InvoiceStatus = {
        #Paid;
        #Unpaid;
    };
    public type Invoice = {
        status : InvoiceStatus;
        id : InvoiceId;
    };

    var invoices : Buffer.Buffer<Invoice> = Buffer.Buffer<Invoice>(10);

    public func createInvoice() : async InvoiceId {
        let newInvoice = {
            status = #Unpaid;
            id = invoices.size();
        };
        invoices.add(newInvoice);
        return newInvoice.id;
    };

    public func checkStatus(id : InvoiceId) : async ?InvoiceStatus {
        if(id >= invoices.size()) {
            return null;
        };
        let invoice = invoices.get(id);
        return ?invoice.status;
    };
    
    public func payInvoice(id : InvoiceId) : async Result.Result<(), Text> {
        if(id >= invoices.size()) {
            return #err("Invoice does not exist");
        };
        let invoice = invoices.get(id);
        if(invoice.status == #Paid) {
            return #err("Invoice already paid");
        };
        let newInvoice = {
            status = #Paid;
            id = invoice.id;
        };
        invoices.put(id, newInvoice);
        return #ok();
    };

};