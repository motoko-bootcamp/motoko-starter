# Calculadora ➕✖️➖➗

En tu primer día de clase, entras en las aulas con ansias de embarcarte en la aventura de tu vida. Pero sin saberlo, has olvidado traer una herramienta esencial para la clase: una **calculadora**. 😳

Tu profesor, un experto de renombre en la comunidad, comienza la lección del día presentando una serie de problemas matemáticos complejos que requieren el uso de una calculadora. Los estudiantes a tu alrededor se agrupan, sacando sus calculadoras para enfrentar el desafío. 💪

Mientras buscas en vano en tu bolsa tu calculadora, te das cuenta de que la has dejado inadvertidamente. En lugar de entrar en pánico o admitir la derrota, tu naturaleza ingeniosa entra en acción. Decides confiar en tu inteligencia y aptitud en Motoko para crear tu propia calculadora. 🧑‍💻

## Requisitos 
Tu tarea es crear el código para una **calculadora**, que se implementa como un canister.

El canister debe tener una interfaz pública que permita a los usuarios realizar cálculos. El canister tiene una variable de memoria llamada `counter`, que representa el resultado del cálculo más reciente.

## Pasos
1. Define una variable mutable llamada `counter` de tipo `Float` que se utilizará para almacenar el resultado del cálculo más reciente.
2. Implementa `add`, que acepta un valor `x` de tipo `Float` y realiza la suma.
3. Implementa `sub`, que acepta un valor `x` de tipo `Float` y realiza la resta.
4. Implementa `mul`, que acepta un valor `x` de tipo `Float` y realiza la multiplicación.
5. Implementa `div`, que acepta un valor `x` de tipo `Float` y realiza la división. Asegúrate de proteger contra la división por 0.
6. Implementa `reset`, que restablece el valor de `counter` estableciendo su valor en cero.
7. Implementa una función de consulta `see` que devuelve el valor de `counter`.
8. Implementa `power`, que acepta un valor `x` de tipo `Float` y devuelve el valor de `counter` elevado a la potencia de `x`.
9. Implementa `sqrt`, que devuelve la raíz cuadrada de `counter`.
10. Implementa `floor`, que devuelve el entero más grande menor o igual que `counter`.
11. Despliega la `Calculadora` en el Internet Computer.

## Interfaz
> Al final del proyecto, tu canister debe implementar la siguiente interfaz.

```motoko
actor {
    add : shared(x : Float) -> async Float;
    sub : shared(x : Float) -> async Float;
    mul : shared(x : Float) -> async Float;
    div : shared(x : Float) -> async Float;
    reset: shared () -> async ();
    see: shared query () -> async Float;
    power: shared(x : Float) -> async Float;
    sqrt: shared() -> async Float;
    floor: shared() -> async Int;
};
```