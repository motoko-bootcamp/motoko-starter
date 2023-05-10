# Capítulo 10: Identidad en Internet Computer.
## Tus claves = Tu identidad

Ya sea que interactúes con Internet Computer utilizando [Internet Identity](https://internetcomputer.org/docs/current/tokenomics/identity-auth/what-is-ic-identity), `dfx`, o incluso [Plug wallet](https://plugwallet.ooo/), tu identidad está representada por un par de claves que consta de:

<p align="center"> <img src="../../../..manuals/chapters/chapter-10/assets/identity_recap.png" width="600px" style="border: 2px solid black;"> </p>

- Una **clave privada**, que te otorga acceso a todos los ICP que posees, te permite administrar contenedores y te permite acceder a tu identidad en varias aplicaciones.
- Una **clave pública**, a partir de la cual se deriva tu **principal**.

## Administración de identidades con dfx
Podemos usar `dfx` para crear, eliminar y administrar nuestras identidades, esas identidades se utilizan para desplegar, administrar e interactuar con los contenedores que desplegamos.

### Creando una identidad
Para generar una nueva identidad, puedes ejecutar el siguiente comando:
```bash
$ dfx new identity <NAME>
```
> Puedes incluir la bandera --disable-encryption al ejecutar el comando para evitar la encriptación del archivo que contiene tu clave privada. De lo contrario, el archivo se encriptará y se te pedirá una contraseña cada vez que se use un comando que requiera una firma.

La clave privada generada para esta identidad se guardará automáticamente en el directorio `.config/dfx/identity/<NOMBRE>`. Esta clave privada se almacena como un archivo PEM, un formato específico utilizado para almacenar claves. El archivo puede estar encriptado o sin encriptar, según la bandera que elijas.

Por ejemplo, el archivo PEM correspondiente a la identidad `default`, que es una identidad creada automáticamente cuando instalas `dfx`, tiene una clave privada almacenada que se parece a la siguiente:
```
-----BEGIN EC PRIVATE KEY-----
MHQCAQEEIPkmcU+rvYCcvylnVClTrleDyWqmelhQmigzMvq8zFC3oAcGBSuBBAAK
oUQDQgAE5knNEHs+kzvCteeu4e650NzqGvLhlzoWXXKupjCreV1dhuH5oIHIVyoM
ldnRBAE39QwyGwkQoxWhmo+Sl9F4zA==
-----END EC PRIVATE KEY-----
```  
### Cambiando entre identidades
Para verificar la identidad actualmente utilizada, ejecuta:
```bash
$ dfx identity whoamis 
```
Para ver otras identidades disponibles, correr:
```bash
$ dfx identity list
```
Finalmente, cambia la identidad activa utilizando:
```bash
$ dfx identity use <NAME> 
```
## Desde la clave pública hasta el principal
Con `dfx`, puedes acceder a un identificador único para cada identidad llamado **principal**:
```motoko
$ dfx identity get-principal
2ujkt-fujau-bunuv-gt4b6-2s27j-cv5qi-kddkp-jl7m4-wdj3e-bqdrt-qqe
```
Un principal identifica las entidades que interactúan con Internet Computer y se deriva directamente de la clave pública. Estas entidades pueden ser usuarios o contenedores. Los diferentes tipos de principios incluyen:
Un principal es un identificador público utilizado para identificar las entidades que pueden interactuar con Internet Computer. El principal se deriva directamente de la clave pública. Estas entidades son usuarios o contenedores. Distinguimos diferentes tipos de principios:
- **IDs de autoautenticación** (Usuario): Se derivan directamente de la clave pública de un usuario, como el principal de tu identidad dfx. Estos principios tienen una longitud de 29 bytes.
- **IDs opacos** (Contenedor): El principal de un contenedor es su ID de contenedor, determinado automáticamente en función de su subred y del número de contenedores desplegados.
- **ID anónimo** (Anónimo): El llamante predeterminado cuando un usuario no autenticado llama a funciones, como obtener información de un contenedor antes de iniciar sesión. El contenedor reconoce al llamante como el ID anónimo ya que el principal del usuario es desconocido hasta que inicia sesión.

> Existen dos [tipos de principios adicionales](https://internetcomputer.org/docs/current/references/ic-interface-spec#id-classes) pero raramente se encuentran. Se utilizan internamente por el protocolo o se reservan para uso futuro.

## Principal en Motoko
En Motoko, los principios son un tipo primitivo llamado `Principal`. <br/>
Dentro de un actor, accede al principal del llamante de una función usando la sintaxis `shared (message)` colocada entre las palabras clave `public` y `func`. Esto permite la inspección del mensaje, donde `message.caller` representa el principal de la entidad que llama (usuario o contenedor).

```motoko
actor {
    public shared (message) func whoIsCalling() : async Principal {
        let p = message.caller;
        return p;
    };
};
```

> `Message` es un objeto especial que está disponible para todas las `funciones compartidas públicas`. A partir de hoy, solo se utiliza para acceder a la propiedad `caller`, pero podría tener otros casos de uso en el futuro.

Utiliza la deconstrucción de objetos para acceder directamente al llamante para una sintaxis más corta:
```motoko
actor {
    public shared ({ caller }) func returnCallerPrincipal() : async Principal {
        return caller;
    };
};
```
Utiliza `Principal.toText()` y `Principal.fromText()` del [módulo Principal](https://7po3j-syaaa-aaaal-qbqea-cai.ic0.app/base-library/primitive-types/principal.html?highlight=Principal#principal) para convertir entre `Principal` y su representación textual.

```motoko
let p : Principal = message.caller;
let textualRepresentation : Text = Principal.toText(p); // => "un4fu-tqaaa-aaaab-qadjq-cai"
let standardRepresentation : Principal = Principal.fromText(textualRepresentation); 
```

## La identidad anónima
Como se mencionó anteriormente, la identidad anónima está asociada con un principal específico y se utiliza para llamadas no autenticadas a Internet Computer. Para determinar si un llamante está autenticado, utiliza la función `Principal.isAnonymous()`, que devuelve un `Bool` que indica el anonimato del usuario.
```motoko
let p : Principal = message.caller;
let isAnonymous : Bool = Principal.isAnonymous(p);
if(isAnonymous){
    return ("Sorry only authenticated users can access this app!");
};
```

> La representación textual del principal anónimo es `2vxsx-fae`. Asegúrate de recordarlo ya que a menudo te encontrarás con él.
