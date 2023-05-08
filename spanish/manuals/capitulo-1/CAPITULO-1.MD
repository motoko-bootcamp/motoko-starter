# Chapter 1: Fundamental concepts.
##  ¿Qué es un canister?
Hay una palabra que necesitas dominar absolutamente de toda esta semana. ¿Estás listo? 
Es... 🥁... **CANISTER**! 

El Internet Computer es una plataforma que aloja un gran número de aplicaciones, todas estas aplicaciones se ejecutan sin problema dentro de los contenedores especiales llamados **canisters**. 

- El Internet Computer es responsable de ejecutar sin problema y con seguridad todos los canisters desplegados en la plataforma en paralelo.
- Los desarrolladores construyen aplicaciones escribiendo el código fuente para esos canisters. Una aplicación puede ser construida en uno o varios canisters dependiendo de la arquitectura.
- Los usuarios interactúan con las aplicaciones mediante el envío de mensajes a los canisters. Esto pasa siempre que usas una aplicación en el Internet Computer e interactúas con ella - unos ejemplos de dicha interacciones son:
    - Cuando publicas en una red social.
    - Cuando envías un token a otra dirección.
    - Cuando vendes o compras un NFT.
    - Cuando lees contenido en un sitio web alojado en el Internet Computer.
    - Y muchas más...

<p align="center"> <img src="./assets/oc_message.png" height="600px" style="border: 1px solid black;"/> </p>
<p align="center"> OpenChat es una aplicación de mensajes descentralizada desarrollada en el Internet Computer. </p>

## WebAssembly
Antes de empezar con Motoko - necesitamos explicar otro término: **WebAssembly**.

<p align="center"> <img src="./assets/canister_overview.png" width="800px" style="border: 2px solid black;"> </p>
<p align="center"> Vista general de un canister.</p>

Si hacemos zoom dentro de un canister podemos observar que esta compuesto de:
- Un **WebAssembly module** el cual es una pieza de código compilado de lenguajes como Rust o Motoko. Este es el código que es instalado en el canister y en última instancia es ejecutado. 
-  **WebAssembly memory** - también llamadas páginas de memoria. Aquí es donde el estado del canister es almacenado y los documentos son almacenados (fotos, videos, tokens...). El código ejecutado por el WebAssembly module modificara la memoria.

<p align="center"> <img src="./assets/webassembly.png" width="600px" style="border: 2px solid black;"> </p>

<p align="center"> ¿Qué es <b> WebAssembly </b>? <p>
WebAssembly es un formato binario de bajo nivel para ejecutar código de múltiples entornos  (browsers, cloud platform, smart devices, virtual machine..). Los beneficios principales de usar WebAssembly son, 

- **WebAssembly** admite código escrito en múltiples lenguajes (C, C++, Rust, Motoko) haciendo de esta una solución versátil para los desarrolladores.
- **WebAssembly** code es  portable y se puede ejecutar en casi cualquier dispositivo.Lo escribes una vez y puedes ejecutarlo en cualquier lugar!
<p align="center"> <img src="./assets/webassembly_stack.png" width="500px" style="border: 1px solid black;"/> </p>
<p align="center"> Escribe una vez y se despliega en cualquier plataforma. </p>

- **WebAssembly** es rápido. Es un lenguaje que es cercano al  lenguaje de la máquina y ha sido optimizado para aumentar la velocidad y el rendimiento. Puedes usarlo para crear aplicaciones complejas e intensivas (Juegos,simulaciones, gráficos)!
- **WebAssembly** proporciona un entorno de ejecución seguro, colocando el código en una zona especial denominada sandbox (caja de arena).  Sandbox se asegura de que el programa es solamente capaz de hacer cosas y acceder a recursos a los que se le ha concedido acceso y bi se le permite acceder a información sensible. Esto ayuda bastante cuando tratamos de escribir código seguro o para que los usuarios se aseguren de que no se verán perjudicados por la ejecución del código en sus máquinas.


El único problema con **WebAssembly** es que es un lenguaje de bajo nivel  y este provee muy poca abstracción, haciendo difícil su uso para escribir aplicaciones complejas como dApps (aplicaciones descentralizadas).

## El lenguaje Motoko
<p align="center"> <img src="./assets/motoko_banner.png" width="600px" style="border: 1px solid black;"/> </p>

