# Apéndice 1: Desplegar y administrar un canister.
En este apéndice, desplegaremos, interactuaremos y administraremos un canister. Para ilustrar todas estas interacciones, desplegaremos un canister llamado `Counter` y experimentaremos con él. ¡Solo necesitas seguir y copiar el código!

## Requisitos previos
Asegúrate de tener instalado `dfx`.
```motoko
$ dfx --version
dfx 0.12.0
```
> Tu versión puede ser diferente, siempre y cuando sea superior a la 0.12.0. Si no es así, ejecuta `dfx upgrade`.
## Generando el proyecto
Primero necesitamos desplegar un canister. Sigue las instrucciones:
1. Genera una nueva carpeta llamada `first_project`.
```bash
$ mkdir first_project
```
2. Entra en la carpeta recién generada.
```bash
$ cd first_project
```
3. Crea dos archivos llamados `dfx.json` y `main.mo`.
```bash
$ touch dfx.json && touch main.mo
```
4. Copia y pega el siguiente código en tu archivo `dfx.json`
```json
{
    "canisters": {
      "Counter": {
        "main": "main.mo",
        "type": "motoko"
      }
    }
  }
```
`dfx.json` es un archivo de configuración utilizado por `dfx` para recopilar información sobre tu proyecto. Cada proyecto tiene un archivo dfx.json, incluso si contiene varios canisters.

Dentro del archivo `dfx.json`, puedes especificar la lista de canisters utilizando la palabra clave "canisters" seguida de una llave de apertura `{`. Cada canister de la lista se separa por una coma `,`.

En el ejemplo proporcionado, solo hay un canister llamado `Counter`. Es de tipo `motoko` y el archivo principal se encuentra en la misma carpeta con el nombre `main.mo`. El archivo principal siempre contiene la definición `actor{}`.

> Un archivo `main.mo` = un actor = un canister.

6. Copia y pega el siguiente código en tu archivo `main.mo`.
```motoko
actor Counter {
    var i : Int = 0;

    public func add(j : Int) : async Int {
        i := i + j;
        i;
    };

    public func div(j : Int) : async Int {
        i := i / j;
        i;
    };

    public func reset() : async () {
        i := 0;
    };

    public query func show() : async Int {
        i;
    };
};
```

7. Inicia tu réplica local
```bash
$ dfx start
Running dfx start for version 0.12.0
Using the default definition for the 'local' shared network because /Users/seb/.config/dfx/networks.json does not exist.
Dashboard: http://localhost:57765/_/dashboard
```

> Puedes hacer clic y acceder al panel de control. Te dará información sobre tu réplica local (versión de réplica, canisters desplegados, número de rondas de consenso desde el inicio...).

8. Crea un canister vacío para `Counter`.
```bash
$ dfx canister create Counter
Creating a wallet canister on the local network.
The wallet canister on the "local" network for user "seb" is "rwlgt-iiaaa-aaaaa-aaaaa-cai"
Creating canister Counter...
Counter canister created with canister id: rrkah-fqaaa-aaaaa-aaaaq-cai
```
`dfx` creará automáticamente una billetera para tu `identidad`. Una billetera es necesaria para contener ciclos, que son necesarios para crear canisters. Solo los canisters pueden contener ciclos y no tu identidad, por eso necesitas esta billetera que actúa como un proxy cuando creas y despliegas canisters.

9. Compila tu código a WASM. 
```bash
$ dfx build Counter
Building canisters...
Shrink WASM module size.
``` 
Después de este paso, tu archivo Motoko se compila en un módulo WebAssembly, cuyo tamaño está optimizado. Puedes encontrar el módulo en `.dfx/canister/Counter/Counter.wasm`.

