# Access Control

This project demonstrates a simple example of how to implement access control in a web application using Motoko and JS. The application tracks the number of times different users have clicked a button. We demonstrate two different strategies for authentication: using a secret key and authenticating with Internet Identity using the `@dfinity/ii-login-button` web component.

## Demo

You can try out the demo [here](https://qizwk-hqaaa-aaaab-qaida-cai.icp0.io/).

## How to run locally

### Prerequisites

- [Node.js](https://nodejs.org/en/download/) >= 12.0.0
- [DFINITY Canister SDK](https://internetcomputer.org/docs/current/tutorials/deploy_sample_app)

### Steps

1. Clone this repo and install dependencies:

```bash
git clone git@github.com:krpeacock/access-control-tutorial.git
cd access-control-tutorial
npm install
```

2. Start the local internet computer emulator:

```bash
dfx start --background --clean --host "127.0.0.1:4943"
```

3. Deploy the canisters:

```bash
dfx deploy
```

You can open the app there in your browser, or you can run the vite dev server:

```bash
npm run dev
```

## How it works

In the backend, the canister stores a map of counts with the principal as the key. The canister has three methods:

- increment
- getCount
- getCounts

The `increment` method increments the count for the principal that calls it. The `getCount` method returns the count for the principal that calls it. The `getCounts` method returns the counts for all principals.

The frontend has a single page. It includes an input that converts the string into an `Ed25519KeyIdentity`. It displays the principal that you will be calling with, and then anytime you click the button, it will update the count for that principal and display the new count.

There is also a button to log in with Internet Identity. This will open a popup that will prompt you to log in with Internet Identity. Once you log in, it will display your principal and you can click the button to increment your count.

Finally, there is a table of all the identities that have been used with the site.
