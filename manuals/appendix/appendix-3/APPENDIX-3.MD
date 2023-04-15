# Appendix 3: A new chapter in digital identity: Internet Identity.
## The end of username & passwords. 
Identity is at the core of our digital lives. In the rapidly evolving world of the internet, it has become more important than ever to have secure and trustworthy methods of accessing our personal accounts and spaces. <br/>
For years, the traditional way of logging into websites has been with passwords & usernames. 

<p align="center"> <img src="assets/password_username.jpeg" width="400px" style="border: 2px solid black;"></p>
<p align="center"> You are probably familiar with that type of interface.</p>

To create effective and secure passwords, one should:

- Select a long and randomly generated password.
- Avoid using the same password across multiple websites.

However, even when respecting basic security rules, this method of login has fundamental issues:
1. The server that grants authentication must store the username and password combination to verify the login and grant access. Although the password is often stored as a  hash, data breaches and leaks are still common.
2. Remembering and keeping track of passwords is a challenge, as most people have multiple accounts on various platforms, making it difficult to recall all of them. This is why the use of password managers and logging in through big tech companies (Apple, Facebook, Google, Microsoft) has become more prevalent.
3. Using passwords on a decentralized infrastucture like the Internet Computer is a bad idea. We are evolving in a world where we assume that some nodes can be malicious. If we need to send the password to all nodes, then it might leak at this point. 
## Login with BigTech
As a result, the use of password managers and logging in through big tech companies like Apple, Facebook, Google, or Microsoft has become more prevalent. However, this method of login has its drawbacks as well. It requires people to trust these big tech companies with their personal information and access to other websites.

<p align="center"> <img src="./assets/login_bigtech.png" width="300px" style="border: 2px solid black;"> </p>

With the increasing number of information we put online, do we really want to trust a  handful of private companies? 

<p align="center"> <img src="./assets/facebook_meme.jpeg" width="300px" style="border: 2px solid black;"> </p>

## Digital signatures 
Digital signatures are a more secure alternative to traditional username and password authentication. Digital signatures use a cryptographic technique to verify the authenticity of a message or document, ensuring that it has not been tampered with and that it comes from a verified sender. They are widely used in electronic transactions, such as online banking and e-commerce, as they provide a higher level of security and protection against fraud.

As the Internet Computer is built on a lot of cryptography, you won't be surprised to learn that they are used as a authentication mechanism for messages.
A digital signature scheme relies on 3 algorithms: 

1. **Key generation**: This algorithm is used to generate a public key and a private key. The public key is used to verify the digital signature, while the private key is used to create the digital signature.

2. **Signature**: This algorithm is used to create the digital signature using the private key. It applies a mathematical formula to the data that needs to be signed and the private key to generate a unique digital signature.

3. **Verification**: This algorithm is used to verify the digital signature using the public key. It applies a mathematical formula to the signed data, the digital signature, and the public key. If the output of the formula matches the original data, the digital signature is considered valid and the data is considered authentic.

<p align="center"> <img src="./assets/digital_signatures.png" width="800px" style="border: 2px solid black;"></p>

