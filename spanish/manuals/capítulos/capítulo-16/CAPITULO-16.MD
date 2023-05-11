# Capítulo 16: Administrando múltiples canisters con clases actor.
## Clases Actor.
## El canister de administración 👨‍💼
El canister de administración se usa en el IC para llevar a cabo operaciones como:
- Crear canisters desde otro canister.
- Instalar código dentro de otros canisters (¡sobre los que tengas control!).
- Conseguirinformación de los canister como pueden ser:
    - El estado de un canister (corriendo, parándose, parado).
    - Un hash SHA256 del módulo instalado en el canister.
    - Los controladores del canister.
    - El tamaño de memoria que consume el canister.
    - El balance de ciclos del canister.
- Crear [ECDSA](https://internetcomputer.org/docs/current/references/ic-interface-spec#ic-sign_with_ecdsa) firmas derivadas del canister.
- Crear [http_request](https://internetcomputer.org/docs/current/references/ic-interface-spec#ic-sign_with_ecdsa) 
- Interactuar con [la API de Bitcoin](https://internetcomputer.org/docs/current/references/ic-interface-spec#ic-bitcoin-api)
- ¡Y mucho más! 

> El canister de administración del IC no existe de por sí como un “canister”. No contiene un módulo wasm o memoria - solo es una interfaz para hacer más fácil la comunicación con una API de administración en el IC. La dirección del canister de administración del IC es aaaaa-aa.  

Aquí se muestra un ejemplo de como usar el canister de administración dentro de otro actor.
```motoko
actor {
    let managementCanister = actor {
        create_canister : {} -> async {canister_id : Principal};
        stop_canister : { canister_id : Principal } -> async ();
        delete_canister : { canister_id : Principal } -> async ();
    };

// Create - Stop - Burn 🥲
    public func createStopBurn() : async () {
        let cid = await mangagementCanister.create_canister;
        await IC.stop(cid);
        await IC.delete_canister(cid) 
    };
};
```
Una vez has creado otros canister desde tu canister de administración, puedes instalar un módulo wasm en su interior. Esto requiere que el módulo esté previamente cargado dentro de tu canister principal. Este patrón es usado por muchas aplicaciones en el IC para crear dApps multicanister (OpenChat...)! 
## Creando una fábrica de canisters.
