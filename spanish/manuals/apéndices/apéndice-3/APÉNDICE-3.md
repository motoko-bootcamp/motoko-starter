# Apéndice 3: Un nuevo capítulo en la identidad digital: Internet Identity.
## El fin de los usuarios y contraseñas.
La identidad es fundamental en nuestra vida digital. En el mundo en constante evolución de Internet, se ha vuelto más importante que nunca contar con métodos seguros y confiables para acceder a nuestras cuentas y espacios personales. <br/>
Durante años, la forma tradicional de iniciar sesión en sitios web ha sido con contraseñas y nombres de usuario.

<p align="center"> <img src="assets/password_username.jpeg" width="400px" style="border: 2px solid black;"></p>
<p align="center"> Seguramente estés familiarizado con este tipo de interfaz.</p>

Para crear contraseñas efectivas y seguras se debe:

- Seleccionar una contraseña larga y generada aleatoriamente.
- Evitar usar la misma contraseña en múltiples sitios web.

Sin embargo, incluso al respetar reglas básicas de seguridad, este método de inicio de sesión tiene problemas fundamentales:

1. El servidor que concede la autenticación debe almacenar la combinación de nombre de usuario y contraseña para verificar el inicio de sesión y conceder acceso. Aunque la contraseña a menudo se almacena como un hash, las violaciones de datos y las filtraciones siguen siendo comunes.
2. Recordar y hacer un seguimiento de las contraseñas es un desafío, ya que la mayoría de las personas tienen varias cuentas en diversas plataformas, lo que dificulta recordarlas todas. Es por eso que el uso de gestores de contraseñas y el inicio de sesión a través de grandes empresas tecnológicas (Apple, Facebook, Google, Microsoft) se ha vuelto más común.
3. El uso de contraseñas en una infraestructura descentralizada como Internet Computer es una mala idea. Estamos evolucionando en un mundo donde asumimos que algunos nodos pueden ser malintencionados. Si necesitamos enviar la contraseña a todos los nodos, entonces podría filtrarse en ese momento.

## Inicio de sesión con BigTech
Como resultado, el uso de gestores de contraseñas y el inicio de sesión a través de grandes empresas tecnológicas como Apple, Facebook, Google o Microsoft se ha vuelto más común. Sin embargo, este método de inicio de sesión también tiene sus inconvenientes. Requiere que las personas confíen en estas grandes empresas tecnológicas con su información personal y acceso a otros sitios web.

<p align="center"> <img src="./assets/login_bigtech.png" width="300px" style="border: 2px solid black;"> </p>

Con el aumento de la información que ponemos en línea, ¿realmente queremos confiar en un puñado de empresas privadas?

<p align="center"> <img src="./assets/facebook_meme.jpeg" width="300px" style="border: 2px solid black;"> </p>

## Firmas digitales
Las firmas digitales son una alternativa más segura a la autenticación tradicional de nombre de usuario y contraseña. Las firmas digitales utilizan una técnica criptográfica para verificar la autenticidad de un mensaje o documento, asegurándose de que no haya sido manipulado y que provenga de un remitente verificado. Se utilizan ampliamente en transacciones electrónicas, como banca en línea y comercio electrónico, ya que proporcionan un nivel más alto de seguridad y protección contra el fraude.

Como Internet Computer se construye sobre mucha criptografía, no te sorprenderá saber que se utilizan como mecanismo de autenticación para mensajes.
Un esquema de firma digital se basa en 3 algoritmos:

1. **Generación de claves**: este algoritmo se utiliza para generar una clave pública y una clave privada. La clave pública se utiliza para verificar la firma digital, mientras que la clave privada se utiliza para crear la firma digital.

2. **Firma**: este algoritmo se utiliza para crear la firma digital con la clave privada. Aplica una fórmula matemática a los datos que deben firmarse y a la clave privada para generar una firma digital única.

3. **Verificación**: este algoritmo se utiliza para verificar la firma digital con la clave pública. Aplica una fórmula matemática a los datos firmados, la firma digital y la clave pública. Si la salida de la fórmula coincide con los datos originales, la firma digital se considera válida y los datos se consideran auténticos.

<p align="center"> <img src="./assets/digital_signatures.png" width="800px" style="border: 2px solid black;"></p>

