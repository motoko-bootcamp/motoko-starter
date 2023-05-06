# Capítulo 1: Conceptos Fundamentales
## ¿Qué es un Canister?
Hay una palabra que necesitas dominar absolutamente durante esta semana. ¿Estás listo? Es... 🥁... **CANISTER**!

El Internet Computer es una plataforma que aloja una gran cantidad de aplicaciones, todas las cuales se ejecutan sin problemas en contenedores especiales llamados **canisters**.

- El Internet Computer se encarga de ejecutar de manera fluida y segura todos los canisters implementados en la plataforma en paralelo.
- Los desarrolladores construyen aplicaciones escribiendo código fuente para esos canisters. Una aplicación puede estar compuesta por uno o varios canisters dependiendo de la arquitectura.
- Los usuarios interactúan con las aplicaciones enviando mensajes a los canisters. Esto sucede cada vez que usas una aplicación en el Internet Computer e interactúas con ella; algunos ejemplos de tales interacciones son:
    - Cuando publicas en una red social.
    - Cuando envías un token a otra dirección.
    - Cuando compras o vendes un NFT.
    - Cuando lees contenido en un sitio web alojado en el Internet Computer.
    - ¡Y muchos más!

<p align="center"> <img src="../../../capitulos/capitulo-1/assets/oc_message.png" height="600px" style="border: 1px solid black;"/> </p>
<p align="center"> OpenChat es una aplicación de mensajería descentralizada construida en el Internet Computer. </p>

## WebAssembly
Antes de pasar a Motoko, en realidad necesitamos explicar otro término: **WebAssembly**.

<p align="center"> <img src="../../../capitulos/capitulo-1/assets/canister_overview.png" width="800px" style="border: 2px solid black;"> </p>
<p align="center"> Vista general de un canister.</p>

Si profundizamos en un canister, está compuesto por:
- Un **módulo WebAssembly** que es un fragmento de código compilado a partir de lenguajes como Rust o Motoko. Este es el código que se instala en el canister y que finalmente se ejecuta.
- Una **memoria WebAssembly** - también llamada páginas de memoria. Aquí es donde se almacena el estado del canister y se almacenan archivos (fotos, videos, tokens...). El código que se ejecuta en el módulo WebAssembly modificará la memoria.

<p align="center"> <img src="../../../capitulos/capitulo-1/assets/webassembly.png" width="600px" style="border: 2px solid black;"> </p>

<p align="center"> ¿Qué es <b>WebAssembly</b>? </p>
WebAssembly es un formato binario de bajo nivel para ejecutar código en múltiples entornos (navegadores, plataformas en la nube, dispositivos inteligentes, máquinas virtuales...). Los principales beneficios de usar WebAssembly son:

- **WebAssembly** admite código escrito en varios lenguajes (C, C++, Rust, Motoko), lo que lo convierte en una solución versátil para los desarrolladores.
- El código de **WebAssembly** es portable y puede ejecutarse en casi cualquier dispositivo. ¡Lo escribes una vez y lo ejecutas en cualquier lugar!
<p align="center"> <img src="../../../capitulos/capitulo-1/assets/webassembly_stack.png" width="500px" style="border: 1px solid black;"/> </p>
<p align="center"> Escribe una vez, implementa en cualquier plataforma. </p>

- **WebAssembly** es rápido. Es un lenguaje muy cercano al lenguaje de máquina y ha sido optimizado para la velocidad y el rendimiento. ¡Puedes usarlo para crear aplicaciones complejas e intensivas (juegos, simulaciones, gráficos)!
- **WebAssembly** proporciona un entorno de ejecución seguro, colocando el código en un área especial llamada sandbox. El sandbox asegura que el programa solo pueda hacer cosas y acceder a los recursos a los que se le ha otorgado acceso y no permite que acceda a información confidencial. Esto es muy útil cuando se intenta escribir código seguro o para que los usuarios se aseguren de que no serán dañados por el código que se ejecuta en su máquina.

El único problema con **WebAssembly** es que es un lenguaje de bajo nivel y proporciona muy poca abstracción, lo que dificulta su uso para escribir aplicaciones complejas como dApps (aplicaciones descentralizadas).

## El Lenguaje Motoko
<p align="center"> <img src="../../../capitulos/capitulo-1/assets/motoko_banner.png" width="600px" style="border: 1px solid black;"/> </p>

