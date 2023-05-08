# Capítulo 4: Candid el lenguaje del Internet Computer.
## Porque necesitamos Candid? 
Imaginemos la siguiente situación:

-  Estamos escribiendo un canister en **Motoko** y hemos definido un valor `n` de tipo Nat.
```motoko
let n : Nat = 5;
```
- Conocemos otro canister que expone una función pública `square` que devuelve el `cuadrado` de un número dado, este canister está escrito en **Rust**.

Queremos calcular el cuadrado de un valor `n`, pero somos bastante perezosos y no queremos implementar la función `square` en el canister de **Motoko** , por el contrario queremos hacer uso de la función que ya existe en el canister de **Rust**.Esto es posible y hará uso de las **intercanister-calls** (un concepto más avanzado que veremos con más detalle en otra lección).

El problema es el siguiente: `n` es del tipo `Nat` y la función `square` solamente acepta valores del tipo `u128`. Pero, en **Motoko**, el tipo `u128` no existe! es como intentar comunicarte en español con alguien que habla chino.

<p align="center"> <img src="./assets/rust_motoko_situation.png" width="600px" style="border: 2px solid black;"> </p>
<p align="center"> La comunicación puede ser difícil en ocasiones...</p>

>Componer servicios (i.e canisters) escritos en diferentes idiomas es la visión central del **Internet Computer**. Como resolvemos este problema fundamental entre canisters?

