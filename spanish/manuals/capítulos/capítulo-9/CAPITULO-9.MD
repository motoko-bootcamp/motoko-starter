# Capítulo 9: Manejo de errores.
En Motoko, cuando algo no funciona como se esperaba, hay varias formas de mostrar que se ha producido un error. Algunos métodos incluyen:
- Usando el tipo `Result`.
- Lanzar un error con la palabra clave `throw` o la biblioteca `Error`.
- Atrapar el programa.

En esta sección veremos diferentes opciones y aprenderemos cuándo usar cada una para manejar errores de manera efectiva.
## 🚥 El tipo `Result`.
El tipo `Result` es extremadamente útil en Motoko para manejar errores, se define como un tipo variante.
```motoko
type Result<Ok, Err> = {#ok : Ok; #err : Err}
```
Con `Ok` y `Err`, puedes especificar los tipos a devolver según el éxito o el fracaso. Por ejemplo, al crear un tipo de resultado para la graduación de un estudiante:
```motoko
type Score = Nat; // The score of a student. 
type ExamFailed = {
    #ScoreTooLow : Nat;     //  The score of the student. 
    #Absent;    //  One reason for not passing an exam.
    #Cheated;   //  Another reason for not passing an exam.
};
```
- Si un estudiante se gradúa, se devuelve su puntaje. El puntaje es de tipo `Score`, que es un alias para `Nat`.
- Si un estudiante falla, se devuelve una variante que indica la razón del fracaso. La variante es de tipo `ExamFailed`.

Ahora podemos utilizar esos nuevos tipos para reemplazar `Ok` y `Err`.
```motoko
type ExamResult = Result.Result<Score, ExamFailed>;
```
En casos como nuestro ejemplo, el uso de un tipo variante para `Err` es bastante común. Permite un mejor manejo de diferentes tipos de errores y facilita la coincidencia de patrones. ¡Esto significa que cualquier persona que revise el error puede comprender mejor su causa específica!```motoko
func sendMessageToStudent(result : ExamResult) : Text {
    switch(result) {
        case(#ok(score)){
            return ("Congrats 🎉 - you have graduated with a score of : " # Nat.toText(score));
        };
        case(#err(failure)){
            switch(failure){
                (#ScoreTooLow(score)){
                    return ("Unfortunately your score is below requirements. Next time you'll graduate! You had a score of : " # Nat.toText(score));
                };
                case(#Absent){
                    return ("You were absent at the exam. Please schedule another time.");
                };
                case(#Cheated){
                    return("Cheating is a short-term gain that leads to long-term pain");
                };
            };
        };
    };
};
```
### ¿Cuándo debo usar el tipo Result?
El uso de `Result` para informar errores en tu API ofrece un beneficio significativo: permite a otros desarrolladores y programas manejar errores de manera predecible. Es por eso que `Result` se usa a menudo para errores esperados en tu programa cuando deseas devolver un valor. `Result` no afectará el comportamiento normal del programa.
## 🪤 Trampas y afirmaciones
Una **trampa** es un tipo de error que ocurre durante la ejecución de un mensaje y no se puede resolver. Las causas más comunes de las trampas son:
- División por cero.
```motoko
let a : Nat = 5;
let b : Nat = 0;
let c = a / b;
```
- Index is out of bounds. 
```motoko
let names : [Text] = [];
```
- Assertion failure
```motoko
assert(false);
```
En algunas situaciones, puede ser útil atrapar intencionalmente, con un mensaje definido.