Es por eso que la [Fundación DFINITY](https://dfinity.org/) ha introducido un nuevo lenguaje llamado **Motoko**, que es un lenguaje de programación específicamente diseñado para crear dApps en el Internet Computer. Dado que el código de Motoko se puede compilar directamente en **WebAssembly**, es un lenguaje increíble para construir en el Internet Computer. Motoko es un lenguaje de alto nivel y fácil de usar. Escribes en Motoko y luego se compila en WebAssembly.

<p align="center"> <img src="../../../capitulos/capitulo-1/assets/motoko_to_wasm.png" width="600px" style="border: 1px solid black;"/> </p>
<p align="center"> En Motoko escribes el código, en WebAssembly se ejecuta.</p>

> Vale la pena señalar que WebAssembly fue co-diseñado por [Andreas Rossberg](https://github.com/rossberg), quien se unió a la Fundación DFINITY a principios de 2017 para trabajar en su entorno de ejecución de contratos inteligentes de canister y también es el diseñador original del lenguaje Motoko. El estándar es mantenido por el [World Wide Web Consortium](https://www.w3.org/).

En el siguiente ejemplo, aquí hay una función `factorial` ilustrada en **Motoko** y **WebAssembly**.
¡No te preocupes si no entiendes nada, es normal!

<table align="center">
  <tr>
    <th> Motoko </th>
    <th>WebAssembly</th>
  </tr>
  <tr>
    <td> <pre> func factorial(n : Nat) : Nat { if (n == 0) { return 1; } else { return n * factorial(n - 1); } } </pre> </td>
    <td> <pre> (func $factorial (param $n i32) (result i32) (if (result i32) (i32.eqz (get_local $n)) (i32.const 1) (i32.mul (get_local $n) (call $factorial (i32.sub (get_local $n) (i32.const 1)))))) </pre> </td>

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
</table><p align="center"> ¿Qué piensas? ¿Te parece más fácil escribir esta función con <b>Motoko</b>? </p>

Un archivo de Motoko es un archivo con la extensión `.mo`.

<p align="center"> <img src="./assets/mo_extension.png" width="300px" style="border: 2px solid black;"> </p>

**Motoko** es un lenguaje de alto nivel como **JavaScript** o **Python**. En general, se considera más fácil de aprender que un lenguaje de nivel inferior como **Rust** o **C**. 

---
<i> Motoko tiene una mascota genial que ha sido intensamente utilizada y modificada en la comunidad, ¡para todo tipo de propósitos! 
Así que no solo podrás construir aplicaciones descentralizadas de vanguardia con Motoko, sino que también tendrás el logo más genial del juego. ¿No nos crees? Solo mira el [mercado de Motoko NFT](https://entrepot.app/marketplace/motoko) y compruébalo tú mismo. </i>

## El modelo de actor.
Si abres un archivo de Motoko, hay una alta probabilidad de que la primera palabra que leerás sea `actor`:
```
actor {

    /// CODE

};
````
Un **actor** es cómo se representa y abstrae un canister en **Motoko**. Este término proviene del [modelo de actor](https://es.wikipedia.org/wiki/Modelo_de_actor) que es una forma de escribir programas de computadora que pueden manejar muchas tareas al mismo tiempo. Lo hace tratando a los **actores** como los bloques de construcción básicos de un programa. <br/>
Un actor es un pequeño programa de computadora que puede recibir mensajes, hacer algún trabajo y luego enviar mensajes a otros actores. Los actores también pueden crear nuevos actores y controlarlos. Todos los actores se comunican entre sí enviando mensajes. Dado que toda la interacción entre actores se realiza mediante el paso de mensajes, esto permite niveles muy altos de concurrencia y paralelismo, lo que lo hace muy adecuado para sistemas distribuidos. En ese sentido, ¡el Internet Computer es una computadora distribuida donde cada programa es un canister!

Dado que los canisters se han implementado para seguir el modelo de actor, no te sorprenderá saber que los canisters:

- Tienen un estado privado (memoria) y pueden ejecutar cálculos.
- Reciben mensajes de usuarios u otros canisters.
- Pueden enviar mensajes a usuarios u otros canisters.
- Pueden crear otros canisters.


<p align="center"> <img src="./assets/actor_model.gif" width="800px" style="border: 2px solid black;"></p>
<p align="center">Un canister recibe un mensaje, lo ejecuta y posiblemente envía otros mensajes a otros canisters (o incluso crear nuevos) en respuesta. </p>

Ahora consideremos el siguiente actor:
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
- Una variable llamada `message`, que se inicializa con un valor `Hello Motoko Bootcamp`.
- Dos funciones públicas:
    - `changeMessage` que actualiza el valor de `message` a lo que se proporcione como argumento.
    - `readMessage` que muestra el valor de `message` sin modificarlo.

La palabra clave `public` indica que ambas funciones pueden ser llamadas desde el exterior por usuarios u otros canisters. Las funciones `public` de un actor representan la [API](https://es.wikipedia.org/wiki/Interfaz_de_programaci%C3%B3n_de_aplicaciones) del canister.
## Actualizar vs Consultar
¿Has notado la palabra clave `query` en el ejemplo anterior?
<br/> Cuando un usuario llama a un canister, es importante distinguir dos tipos de llamadas:

### Llamadas de actualización
Las llamadas de actualización se utilizan cuando el usuario desea modificar el estado de un canister. Para garantizar la integridad del Internet Computer, estas llamadas deben procesarse a través del consenso y por todos los nodos, lo que resulta en un retraso de alrededor de 1-2 segundos. Se utilizaría una llamada de actualización en las siguientes situaciones:
- Publicar en una red social, como [DSCVR](https://dscvr.one/).
- Enviar un mensaje en una aplicación de mensajería, como [OpenChat](https://oc.app/).
- Dar me gusta o compartir un contenido en [Distrikt](https://az5sd-cqaaa-aaaae-aaarq-cai.ic0.app/).
- Comprar un NFT en [Entrepot](https://entrepot.app/).

<p align="center"> <img src="./assets/update_call_gif.gif" width="800px" style="border: 2px solid black;"></p>

### Llamadas de consulta
Este tipo de llamada se utiliza cuando un usuario desea leer datos sin modificar el estado. Estas llamadas pueden ser respondidas por un solo nodo, lo que las hace muy rápidas (alrededor de 200ms). El inconveniente es que las llamadas de **consulta** son menos seguras ya que un nodo malintencionado podría proporcionar información falsa. Se utilizaría una llamada de consulta en las siguientes situaciones:
- Leer un artículo en [Nuance](https://nuance.xyz/).
- Verificar tu foto de perfil de usuario en 
- Cargar un video o una imagen en cualquier plataforma.

<p align="center"> <img src="./assets/query_call_gif.gif" width="800px" style="border: 2px solid black;"></p>

> Dado que una llamada de consulta omite el consenso y depende de un solo nodo, es menos segura que una llamada de actualización.


|  | Llamada de actualización | Llamada de consulta |
|-----------------|-----------------|-----------------|
Tiempo de respuesta | 2-5 segundos 🐢  | 200-400 ms ⚡️  |
Consenso| Sí | No |  
Leer | Sí | Sí |
Escribir| Sí | No |
Costo | Ciclos de costo | Gratis (por ahora)


Volviendo a nuestro actor anterior:
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

La palabra clave `query` nos indica que la función `readMessage` solo se utiliza para leer información. Por otro lado, `changeMessage` puede actualizar el estado (no es necesario agregar la palabra clave `update` ya que se asume por defecto).

> Hemos implementado el actor anterior en el Internet Computer - y puedes acceder a <a href="https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.ic0.app/?id=rhjue-eaaaa-aaaaj-qazra-cai" target="_blank">su API</a>. Prueba la interfaz y comprueba la diferencia de velocidad entre `changeMessage` y `readMessage`. Diviértete y deja un mensaje amable para el próximo estudiante.

## Combustible en el Internet Computer: ciclos.
Para pagar los costos de computación y almacenamiento, los canisters deben estar cargados con **ciclos**.
Cada canister tiene su propio saldo de **ciclos** - esto se puede pensar como la vida útil de la batería de un **canister**. 
Los **ciclos** se pueden obtener quemando **ICP**.

<p align="center"> <img src="./assets/cycles_burned.gif" width="600px" style="border: 2px solid black;"> </p>
<p align="center"> Al procesar un nuevo mensaje, se deducen ciclos del saldo del canister y se queman.</p>

A diferencia del **gas** en **Ethereum**, los **ciclos** en el **Internet Computer** no son pagados por el usuario. Esto significa que puedes interactuar con canisters y navegar por sitios web sin pagar nada. Esto se conoce como el modelo de **gas inverso** y es una gran mejora para la experiencia del usuario, ya que elimina la necesidad de crear billeteras, mantener tokens y pagar tarifas altas.

Los ciclos se miden en billones (T), lo que equivale a 1.000.000.000.000 o 10^12. Un billón de ciclos siempre cuesta 1 XDR, que es una moneda basada en las tasas de cambio del mercado que representa una canasta de principales monedas. A partir de ahora, 1 XDR equivale a $1,34. El precio de los ciclos no se ve afectado por el precio de los tokens ICP. En su lugar, la tasa de conversión de los tokens ICP a ciclos se ajusta constantemente mediante el seguimiento del precio de ICP.

Cada operación realizada en la red tiene un costo asociado:
- Creación de un canister.
- Ejecución de un mensaje de actualización.
- Ejecución de una llamada entre canisters.
- Almacenamiento de datos.
- Realización de una llamada HTTPS.
- Cálculo de una firma ECDSA de umbral.

El costo de esas operaciones también depende de la subred en la que se realizan y del **factor de replicación** de esta subred. El factor de replicación corresponde al número de nodos en una subred, que puede variar de 13 a 40.
