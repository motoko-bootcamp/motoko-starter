# Capítulo 11: Llamadas intercanister
Para lograr la visión de Internet Computer, los servicios (es decir, canisters) deben poder llamarse entre sí y ejecutarse de manera interoperable. Esta capacidad se logra a través de las **llamadas intercanister**. En este capítulo, veremos cómo podemos realizar tales llamadas y los posibles problemas a evitar.
## Un ejemplo simple
Para ilustrar las llamadas intercanister, usaremos el siguiente ejemplo con 2 canisters:
1. Canister secreto: Este canister almacena una contraseña secreta y esta contraseña solo debe ser revelada a los usuarios que hayan pagado. Para verificar los pagos, se usa un mecanismo de facturas.
```motoko
actor Secret {
    getPassword : shared () -> async Result.Result<Text, Text>;
};
````
2. Canister de facturas: Este canister es responsable de crear, almacenar y verificar el estado de las facturas.
```motoko
actor Invoice {
    createInvoice : shared () -> async InvoiceId;
    checkStatus : shared (id : InvoiceId) -> async ?InvoiceStatus;
    payInvoice : shared (id : InvoiceId) -> async Result.Result<(), Text>;
};
```
Donde las facturas se definen de la siguiente manera:
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

> Para esta lección, este ejemplo está simplificado. Si estás interesado en cómo se ve un canister de facturas real, consulta el [canister de facturas de DFINITY](https://github.com/dfinity/invoice-canister).

## Llamando a un actor por referencia
> Para esta sección, consulta el código fuente en [AGREGAR ENLACE].

La forma más directa de llamar a otro canister es **por referencia**. Esta técnica siempre funcionará, ya sea que estés trabajando localmente o en mainnet, pero requiere dos informaciones sobre el canister que deseas llamar:
1. El ID del canister.
2. La interfaz del canister (al menos parcialmente).

Para este ejemplo, asumiremos que el canister `Invoice` está desplegado con el siguiente ID de canister: `rrkah-fqaaa-aaaaa-aaaaq-cai`. Para llamar a este canister desde el canister `Secret`, usamos la siguiente sintaxis en `secret.mo`. Cualquier tipo utilizado en la interfaz debe ser importado o definido previamente en `secret.mo`.
```motoko
let invoiceCanister = actor("rrkah-fqaaa-aaaaa-aaaaq-ca") : actor {
    createInvoice : shared () -> async InvoiceId;
    checkStatus : shared (id : InvoiceId) -> async ?InvoiceStatus;
    payInvoice : shared (id : InvoiceId) -> async Result.Result<(), Text>;
};
```
Una vez que `invoiceCanister` está definido, se puede llamar a cualquier función. Por ejemplo, así es como llamarías a `createInvoice`.
```motoko
let invoiceId = await invoiceCanister.createInvoice();
```
Cuando importas un actor por referencia, solo necesitas especificar la interfaz que planeas usar. Por ejemplo, si miras `secret.mo`, nunca usamos la función `payInvoice`. Es por eso que podemos simplificar la declaración del actor.
```motoko
let invoiceCanister = actor("rrkah-fqaaa-aaaaa-aaaaq-ca") : actor {
    createInvoice : shared () -> async InvoiceId;
    checkStatus : shared (id : InvoiceId) -> async ?InvoiceStatus;
};
```
## Importando localmente
> Para esta sección, consulta el código fuente en [AGREGAR ENLACE].
Cuando estás trabajando localmente, suponiendo que tu canister está definido en `dfx.json` como sigue:
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

Cuando importas un actor por referencia, solo necesitas especificar la interfaz que planeas usar. Por ejemplo, si miras `secret.mo`, nunca usamos la función `payInvoice`. Es por eso que podemos simplificar la declaración del actor.

## Importando localmente
> Para esta sección, consulta el código fuente en [AGREGAR ENLACE].
Cuando estás trabajando localmente, suponiendo que tu canister está definido en `dfx.json` como sigue:

`X` es el nombre dado en `dfx.json` al canister que estás intentando importar. `Y` es cómo quieres referenciar la importación en el siguiente código.

## Importando en Mainnet
> Esta sintaxis no está disponible actualmente debido a limitaciones en las herramientas, pero estará disponible en algún momento.

## Encontrar la interfaz de un canister
Antes de llamar a otros canisters, es posible que desees verificar su interfaz. Para encontrar la interfaz de cualquier canister, puedes usar el [Internet Computer Dashboard](https://dashboard.internetcomputer.org/).

1. Navega hasta [el dashboard](https://dashboard.internetcomputer.org/).
<p align="center"> <img src="./assets/main-dashboard.png" width="500px" style="border: 1px solid black;"/> </p>

2. En la barra de búsqueda, ingresa el ID del canister que deseas examinar.
<p align="center"> <img src="./assets/ledger-dashboard.png" width="500px" style="border: 1px solid black;"/> </p>

3. Desplázate hacia abajo por la lista de métodos hasta llegar a la sección **Canister Interface**.
<p align="center"> <img src="./assets/canister-interface.png" width="500px" style="border: 1px solid black;"/> </p>

4. Aquí, puedes ver una lista de todos los tipos públicos utilizados y la interfaz del servicio, que lista todos los métodos públicos.
<p align="center"> <img src="./assets/service-interface.png" width="500px" style="border: 1px solid black;"/> </p>

5. Puedes usar las diferentes pestañas para ver la interfaz en diferentes lenguajes (**Candid**, **Motoko**, **Rust**, **JavaScript**, **Typescript**).

<p align="center"> <img src="./assets/motoko-interface.png" width="500px" style="border: 1px solid black;"/> </p>

## Valores asincrónicos
Un canister procesa sus mensajes secuencialmente (uno a la vez), siendo cada mensaje una llamada a una función pública.

Supongamos que eres **canister A** y estás llamando a **canister B**. La siguiente secuencia de eventos ocurre:
- **Canister A** recibe un mensaje, lo que activa una función. Esta función luego inicia una llamada inter-canister que resulta en que el canister A envíe un mensaje a **canister B**.
- El canister B ya tiene una cola de 2 mensajes, por lo que el nuevo mensaje se agrega al final de la cola.
- El canister A continúa recibiendo y procesando mensajes adicionales, mientras que el canister B procesa sus mensajes uno a la vez.
- El canister B eventualmente envía una respuesta al canister A. El mensaje se agrega a la cola del canister A.

<p align="center"> <img src="./assets/inter-canister-example.gif" width="500px" style="border: 1px solid black;"/> </p>

Como se puede ver, entre el momento en que llamas a un canister y el momento en que recibes una respuesta, pueden ocurrir varios eventos, como un usuario llamando a una función, una respuesta de un mensaje anterior que regresa o otro canister que llama a una de las funciones públicas. Estos eventos pueden resultar en que el estado interno del canister sea significativamente diferente de lo que inicialmente anticipaste. **¡Siempre ten eso en cuenta!**

## Intra-Subred vs Inter-Subred
### Intra-Subred
Cuando el canister A y el canister B pertenecen a la misma subred, no se requiere consenso para las llamadas inter-canister. Esto se debe a que la llamada inter-canister se produce a partir de un mensaje que ya se ha acordado durante la ronda de consenso anterior. Existe un límite superior para la cantidad de cómputo que se puede manejar dentro de una sola ronda de consenso; sin embargo, suponiendo que no se supera este límite, **el canister A** recibirá su respuesta en la misma ronda.
### Inter-Subred
Cuando **canister A** y **canister B** se encuentran en subredes diferentes, la situación es más compleja. <br/>
El mensaje debe pasar por el **sistema de mensajería XNet**, que es un protocolo de mensajes para interacciones entre subredes. <br/>
El sistema de mensajería XNet está compuesto por **flujos de subred**. Por ejemplo, suponiendo que **canister A** se encuentra en **subred A** y envía un mensaje a **canister B** ubicado en **subred B**, el mensaje pasará por el **flujo de subred** de **subred A** destinado a **subred B**. Este flujo de subred está certificado por la subred cada ronda, de modo que la otra subred puede verlo y verificar la autenticidad de los mensajes (esto es posible porque **subred B** conoce la clave pública de **subred A** y puede verificar la firma en la certificación).

Esto llevará al siguiente escenario:
1. Se envía un mensaje a un usuario a **canister A**, este mensaje necesita una ronda de consenso para ser procesado por la subred.
2. Este mensaje es procesado por **canister A**, este mensaje desencadena una llamada inter-canister. Esta llamada inter-canister desencadena un mensaje en el flujo de subred de **subred A** dedicado a **subred B**. Este flujo debe ser certificado por la subred, lo que se hace al final del ciclo de ejecución.
3. **Subred B** recibe el mensaje como parte del flujo de subred que viene de **Subred A**, verifica la autenticidad y agrega el mensaje a un bloque para procesarlo.
4. 

## Fallo en la entrega de mensajes
WIP
## Punto de compromiso y rollbacks
WIP
## Consultas compuestas.
WIP