Este es el porque  [DFINITY Foundation](https://dfinity.org/) ha creado un nuevo lenguaje llamado **Motoko**, el cual es un lenguaje de programación diseñado específicamente para crear aplicaciones descentralizadas (dApps) en el  Internet Computer. Desde que el código de Motoko puede ser directamente compilado en **WebAssembly**, es un lenguaje increíble para construir en el Internet Computer. Motoko es un lenguaje de alto nivel, que es fácil de usar. Escribes en Motoko y luego es compilado para ti en WebAssembly.

<p align="center"> <img src="./assets/motoko_to_wasm.png" width="600px" style="border: 1px solid black;"/> </p>
<p align="center">En Motoko el código se hila , En WebAssembly se ejecuta.</p>

> Vale la pena señalar que WebAssembly, fue co-diseñado por [Andreas Rossberg](https://github.com/rossberg), quien se unio a la  DFINITY Foundation a principios de 2017 para trabajar en el entorno de ejecución canister smart contract y es además el diseñador original del lenguaje Motoko. La norma es mantenida por  [World Wide Web Consortium](https://www.w3.org/). 

En el siguiente ejemplo. podemos encontrar una función  `factorial`,ilustrada en **Motoko** y **WebAssembly**.
No te estreses si no entiendes nada - eso es normal:

<table align="center">
  <tr>
    <th> Motoko </th>
    <th>WebAssembly (Binary)</th>
  </tr>
<td><pre>
func factorial(n : Nat) : Nat {
    if(n == 0) {
        return 1
    } else {
        return factorial(n - 1);
    }
};
</pre></td>

<td><pre>
20 00
42 00
51
04 7e
42 01
05
20 00
20 00
42 01
7d
10 00
7e
0b
</pre></td>
</tr>
</table>
<p align="center"> ¿Qué opinas? Escribir esta función con < b > Motoko </b> parece fácil? </p>

Un documento Motoko es un documento con la extensión `mo`.

<p align="center"> <img src="./assets/mo_extension.png" width="300px" style="border: 2px solid black;"> </p>

**Motoko** es un lenguaje de alto nivel como **JavaScript** o **Python**. Generalmente es considerado más fácil de aprender que un lenguaje de más bajo nivel como **Rust** o **C**. 

---
<i> Motoko tiene una mascota cool que ha sido intensivamente utilizada y modificada en la comunidad, para todo tipo de propósitos!
Por lo que no solamente podrás construir impresionantes aplicaciones con Motoko, sino que también tendrás el mejor logo de todos. ¿No nos crees? Entonces te invito que veas el [Motoko NFT market](https://entrepot.app/marketplace/motoko) y compruebalo tu mismo. </i>

## El actor model.
Si tu abres un documento Motoko, hay una gran probabilidad de que la primera palabra que leas sea `actor`:
```
actor {

    /// CODE

};
````
Un **actor** es como un canister es representado y abstraído en **Motoko**. Estos términos vienen del [Actor model](https://en.wikipedia.org/wiki/Actor_model) el cual es una manera de escribir programas de ordenador que pueden manejar múltiples tareas a la vez. Esto se consigue gracias a que los **actors** son tratados como los bloques básicos de un programa. <br/>
Un  actor es un pequeño programa de ordenador que puede recibir mensajes, realizar un trabajo y enviar mensajes a otros actors. Actors también pueden crear nuevos actors y controlarlos. Todos los actors se comunican mediante el envío de mensajes. Dado que toda la interacción entre los actores se realiza mediante el paso de mensajes, permite niveles muy altos de concurrencia y paralelismo, lo que lo hace muy adecuado para distributed systems. En ese sentido, **El Internet Computer es un ordenador distribuido donde cada programa es un canister !** 


Ya que los canisters han sido implementados para seguir el actor model - no te sorprenderás de aprender que los canisters:

- Tienen un private state (memoria) & pueden ejecutar cálculos.
- Reciben mensajes de los usuarios u otros canisters.
- Pueden enviar mensajes  a los usuarios u otros canisters.
- Pueden crear otros canisters.


<p align="center"> <img src="./assets/actor_model.gif" width="800px" style="border: 2px solid black;"></p>
<p align="center">Un canister recibe un mensaje, lo ejecuta y posiblemente envía otro mensaje a otros canisters (o incluso crea uno nuevo) en respuesta. </p>

Consideremos el siguiente actor:
```motoko
actor {
    var message : Text = "Hello Motoko Bootcamp!";

    public func changeMessage(t : Text) : async () {
        message := t;
    };

    public query func readMessage() : async Text {
        return message;
    };
};
```
Podemos ver que este actor tiene:
- Una variable llamada`message`, que es inicializada con el valor `Hello Motoko Bootcamp`.
- Dos funciones públicas:
    - `changeMessage` la cual actualiza el valor de `message` a lo que sea que es proporcionado como argumento.
    - `readMessage` la cual muestra el valor de  `message` sin modificarlo. 

La palabra clave  `public` indica que ambas funciones pueden ser llamadas desde fuera por los usuarios u otros canisters. Las funciones  `public` de un actor representan la [API](https://en.wikipedia.org/wiki/API) de el canister. 
## Update vs Query
¿Te has dado cuenta de la palabra clave `query`en ejemplos anteriores? 
<br/> Cuando un usuario llama a un canister, es importante distinguir dos tipos de calls::

### Update calls
Update calls son usadas cuando el usuario quiere modificar el estado de un canister. Para asegurar la integridad del Internet Computer, estas calls deben ser procesadas a través de un consenso y por todos los nodos, lo que resulta en un retraso de alrededor de 1-2 segundos. Una update call será usada en las siguientes situaciones:
- Publicar en redes sociales, como [DSCVR](https://dscvr.one/).
- Enviar un mensaje en una aplicación de mensajes, como [OpenChat](https://oc.app/).
- Enlazar o compartir contenido en [Distrikt](https://az5sd-cqaaa-aaaae-aaarq-cai.ic0.app/).
- Comprar un NFT en [Entrepot](https://entrepot.app/).

<p align="center"> <img src="./assets/update_call_gif.gif" width="800px" style="border: 2px solid black;"></p>

### Query calls
Este tipo de call es usada cuando un usuario quiere leer datos sin modificar su estado.       Estas calls pueden ser respondidas por un solo node, haciendo que estas sean más rápidas (alrededor de 200ms). La parte negativa es que **query** calls son menos seguras ya que un un node malicioso potencialmente puede proveer información falsa. Una query call será usada en las siguientes situaciones:
- Leer un artículo en [Nuance](https://nuance.xyz/).
- Revisar tu foto de perfil en 
- Cargar un video o una foto en cualquier plataforma.

<p align="center"> <img src="./assets/query_call_gif.gif" width="800px" style="border: 2px solid black;"></p>

>Ya que una query call elude el consenso y recae en un único node, esta es menos segura que una update call.


|  | Update call | Query call |
|-----------------|-----------------|-----------------|
Tiempo de respuesta | 2-5 segundos 🐢  | 200-400 ms ⚡️  |
Consenso| Yes | No |  
Lectura | Yes | Yes |
Escritura| Yes | No |
Coste | Cuesta cycles | Gratis (por ahora)


Volvamos a nuestro actor anterior
```motoko
actor {
    var message : Text = "Hello Motoko Bootcamp!";

    public func changeMessage(t : Text) : async () {
        message := t;
    };

    public query func readMessage() : async Text {
        return message;
    };
};
```

La palabra clave `query` nos indica que la  función `readMessage` es solo para leer información. En cambio, `readMessage` puede actualizar el estado (No necesitamos añadir la palabra clave `update` ya que esta se asume por defecto). 

> Hemos desplegado el actor anterior en el Internet Computer - y tu puedes acceder <a href="https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.ic0.app/?id=rhjue-eaaaa-aaaaj-qazra-cai" target="_blank"> su API. </a> Prueba la interfaz y comprueba la diferencia de velocidades entre `changeMessage` & `readMessage`. Diviértete y deja un mensaje amable para el siguiente estudiante.

## Combustible en el Internet Computer: cycles.
Para pagar el coste de computación y almacenamiento los canisters deben ser cargados con **cycles**.
Cada canister tiene su propio balance de **cycles**  - esto se puede entender como la bateria vital de un **canister**. 
**Cycles** pueden obtenerse mediante el quemado de **ICPs**.

<p align="center"> <img src="./assets/cycles_burned.gif" width="600px" style="border: 2px solid black;"> </p>
<p align="center"> Cuando se procesa un nuevo mensaje, los cycles son restados del balance del canister y son quemados.</p>

A diferencia de **gas** en **Ethereum**, **cycles** en el **Internet Computer** no son pagados por los usuarios. Esto significa que puedes interactuar con los canisters y navegar por sitios web sin pagar nada. Esto se conoce como el  **modelo reverse-gas** y es una gran mejora para la experiencia de los usuarios ya que elimina la necesidad de crear wallets, poseer tokens y pagar altas tasas.

Los Cycles se miden en trillones (T), lo que es equivalente a 1,000,000,000,000 o 10^12. Un trillón de cycles siempre costará 1 XDR,el cual es una moneda basada en los tipos de cambio del mercado que representa una mayor basket(cesta) de la mayoría de monedas. En este momento, 1 XDR es equivalente a $1.34. El precio de los cycles no se ve afectado por el precio de los ICP tokens. En su lugar, el ratio de conversión de ICP tokens a cycles es constantemente ajustado mediante la monitorización del predio de ICP.

Cada operación realizada en la red tiene un coste vinculado a ella:
- Crear un canister.
- Ejecutar un mensaje actualizado.
- Ejecutar una inter-canister call.
- Almacenar datos.
- Realizar una HTTPS outcall.
- Cálculo de un threshold ECDSA signature.

El coste de estas operaciones también depende en la subred donde estas son realizadas y el **factor de replicación** de esta subred. El factor de replicación corresponde al número de nodes en una subred, el cual puede comprender un rango de 13 a 40.