Of course, digital signatures have been already used intensively in the world of crypto! Everyone should know the famous saying: [Not your keys not your crypto](https://www.ledger.com/academy/not-your-keys-not-your-coins-why-it-matters). 
Users owning and mangaging their keys is great for security & decentralization, however it's not that easy. <br/> The main problem is keeping them secure & accessible.

<p align="center"> <img src="./assets/lost_bitcoins.jpeg" width="800px" style="border: 2px solid black;"></p>
<p align="center"> If you loose your keys, there is no backup! </p>

If we want to manage our entire digital identities using cryptographic keys while onboarding millions of people into Web3, it seems that there is a challenging project to solve here! How do we keep the benefits of digital signatures while making it easier to use for everyone? 
## Web Authentication
[WebAuthentication](https://webauthn.guide/), also known as WebAuth, is a web standard that attempts to solve the issues raised earlier and standardize logins using public-key cryptography. 


- When a user first register to a WebAuthn-enabled service: 
    1. A key pair is generated for you. 
    2. The private key is stored securely on your device.
    3. The public key is sent to the service and associate it with the user's account.



<p align="center"> <img src="./assets/webAuthn_registration.png" width="400px" style="border: 2px solid black;"></p>


- When the same user wants to login again:
    1. A challenge is generated by the service.
    2. The device attemps to verify your identity through authentication factors (FaceID, TouchID, YubiKey, Windows Hello...)
    3. If the verification is correct, the device will sign the challenge and send it back to the service. 
    4. If the signature is correct, the service will grant access.

<p align="center"> <img src="./assets/webAuthn_signature.png" width="400px" style="border: 2px solid black;"></p>

The device usually integrates a secure chip that stores the private key. Those chips are designed to **never leak the private key**, they are only able to create signature when requested. 

WebAuthentication is both secure & convenient.
## Messages on the Internet Computer
As we mentionned on  day 1, all requests sent to the Internet Computer are passed through messages. All those messages are signted. 

<p align="center"> <img src="./assets/message_authenticated.png" width="800px" style="border: 2px solid black;"></p>

A message contains the following information:
- ID of the target canister.
- Function called on this canister.
- Arguments provided for this functions. 
- A nonce that can be used to distinguish other two similar messages.

But more importantly, the message contains a signature! We can use this signature to verify the identity of the caller. 

> There is an identity which is called the **Anonymous** identity, and allows communication with the Internet Computer in a completely anonymous manner. The textual representation of principal associated with this identity is **2vxsx-fae**. You can try the `whoami` method yourself from the [Candid UI](https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.ic0.app/?id=sm7ch-cyaaa-aaaaj-qaz3q-cai) - when interacting from the Candid UI you are not authenticated so you should see the anonymous principal.
## Delegations
With WebAuthentication, whenever the user creates a signature his identity will be verified through the authentication factors that've mentionned before, usually asking the user for confirmation. 
Let's imagine that our user wants to do the 3 following actions:

1. Log in into DSCVR.
2. Update his user profile.
3. Post a message.


<p align="center"> <img src="./assets/withoutII_hell.png" width="800px" style="border: 2px solid black;"></p>
<p align="center"> Every single interaction with the network would require an user validation  🤦‍♂️ </p>

Since all messages are signed on the Internet Computer it would mean that we have to confirm our identity everytime that we interact with any canister! That would quickly be annoying for users. <br/>

The solution? **Delegation**! 
A delegation is a short-term pair of keys, that we create when an user log in. This pair of keys is stored locally and can be used for performing any number of actions, during a specific timeframe. 
The document that grants delegation is signed by the master pair of keys.
## Canister signature
Each subnet is able to create a signature that certifies a piece of data coming from the Internet Computer. A canister can request the subnet it is hosted in to create a signature on a specific data; this mechanism is called [certified variables](https://internetcomputer.org/how-it-works/response-certification/).

Building upon this mechanism, canisters are able to create signatures.
> If you want to know more about certified variables, check out this video & this repository.
[TODO: ADD MORE IMAGE OR TEXT]

Making use of WebAuthn, delegations & canister signatures, DFINITY has designed an identity solution called **Internet Identity**.<br/>
Internet Identity allows users to create sessions with Web3 services and dapps, and sign traditional blockchain transactions.
## Internet Identity
Internet Identity is a canister that manages your pair of keys and allows you to create short-term delegations top log in into other canisters. It does not store the private keys are those are securely stored on your device(s). 
Whenever you try to log in to a service through Internet Identity: a session key pair will be created on your device and stored locally, then once you've confirmed the log in you'll request the Internet Identity to create a signature and grant a delegation to your short 

1. Creation of an anchor: this is your identity to which you'll be able to add devices. 

2. Registration of device(s) to your anchor.
- You can register multiple devices to your identity. All registered devices have access to your identity.
- You need to have at least one registered device at any time - otherwise you'll not be able to access your identity and you'll have to use one the backup mechanisms that you've (hopefully) put in place.
- You can remove registered devices whenever you need. 

3. Connect to a dApp
    1. You are visiting your favorite application and want to log in using Internet Identity.
    2. Your identity is verified (Biometric authentication / USB security keys)
    3. A local short-term key pair is created.
    4. A **signed** message from your master key pair is sent to the Internet Identity canister, asking the canister to create a delegation for your local key pair.
    5. The delegation is sent back to your device and stored.
    6. You can now use the application with your local key pair and send along the delegation. You don't have to request a signature using WebAuthn for each message that you send.


[TODO : ADD ILLUSTRATIONS]