> Si quieres saber qué hay dentro del módulo, puedes [convertir tu WASM al formato WAT](https://webassembly.github.io/wabt/demo/wasm2wat/), que es una representación textual para el binario WASM.

10. Instala el WASM dentro del canister.
```bash
$ dfx canister install Counter
Creating UI canister on the local network.
The UI canister on the "local" network is "ryjl3-tyaaa-aaaaa-aaaba-cai"
Installing code for canister Counter, with canister ID rrkah-fqaaa-aaaaa-aaaaq-cai
```
¡Felicidades! Tu canister ahora está desplegado.

La interfaz **Candid** permite la interacción entre servicios y entre servicios y frontends. **Candid** también es muy útil para llamar a los canisters desde diferentes lugares:

- Usando la terminal con `dfx`.
- Usando la **Interfaz de Usuario Candid (Candid UI)**.
- Usando un frontend (página web) con el **JavaScript Agent**.

## Usando la terminal
La interfaz Candid te permite llamar a servicios o funciones de backend desde la línea de comandos. Esto es útil para tareas administrativas que no requieren un frontend o para probar el backend. En el ejemplo de la aplicación descentralizada `Counter`, puedes llamar al método `add` ejecutando el siguiente comando:

```bash
$ dfx canister call Counter add '(3)'
(3 : int) 
```
Como probablemente puedas adivinar por el ejemplo anterior, el formato para llamar a canisters usando `dfx` es el siguiente:
```bash
dfx canister call NAME_OF_CANISTER NAME_OF_FUNCTION '(ARGUMENTS)'
```
Ten en cuenta que debes poner tus argumentos entre `'()'` y el formato para los argumentos es la sintaxis **Candid**, el tipo devuelto es `int` y no `Int` como en Motoko. Esta distinción será más importante cuando trabajemos con argumentos complejos (objetos, tuplas, matrices, etc.).

Si deseas llamar a un canister en la red principal, debes agregar la bandera `--network ic`:
```bash
dfx canister --network ic call NAME_OF_CANISTER NAME_OF_FUNCTION '(ARGUMENTS)'
```

Como hemos visto antes, podemos **atrapar** el canister si intentamos dividir por 0.
```bash
$ dfx canister call Counter div '(0)'
Error: Failed update call.
Caused by: Failed update call.
  The Replica returned an error: code 5, message: "Canister rrkah-fqaaa-aaaaa-aaaaq-cai trapped: integer division by 0"
```
Una cosa importante a tener en cuenta es que el canister persiste su estado de forma predeterminada. Si enviamos otro comando:

```bash
$ dfx canister call Counter add '(5)
(8 : int)
```
Podemos ver que el valor de `counter` es 8, lo que corresponde a los dos comandos que hemos ejecutado hasta ahora.
Esta propiedad se llama **persistencia ortogonal**. La persistencia ortogonal crea la ilusión de que un programa se ejecuta para siempre sin fallar o perder su estado. Si no envías comandos a tu canister, mantendrá el valor de `counter` en 8 para siempre.

> El término "**persistencia ortogonal**" puede sonar complejo, pero en la práctica, simplemente significa que puedes concentrarte en escribir código sin la necesidad de construir una base de datos para almacenar el estado. El estado se persiste automáticamente de forma predeterminada, eliminando la necesidad de infraestructura de almacenamiento adicional.

11. Copia y pega el siguiente código en tu archivo `main.mo`.
```motoko
actor Counter {
    var i : Int = 0;

    public func add(j : Int) : async Int {
        i := i + j;
        i;
    };

    public func sub(j : Int) : async Int {
        i := i - j;
        i;
    };

    public func mult(j : Int) : async Int {
        i := i * j;
        i;
    };

    public func div(j : Int) : async Int {
        i := i / j;
        i;
    };

    public func reset() : async () {
        i := 0;
    };

    public query func show() : async Int {
        i;
    };
};
```

12. Recompilar el código
```motoko
$ dfx build Counter
```

13. Hacer upgrade del canister con el nuevo módulo
```motoko
$ dfx canister install Counter --mode upgrade
```

Ahora que hemos hecho upgrade de nuestro canister, si miramos el valor del `counter`
```motoko
$ dfx canister call aCounter show 
(0 : int)
```

¡Sí, la persistencia ortogonal tiene limitaciones!
Cada vez que actualizamos nuestro canister, el estado se borra y volvemos a comenzar desde cero. Veremos en un capítulo futuro que podemos resolver este problema, mediante el uso de la **memoria estable** que es una memoria que persiste entre actualizaciones.

Mientras tanto, para obtener más información sobre cómo llamar a canisters desde la línea de comandos, puedes leer la [documentación](https://internetcomputer.org/docs/current/references/cli-reference/dfx-canister) o simplemente ejecutar: 
```bash
$ dfx canister --help
```
## Usando la Interfaz de Usuario Candid (Candid UI)
Si bien la línea de comandos puede ser muy práctica, también hay una manera más fácil de llamar a los servicios de backend, y es mediante el uso de la Interfaz de Usuario Candid. Cuando se despliega un proyecto, además de las interfaces Candid, también se despliega un canister de activos que ejecuta la Candid UI. El proceso de compilación mostrará la URL en la consola, pero la URL también se puede encontrar en `/.dfx/local/canister_ids.json`:
```json
{
  "Counter": {
    "local": "rrkah-fqaaa-aaaaa-aaaaq-cai"
  },
  "__Candid_UI": {
    "local": "ryjl3-tyaaa-aaaaa-aaaba-cai"
  }
}
```
En este caso, la URL de la Candid UI es http://127.0.0.1:4943/?canisterId=ryjl3-tyaaa-aaaaa-aaaba-cai&id=rrkah-fqaaa-aaaaa-aaaaq-cai.

> Es posible que la URL de la Candid UI sea diferente en tu máquina. Asegúrate de ajustar la URL en consecuencia en función de los IDs del canister de tu propio archivo.

Simplemente haz clic en el botón **Query** y ve la respuesta en el **Registro de Salida**.

**¿Local o en vivo?**
Una confusión importante a evitar es la diferencia entre las interfaces de usuario Candid local y en vivo:
- La interfaz de usuario Candid en vivo es única para todo el Internet Computer: puedes acceder a la interfaz de cualquier aplicación descentralizada (siempre y cuando el archivo candid se haya enviado). Al utilizar la interfaz de usuario Candid en vivo, puedes modificar directamente el estado de un canister.
- La interfaz de usuario Candid local que probamos anteriormente solo se despliega en tu réplica local. Solo te puede dar acceso al canister que has desplegado localmente.

> La Candid UI (local o en vivo) se ejecuta en un canister.