## Que es un IDL?
Necesitamos introducir un **Interface Description Language (IDL)**. Un interface description language (**IDL**es un término genérico para un lenguaje que permite a un programa escrito en un lenguaje comunicarse con otro programa escrito en un otro lenguaje distinto.

**Candid** es un **IDL** que describe los servicios públicos desplegados en un canister en el **Internet Computer**. La interfaz Candid  permite inter-operation entre servicios , y entre servicios y frontends, independientemente del lenguaje de programación usado. <br/>

Candid resuelve el problema que hemos planteado anteriormente al permitir una correspondencia entre tipos en distintos idiomas. 

<p align="center"> <img src="./assets/candid_mapping.png" width="600px" style="border: 2px solid black;"> </p>

## Candid file (.did)
Un documento **Candid** es un documento con la extensión .did -  podemos definir la interfaz del canister `square` con el siguiente documento .did:
```candid
service : {
  square: (nat) -> (nat) query;
}
```

En este caso , nuestro servicio tiene una función única llamada `square`. Esta función toma un `nat` y devuelve un `nat`. Fijate que usamos la palabra clave `query`.

<p align="center"> <img src="./assets/candid_solved.png" width="600px" style="border: 2px solid black;"> </p>
<p align="center"> Candid es el espacio común para todos los canisters para resolver sus conflictos!</p>

El `nat` usado aquí no es el mismo que el tipo `Nat` en **Motoko**, o cualquier tipo en **Rust**. Si el canister `square`fue escrito en Motoko la interfaz  Candid interface será exactamente igual.  La descripción del servicio es independiente del lenguaje en el que fue escrita -  ¡esta es la clave!

Candid resuelve el problema que hemos planteado anteriormente al permitir una correspondencia entre tipos en distintos idiomas.

<p align="center"> <img src="./assets/candid_mapping.png" width="600px" style="border: 2px solid black;"> </p>

El tipo `u128` será convertido a `nat` el cual es convertido a `Nat` en el canister de **Motoko**. Esto hace posible el escribir el siguiente código:

```motoko
actor {
    let n : Nat = 5;

    //Definimos el otro canister en nuestro propio código.
    let rustActor : actor = {
        square : Nat -> Nat;    // Aqui usamos tipos de Motoko  
    };

    public func getSquareOfN() : async Nat {
        await rustActor.square(n);  // Así es como puedes llamar a otro canister- impresionante, verdad?! 
    };

};
```
> Candid en ocasiones es llamado "** el lenguaje del Internet Computer**" ya que así es como los canisters se comunican entre ellos. Raramente deberás escribir Candid pero es importante entender porque Candid fue creado, como leer lo, y como funciona a que encontrarás documentos Candid en los proyectos que trabajes. 
## Interactuar con un canister
Para seguir esta parte, es muy recomendado que despliegues localmente el ejemplo llamado greet application que es entregado con `dfx`.
Genera el código para este ejemplo ejecutando
```bash
$ dfx new greet
```
2.  Inicia tu replica local.
```bash
$ dfx start --clean
```
3. Abre otra ventana de la terminal y despliega el proyecto.
```bash
$ dfx deploy 
```
La interfaz Candid es automáticamente generada cuando construyes un proyecto en Motoko, pero esta también puede ser escrita manualmente. En este simple formulario, el documento Candid DID contiene una descripción del servicio. Cuando el proyecto es desplegado, el documento `greet.did` contendrá la siguiente descripción del servicio:
```candid
service : {
  greet: (text) -> (text) query;
}
```
> Puedes localizar el documento . did en .dfx/local/canisters/greet_backend. Si no lo ves asegurate que has construido y desplegado el proyecto.

La dApp greet tiene una función pública: `greet(text)`. Por la descripción del servicio podemos observar, que la función greet() toma un text y devuelve otro text, y el servicio es una función query (ejecución más rápida). 

Puedes ver mas usos avanzados de Candid en la [documentacion](https://internetcomputer.org/docs/current/developer-docs/build/candid/candid-concepts) o en otros ejemplos [Motoko examples](https://github.com/dfinity/examples/tree/master/motoko).

La interfaz Candid, como ya mencionamos anteriormente, permite inter-operación entre servicios, y entre servicios y frontends. Candid es muy útil para llamar canisters desde distintos lugares:
- Usando la terminal con `dfx`. 
- Usando la Candid UI. 
- Usando un frontend (webpage) con el agente JavaScript.  

<b> Revisemos los diferentes métodos! </b>

## <a id="using-the-terminal"> 📺 Usando la terminal (dfx) </a>
La interfaz  Candid te permite llamar a los servicios backend o funciones desde la línea de comandos. Esto es útil para las tareas administrativas que no requieren un frontend o para probar el backend. En el ejemplo de la dApp Greet, puedes llamar al método greet() mediante la ejecución del comando:
```bash
$ dfx canister call greet_backend greet '("motoko")'
("Hello, motoko!")
```
La estructura general para llamar a cualquier método desde cualquier canister es el siguiente:
```bash
$ dfx canister call <CANISTER_NAME OR CANISTER_ID> <METHOD_NAME> '(ARGUMENT)'
```
Si quieres llamar a un canister en la red principal, necesitas añadir la bandera --network ic:
```bash
$ dfx canister --network ic call <CANISTER_NAME OR CANISTER_ID> <METHOD_NAME> '(ARGUMENT)'
```
> Nota que cuando usas  dfx debes poner tus argumentos entre paréntesis "**()**". El formato para los argumentos es el formato Candid. 

Para mas informacion sobre como llamas canisters desde la linea de comandos, mira la [documentacion](https://internetcomputer.org/docs/current/references/cli-reference/dfx-canister).

## <a id="candid-ui"> 📲 Candid UI </a>
Mientras que la línea de comandos puede ser muy práctica, hay una manera más fácil de llamar a los servicios del backend, y eso es mediante el uso de Candid UI. Cuando un proyecto es desplegado, además de las interfaces Candid, también se despliega un canister que ejecuta el UI. El proceso de construcción mostrará la URL en la consola, pero la URL también se puede encontrar en `greet/.dfx/local/canister_ids.json`:

```json
{
  "__Candid_UI": {
    "local": "r7inp-6aaaa-aaaaa-aaabq-cai"
  },
  "greet_backend": {
    "local": "rrkah-fqaaa-aaaaa-aaaaq-cai"
  },
  "greet_frontend": {
    "local": "ryjl3-tyaaa-aaaaa-aaaba-cai"
  }
}
```
En este caso la URL al Candid UI es http://127.0.0.1:4943/?canisterId=r7inp-6aaaa-aaaaa-aaabq-cai&id=rrkah-fqaaa-aaaaa-aaaaq-cai

> Es posible que la URL para el Candid UI sea diferente en tu computadora. Asegúrate de ajustar la URL basándote de el canister IDs en tu propio documento.

Simplemente haz click en los botones **Query** , y observa la respuesta en el Output Log.
<p align="center"> <img src="assets/candid_ui_local.png" width="600px" style="border: 2px solid black;"> </p>

<b> Local or Live? </b> <br/>
Una confusión importante de a evitar es la diferencia entre local y live Candid UIs:

- El [live Candid UI](https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.ic0.app/) es unio para el Internet Computer - puedes acceder la interfaz de cualquier dApp ( asumiendo que el documento candid ha sido entregado). Usando el Candid UI puedes directamente modificar el estado de un canister. 

- El local Candid UI que probamos anteriormente es desplegado solamente en tu réplica local. Este solo puede darte acceso al canister que has desplegado localmente.

> Sin embargo - el Candid UI (live o local) es desplegado también en un canister.

## <a id="using-the-frontend"> 📑 Using Candid en el frontend </a>
La  dApp greet tiene ambos un backend y un frontend, y el frontend accede a los servicios del backend a través de la interfaz Cadid. La código fuente del proyecto está organizado en los siguientes tres carpetas:

- declarations
- greet_backend 
- greet_frontend

Demos un vistazo al documento  del frontend  JavaScript localizado en `src/greet_frontend/src/index.js`. Este documento es responsable de manipular la lógica del front-end de la dApp greet. El front-end y back-end están conectados usando la interfaz Candid la cual permite al front-end acceder a los servicios del back-end.

```javascript
import { greet_backend } from "../../declarations/greet_backend";

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const button = e.target.querySelector("button");

  const name = document.getElementById("name").value.toString();

  button.setAttribute("disabled", true);

  // Interactúa con foo actor, llamando al método greet
  const greeting = await greet_backend.greet(name);

  button.removeAttribute("disabled");

  document.getElementById("greeting").innerText = greeting;

  return false;
});
```
Dos líneas de código en este documento merecen la pena prestarles atención. La primera línea es donde la descripción del servicio Candid es importada, y en este caso, no es el documento greet.did sino que es el documento index.js. El Candid index.js es automáticamente generada cuando el proyecto es construido e importa los servicios del backend de Motoko.

```javascript
import {greet_backend } from "../../declarations/greet_backend";
```
Después de importar la interfaz Candid podemos usar los servicios públicos del backend, lo cual se puede observar en esta línea:

```javascript
const greeting = await greet_backend.greet(name);
```
La función update `greet()` es llamada con name como parámetro, la cual devolverá el mensaje del greeting. La llamada es asíncrona por lo que un **await** es añadido asique el frontend está a la espera de una respuesta para pasar al siguiente paso.

Bastantes agents son desarrollados por ambos DFINITY y la comunidad para integrar fácilmente la interfaz Candid en diferentes lenguajes de programación. Mira la [documentacion](https://internetcomputer.org/docs/current/developer-docs/build/agents/) para una lista de los agentes disponibles.