Por supuesto, ¡las firmas digitales ya se han utilizado intensivamente en el mundo de la criptografía! Todo el mundo debería conocer el famoso dicho: [Not your keys not your crypto](https://www.ledger.com/academy/not-your-keys-not-your-coins-why-it-matters). 
Los usuarios que poseen y administran sus claves son excelentes para la seguridad y la descentralización, sin embargo, no es tan fácil. <br/> El principal problema es mantenerlas seguras y accesibles.

<p align="center"> <img src="./assets/lost_bitcoins.jpeg" width="800px" style="border: 2px solid black;"></p>
<p align="center"> Si pierdes tus claves, ¡no hay copia de seguridad! </p>

Si queremos administrar nuestras identidades digitales completas utilizando claves criptográficas mientras integramos a millones de personas en la Web3, parece que hay un proyecto desafiante que resolver aquí. ¿Cómo podemos mantener los beneficios de las firmas digitales mientras lo hacemos más fácil de usar para todos?

## Autenticación web
[WebAuthentication](https://webauthn.guide/), también conocido como WebAuth, es un estándar web que intenta resolver los problemas planteados anteriormente y estandarizar los inicios de sesión mediante criptografía de clave pública.

- Cuando un usuario se registra por primera vez en un servicio habilitado para WebAuthn:
    1. Se genera un par de claves para ti.
    2. La clave privada se almacena de forma segura en tu dispositivo.
    3. La clave pública se envía al servicio y se asocia con la cuenta del usuario.

<p align="center"> <img src="./assets/webAuthn_registration.png" width="400px" style="border: 2px solid black;"></p>

- Cuando el mismo usuario quiere iniciar sesión nuevamente:
    1. Se genera un desafío por el servicio.
    2. El dispositivo intenta verificar tu identidad a través de factores de autenticación (FaceID, TouchID, YubiKey, Windows Hello...)
    3. Si la verificación es correcta, el dispositivo firmará el desafío y enviará la firma de vuelta al servicio.
    4. Si la firma es correcta, el servicio otorgará acceso.

<p align="center"> <img src="./assets/webAuthn_signature.png" width="400px" style="border: 2px solid black;"></p>

El dispositivo generalmente integra un chip seguro que almacena la clave privada. Esos chips están diseñados para **nunca filtrar la clave privada**, solo pueden crear una firma cuando se solicita.

WebAuthentication es seguro y conveniente.
## Mensajes en el Internet Computer
Como mencionamos en el día 1, todas las solicitudes enviadas al Internet Computer pasan a través de mensajes. Todos esos mensajes están firmados.

<p align="center"> <img src="./assets/message_authenticated.png" width="800px" style="border: 2px solid black;"></p>

Un mensaje contiene la siguiente información:
- ID del canister objetivo.
- Función llamada en este canister.
- Argumentos proporcionados para estas funciones.
- Un nonce que se puede usar para distinguir otros dos mensajes similares.

Pero lo más importante es que el mensaje contiene una firma. Podemos usar esta firma para verificar la identidad del llamante.

> Hay una identidad que se llama identidad **Anónima**, y permite la comunicación con Internet Computer de manera completamente anónima. La representación textual del principal asociado con esta identidad es **2vxsx-fae**. Puedes probar el método `whoami` tú mismo desde el [Candid UI](https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.ic0.app/?id=sm7ch-cyaaa-aaaaj-qaz3q-cai) - cuando interactúas desde el Candid UI, no estás autenticado, por lo que deberías ver el principal anónimo.
## Delegaciones
Con WebAuthentication, cada vez que el usuario crea una firma, su identidad se verificará a través de los factores de autenticación que se mencionaron antes, generalmente solicitando la confirmación del usuario. 
Imaginemos que nuestro usuario quiere hacer las siguientes 3 acciones:

1. Iniciar sesión en DSCVR.
2. Actualizar su perfil de usuario.
3. Publicar un mensaje.

<p align="center"> <img src="./assets/withoutII_hell.png" width="800px" style="border: 2px solid black;"></p>
<p align="center"> ¡Cada interacción con la red requeriría una validación del usuario! 🤦‍♂️ </p>

Como todos los mensajes están firmados en Internet Computer, significaría que tendríamos que confirmar nuestra identidad cada vez que interactuamos con cualquier canister. Eso sería rápidamente molesto para los usuarios. <br/>

¿La solución? ¡**Delegación**! 
Una delegación es un par de claves a corto plazo que creamos cuando un usuario inicia sesión. Este par de claves se almacena localmente y se puede usar para realizar cualquier número de acciones durante un período de tiempo específico. 
El documento que otorga la delegación está firmado por el par maestro de claves.
## Firma del canister
Cada subred puede crear una firma que certifica una pieza de datos que proviene de Internet Computer. Un canister puede solicitar a la subred en la que está alojado que cree una firma en datos específicos; este mecanismo se llama [variables certificadas](https://internetcomputer.org/how-it-works/response-certification/).

Sobre la base de este mecanismo, los canisters pueden crear firmas.
> Si desea obtener más información sobre variables certificadas, consulte este video y este repositorio.

Haciendo uso de WebAuthn, delegaciones y firmas de canister, DFINITY ha diseñado una solución de identidad llamada **Internet Identity**.<br/>
Internet Identity permite a los usuarios crear sesiones con servicios y aplicaciones web3, y firmar transacciones blockchain tradicionales.
## Identidad en Internet

La Identidad en Internet es un canister que administra tu par de claves y te permite crear delegaciones a corto plazo para iniciar sesión en otros canisters. No almacena las claves privadas, ya que estas están almacenadas de forma segura en tus dispositivos.

Cuando intentas iniciar sesión en un servicio a través de la Identidad en Internet, ocurren los siguientes pasos:

1. Creación de un anclaje: esta es tu identidad a la que podrás agregar dispositivos.

2. Registro de dispositivo(s) en tu anclaje.
   - Puedes registrar múltiples dispositivos en tu identidad. Todos los dispositivos registrados tienen acceso a tu identidad.
   - Necesitas tener al menos un dispositivo registrado en todo momento, de lo contrario no podrás acceder a tu identidad y tendrás que usar uno de los mecanismos de respaldo que has (esperemos) puesto en su lugar.
   - Puedes eliminar dispositivos registrados cuando lo necesites.

3. Conexión a una dApp
   1. Estás visitando tu aplicación favorita y quieres iniciar sesión usando la Identidad en Internet.
   2. Tu identidad es verificada (autenticación biométrica / llaves de seguridad USB).
   3. Se crea un par de claves a corto plazo en tu dispositivo local.
   4. Se envía un mensaje **firmado** desde tu par de claves maestro al canister de Identidad en Internet, solicitando que se cree una delegación para tu par de claves local.
   5. La delegación se envía de vuelta a tu dispositivo y se almacena.
   6. Ahora puedes usar la aplicación con tu par de claves local y enviar la delegación. No tienes que solicitar una firma usando WebAuthn para cada mensaje que envíes.
