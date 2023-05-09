# Apéndice 7: Depuración y prueba con Motoko.
## Depuración
**Debug** es un módulo que proporciona funciones de utilidad para la depuración e impresión de información. 
[Consulte la página de documentación](https://internetcomputer.org/docs/current/motoko/main/base/Debug).

### Imprimir
```motoko
func print(text : Text)
```
`Debug.print()` will print text to the output stream (i.e your terminal).
```motoko
import Debug "mo:base/Debug";
actor {
    Debug.print("Hello!");
};
```
<p align="center"> <img src="./assets/debug_print.png" width="800px" style="border: 2px solid black;"></p>
<p align="center"> El texto se imprimirá en la misma pestaña que está ejecutando su réplica. ¡Asegúrese de verificar el lugar correcto!</p>

> Desafortunadamente, `print` solo se puede usar localmente. En la mainnet o cuando se usa Motoko Playground, no hay concepto de flujo de salida, por lo que `Debug.print` no tiene efecto.

`Debug.print()` solo acepta un valor de tipo `Text` como entrada. Si tiene algún objeto, puede utilizar el comando `debug_show` para convertirlo automáticamente a `Text`.
```motoko
let array : [Nat] = [19, 8, 2, 5];
Debug.print(debug_show(array));
```
También puedes utilizar funciones de conversión.
```motoko
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";
actor {
    let n : Nat = 5;
    Debug.print(Nat.toText(n));
}
```
### Trap
```motoko
func trap(errorMessage : Text) : None
```
`Debug.trap()` detendrá la ejecución y retornará un mensaje de error con ello.
```motoko
import Debug "mo:base/Debug";
actor {
    Debug.trap({errorMessage = "Unexpected reach"});
};
```

Esto podría ser útil ya que el mensaje de error será visible en el retorno de la llamada del canister y no en una terminal separada. Además, el comportamiento será el mismo tanto en Local como en Mainnet.

Puede usarlo con debug_show() para mostrar cualquier variable que considere relevante.

<p align="center"> <img src="./assets/debug_trap.png" width="800px" style="border: 2px solid black;"></p>
<p align="center"> En este ejemplo, la variable se imprime en la misma pestaña en la que realizó la llamada.</p>
