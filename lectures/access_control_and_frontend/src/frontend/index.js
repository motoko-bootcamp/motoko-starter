import { AnonymousIdentity } from "@dfinity/agent";
import { backend as default_backend_actor } from "../declarations/backend";
import { getActor, prepareLoginBotton, seedToIdentity } from "./identity";

const main = async () => {
  setupListeners();
  prepareLoginBotton(render);
  renderTable();
  poll();
};

document.addEventListener("DOMContentLoaded", main);

const render = () => {
  const identity = window.identity;
  const output = document.querySelector("#output");
  if (!output) throw new Error("Output element not found");
  if (identity) {
    output.innerHTML = identity.getPrincipal().toString();
    document.querySelector("#increment")?.removeAttribute("disabled");
    getCount();
    renderTable();
  } else {
    output.innerHTML = "";
    document.querySelector("#increment")?.setAttribute("disabled", "true");
  }
};

const setupListeners = () => {
  document.querySelector("#increment")?.addEventListener("click", increment);

  document.querySelector("#secret")?.addEventListener("input", handleChange);
};

const handleChange = async (event) => {
  const { value } = event.target;
  try {
    const identity = seedToIdentity(value);
    const output = document.querySelector("#output");
    if (!output) throw new Error("Output element not found");
    if (identity) {
      window.identity = identity;
    }
  } catch (error) {
    console.error(error);
  }
  render();
};

document.querySelector("#form")?.addEventListener("submit", async (event) => {
  event.preventDefault();
  return false;
});

const getCount = async () => {
  const identity = window.identity || new AnonymousIdentity();
  const actor = getActor(identity);
  const count = await actor.myCount();
  document.querySelector("#count").innerHTML = count;
  return count;
};

const renderTable = async (data) => {
  const counts = JSON.parse(await default_backend_actor.getCounts());
  counts.forEach(({ principal, count }) => {
    const existingRow = document.getElementById(principal);
    if (existingRow) {
      existingRow.querySelector(`td:nth-child(2)`).innerText = count;
      return;
    }
    const row = document.createElement("tr");
    row.id = principal;
    const principalCell = document.createElement("td");
    principalCell.innerText = principal;
    const countCell = document.createElement("td");
    countCell.innerText = count;
    row.appendChild(principalCell);
    row.appendChild(countCell);
    document.querySelector("#table tbody")?.appendChild(row);
  });
};

function increment() {
  if (!window.identity) return;
  getActor(window.identity)
    .increment()
    .then((count) => {
      document.querySelector("#count").innerHTML = count;
      renderTable();
    });
}

function poll() {
  setInterval(() => {
    getCount();
    renderTable();
  }, 5000);
}
