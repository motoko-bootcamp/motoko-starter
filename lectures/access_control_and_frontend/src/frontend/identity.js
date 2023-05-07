import LoginButton from "@dfinity/ii-login-button/dist/ii-login-button";
import { Ed25519KeyIdentity } from "@dfinity/identity";
import { canisterId, createActor } from "../declarations/backend";

/**
 * @type {LoginButton | null}
 */
const loginButton = document.querySelector("ii-login-button");
const output = document.querySelector("#output");

if (!loginButton) throw new Error("Login button not found");
if (!output) throw new Error("Output element not found");

/**
 * Sets up the custom element for the login button.
 * @returns {Promise<void>}
 */
export const prepareLoginBotton = async (renderCb) => {
  if (!customElements.get("ii-login-button")) {
    customElements.define("ii-login-button", LoginButton);
  }

  // Once the login button is ready, we can configure it to use Internet Identity
  loginButton?.addEventListener("ready", async (event) => {
    if (
      window.location.host.includes("localhost") ||
      window.location.host.includes("127.0.0.1")
    ) {
      loginButton.configure({
        loginOptions: {
          identityProvider: `http://${process.env.CANISTER_ID_INTERNET_IDENTITY}.localhost:4943`,
        },
      });
    }
  });

  loginButton?.addEventListener("login", async (event) => {
    const identity = loginButton?.identity;
    window.identity = identity;
    renderCb();
  });

  // ...
};

export function seedToIdentity(seed) {
  const seedBuf = new Uint8Array(new ArrayBuffer(32));
  if (seed.length && seed.length > 0 && seed.length <= 32) {
    seedBuf.set(new TextEncoder().encode(seed));
    return Ed25519KeyIdentity.generate(seedBuf);
  }
  return null;
}

export function getActor(identity) {
  return createActor(canisterId, {
    agentOptions: {
      identity,
    },
  });
}
