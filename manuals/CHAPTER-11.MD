# Chapter 11: Intercanister calls.
To achieve the vision of the Internet Computer, services (i.e canisters) needs to be able to call each other and run in an interoperable way. This capability is achieved through **inter-canister calls**. In this chapter, we will see how we can realize such calls and the potential issues to avoid.
## A simple example
To illustrate inter-canister calls we will use the following example, with 2 canisters:
1. Secret canister: This canister stores a secret password and this password should be divulgated only to users that paid. To verify payments, a mechanism of invoices is used.
```motoko
actor Secret {
    getPassword : shared () -> async Result.Result<Text, Text>;
};
````
2. Invoice canister: This canister is responsible for creating, storing and checking the status of invoices. 
```motoko
actor Invoice {
    createInvoice : shared () -> async InvoiceId;
    checkStatus : shared (id : InvoiceId) -> async ?InvoiceStatus;
    payInvoice : shared (id : InvoiceId) -> async Result.Result<(), Text>;
};
```
Where invoices are defined as follows:
```motoko
public type InvoiceId = Nat;
public type InvoiceStatus = {
    #Paid;
    #Unpaid;
};
public type Invoice = {
    status : InvoiceStatus;
    id : InvoiceId;
};
```

> For the purpose of this lesson, this example is oversimplied.  If you are interested in how a real invoice canister looks like, check the [invoice canister from DFINITY](https://github.com/dfinity/invoice-canister).

## Calling an actor by reference.
> For this section, check the source code in [ADD LINK].

The most straighforward way to call another canister it's **by reference**. This technique will always work, whether you are working locally or on mainnet but it requires two informations about the canister you want to call: 
1. The canister id.
2. The interface of the canister (at least partially).

For the sake of this example, we will assume that the `Invoice` canister is deployed with the following canister id: `rrkah-fqaaa-aaaaa-aaaaq-cai`. To call this canister from the `Secret` canister we use the following syntax in `secret.mo`. Any type used in the interface needs to be imported or defined previously in `secret.mo`.
```motoko
let invoiceCanister = actor("rrkah-fqaaa-aaaaa-aaaaq-ca") : actor {
    createInvoice : shared () -> async InvoiceId;
    checkStatus : shared (id : InvoiceId) -> async ?InvoiceStatus;
    payInvoice : shared (id : InvoiceId) -> async Result.Result<(), Text>;
};
```
Once `invoiceCanister` is defined, any function can be called can be called. For instance that's how you would call `createInvoice`.
```motoko
let invoiceId = await invoiceCanister.createInvoice();
```
When you import an actor by reference, you only need to specify the interface that you plan to use. For instance, if you take a look at `secret.mo` we never use the `payInvoice` function. That's why we could simplify the actor declaration.
```motoko
let invoiceCanister = actor("rrkah-fqaaa-aaaaa-aaaaq-ca") : actor {
    createInvoice : shared () -> async InvoiceId;
    checkStatus : shared (id : InvoiceId) -> async ?InvoiceStatus;
};
```
## Importing the other canister (locally) 
> For this section, check the source code in [ADD LINK].
## Importing the other canister (mainnet)
> For this section, check the source code in [ADD LINK].
## Async values.
## One way call.
## Message delivery failure.
## Commit point and rollbacks.
## Cross-subnet calls.
## Composite queries.