La mejor manera de hacerlo es usar el método `Debug.trap()` de la [biblioteca Debug](https://internetcomputer.org/docs/current/motoko/main/base/Debug), que te permite pasar un mensaje de error junto con la `trap`.```motoko
func trap(errorMessage : Text) : None
```
### Asserts
El uso de la palabra clave `assert` te permite verificar si se cumple una determinada condición. Si la condición dentro de `assert()` es `false`, el programa dejará de ejecutarse. Si es `true`, el programa continuará como de costumbre.
```motoko
assert(2 == 1);  // always traps
```
```motoko
assert n % 2 == 0; // traps only when n not even
```
```motoko
assert(true) // never traps
```
### ¿Cuándo debo usar una trampa?
Las trampas detienen inmediatamente la tarea actual (es decir, el mensaje) que está siendo ejecutado por un contenedor, pero no impiden que el contenedor maneje solicitudes futuras. Las trampas deben usarse para situaciones inesperadas. Por ejemplo, la función `unwrap` a continuación:
```motoko
/// Unwraps the value of the option.
public func unwrap<T>(option : ?T) : T {
    switch option {
        case (?value)
            value;
        case null
            Debug.trap("Value is null - impossible to unwrap")
    }
};
```
> Las trampas tienen una característica muy útil: si una función trapa, el estado del contenedor se revertirá. Esto se discutirá más en el contexto de [llamadas entre contenedores](../chapter-11/CHAPTER-11.MD#commit-point-and-rollbacks).
## 🔀 Manejo de errores asíncronos con el tipo `Error` y try/catch.
> En esta sección, el término **error** se refiere específicamente a cualquier valor de tipo `Error`.

En Motoko, el manejo de errores puede ser un poco confuso, especialmente si estás acostumbrado al manejo de errores en otros lenguajes de programación. Aquí hay algunos puntos clave a tener en cuenta:

- Los errores se pueden lanzar usando la palabra clave `throw`.
- Los errores se pueden manejar mediante el patrón `try/catch`.
- Un error es del tipo `Error`, que también se puede manipular utilizando la biblioteca Error.

Sin embargo, el manejo de errores en Motoko solo se puede hacer en un contexto asíncrono. Esto significa que solo puedes lanzar o atrapar errores en el cuerpo de una función compartida.
En este ejemplo, definimos un actor que contiene dos funciones: `throwErrorSync` y `throwErrorAsync`.
```motoko
import Error "mo:base/Error";
actor {
  // Misplaced throw 
  func throwErrorSync() : () {
    throw Error.reject("This will not work")
  };

  // Can throw an error in a shared/public function - this error will be consumed by another canister/user calling this function.
  public func throwErrorAsync() : async () {
    throw Error.reject("This will not work")
  };
}
```
> Puedes ver este ejemplo [en el Playground de Motoko](https://m7sm4-2iaaa-aaaab-qabra-cai.ic0.app/?tag=907568632) - nota el mensaje `misplaced throw` en el cuerpo de `throwErrorSync`.

El patrón `try/catch` en Motoko es particularmente útil cuando intentas llamar a otro contenedor y deseas manejar cualquier error posible que pueda ocurrir durante la llamada. Esto puede incluir situaciones como:

- El contenedor de destino no está activo o no se puede alcanzar.
- La función que se llama no existe en el contenedor de destino.
- La función que se llama trapa, ya sea debido a un error de programación o porque se ha quedado sin recursos.
- La función que se llama lanza un error que necesita ser manejado.

Suponiendo que este es nuestro contenedor A - desplegado con el ID de contenedor:
```motoko
actor {
    public func foo() : async Text {
        return "foo"
    };   
}
```
Asumiendo que este es nuestro canister B
```motoko
actor {

    let canisterA = actor("xxx") : actor {
        foo : shared () -> async Text;
    };

    public func fooFromCanisterA() : async Text {
        try {
            let foo = await canisterA.foo()
            return foo;
        } catch (e) {
            return "An error occured when calling canister A".
        };
    };   
}
```
En el ejemplo proporcionado, tenemos dos contenedores: **Contenedor A** y **Contenedor B**.
- **Contenedor A** tiene una sola función pública `foo` que devuelve el texto "foo".
- **Contenedor B** tiene una función pública `fooFromCanisterA` que intenta llamar a la función `foo` en **Contenedor A** utilizando el patrón `try/catch`. Si la llamada a `canisterA.foo()` tiene éxito, la función devuelve el valor de `foo`. Si se produce un error durante la llamada, se captura mediante el bloque catch y la función devuelve el texto `"Se produjo un error al llamar al contenedor A"`.

Este ejemplo ilustra cómo el patrón `try/catch` se puede utilizar para manejar errores al llamar funciones en otros contenedores, asegurando que tu programa continúe ejecutándose correctamente incluso si se produce un error durante la llamada.

## 🤔 Palabras finales
Lidiar con todas estas situaciones diferentes y formas de manejar problemas inesperados puede ser confuso al principio, especialmente cuando se trata del modelo `actor` y contextos asíncronos. Pero no te preocupes si no lo entiendes todo de inmediato. La mejor manera de entenderlo es practicar y a medida que encuentres diferentes situaciones, tu comprensión se fortalecerá. 
