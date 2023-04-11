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
## Importing locally 
> For this section, check the source code in [ADD LINK].
When you a working locally, assuming that you canister is defined in `dfx.json` as follows.
```json
{
    "canisters": {
        "invoice": {
          "main": "invoice.mo",
          "type": "motoko"
        },
        "secret": {
            "main": "secret.mo",
            "type": "motoko"
        }
      }
}
```
You can  the following syntax at the top of your main file.
```motoko
import invoiceCanister "canister:invoice"
actor Secret  {

    let invoiceId = await invoiceCanister.createInvoice(); 

};
```
Generally, to import a canister locally, you use the following syntax at the top of your main motoko file:
```motoko
import Y "canister:X"
```
`X` is the name given in `dfx.json` to the canister you are tring to import. `Y` is how you want to reference the import in the following code.
## Importing on the mainnet
> This syntax is currently not available due to tooling limitations but will be available at some point.

## Finding the interface of a canister
Before calling another canisters, you might want to check its interface. To find the interface of any canister, you can use the [Internet Computer Dashboard](https://dashboard.internetcomputer.org/).

1. Navigate to the [the dashboard](https://dashboard.internetcomputer.org/).
<p align="center"> <img src="./assets/main-dashboard.png" width="500px" style="border: 1px solid black;"/> </p>

2. In the search bar, enter the ID of the canister you want to examine.
<p align="center"> <img src="./assets/ledger-dashboard.png" width="500px" style="border: 1px solid black;"/> </p>

3. Scroll down through the list of methods until you reach the **Canister Interface** section.
<p align="center"> <img src="./assets/canister-interface.png" width="500px" style="border: 1px solid black;"/> </p>

4. Here, you can view a list of all public types used and the interface of the service, that list all public methods.
<p align="center"> <img src="./assets/service-interface.png" width="500px" style="border: 1px solid black;"/> </p>

5. You can use the different tabs to see the interface in different languages (**Candid**, **Motoko**, **Rust**, **JavaScript**, **Typescript**).

<p align="center"> <img src="./assets/motoko-interface.png" width="500px" style="border: 1px solid black;"/> </p>

## Async values.
A canister processes its messages sequentially (one at-a-time), with each message representing a call to a public function.

Suppose you are **canister A** and you are calling **canister B**. The following sequence of events occurs:
- **Canister A** receives a message, which triggers a function. This function then initiates an inter-canister call which result in canister A sending a message to **canister B**.
- Canister B already has a queue of 2 messages, so the new message is added to the end of the queue.
- Canister A continues to receive and process additional messages, while canister B processes it's messages one-at-a time.
- Canister B eventually sends a response to canister A. The message is added to the queue of canister A.


<p align="center"> <img src="./assets/inter-canister-example.gif" width="500px" style="border: 1px solid black;"/> </p>

As you can see, between the instant you call a canister and the moment you receive a response, various events can happen, such as a user calling a function, an answer from a previous message returning, or another canister calling one of the public functions. These events can result in the internal state of the canister being significantly different from what you initially anticipated. **Always keep that in mind!**
## Intra-Subnet vs Inter-Subnet 
### Intra-Subnet
When canister A and canister B belong to the same subnet, consensus is not required for inter-canister calls. This is because the inter-canister call results from a message being processed has already been agreed upon during the previous consensus round. There is an upper limit to the amount of computation that can be handled within a single consensus round; however, assuming this limit is not surpassed, **canister A will** receive its response in the same round.
### Inter-Subnet
When **canister A** and **canister B** are located in different subnet, the situation is more complex. <br/>
The message needs to go through the **XNet messaging system**, which is a protocol of messages for cross-subnet interactions. <br/>
The XNet messaging system is composed of **subnet streams**. For instance assuming **canister A** is located in **subnet A** and sends a message to **canister B** located in **subnet B**, the message will go through the **subnet stream** of **subnet A** destinated to **subnet B**. This subnet stream is certified by the subnet every round, so that the other subnet can take a look at it and check the authenticity of messages (this is possible because **subnet B** knows the public key of **subnet A** and can verify the signature on the certification).

This will lead to the following scenario:
1. A message is sent to a user to **canister A**, this message needs one round of consensus to be processed by the subnet.
2. This message is processed by **canister A**, this message triggers an inter-canister call. This inteer-canister call triggers a message in the subnet steam of **subnet A** dedicated to **subnet B**. This stream needs to be certified by the subnet, which is done at the end of the execution cycle.
3. **Subnet B** receives the message as part of the subnet stream coming from **Subnet A**, checks the authencitiy and add the message into a block to process it.
4. 
## Message delivery failure
WIP
## Commit point and rollbacks
WIP
## Composite queries.
WIP