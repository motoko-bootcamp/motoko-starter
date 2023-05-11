# El Verificador 👨‍🏫
## Introducción
Imagina que eres un instructor en [Motoko School](https://twitter.com/MotokoSchool), donde actualmente supervisas a una cohorte de más de 200 estudiantes dedicados. 🤯 <br/>
Como parte del programa, has asignado a estos ambiciosos aprendices a abordar 4 proyectos distintos, cada uno diseñado para desafiar sus habilidades y conocimientos. Al completarlos, recae sobre tus hombros revisar y evaluar meticulosamente su trabajo, determinando en última instancia si han cumplido con los criterios para [graduarse](../../../README.MD#🎓-graduation). <br/>
Afortunadamente, como desarrollador experto en Motoko tú mismo, posees la experiencia y la confianza para simplificar este proceso de verificación mediante la automatización. Este enfoque innovador no solo te ahorrará tiempo valioso, sino que también pavimentará el camino para el futuro del **Motoko Bootcamp**. ¡Comencemos!
## 🧑‍🏫 Requisitos
Tu tarea es crear el código para un **instructor**, que se implementa como un canister. La idea es que el estudiante ingrese su id de canister y se verifique automáticamente por el canister. Si el id de canister enviado cumple con los requisitos, los estudiantes se graduarán automáticamente; ¡imagina las horas de trabajo que ahorrarás! <br/>

[AGREGAR ILUSTRACIÓN]

> Para el propósito de este Bootcamp, no intentaremos construir un verificador que pruebe los 4 proyectos anteriores. Solo intentaremos verificar una versión simple de la calculadora que implementaste durante el Día 1. El código para esta calculadora simple ya ha sido implementado y se puede encontrar [aquí](../project/calculator/main.mo).

## Parte 1: Almacenar información de los estudiantes.
La idea en esta sección es construir el código para almacenar información sobre los estudiantes.
### Paso a paso
Un perfil de estudiante se define de la siguiente manera:
```motoko
public type StudentProfile = {
    name : Text;
    Team : Text;
    graduate : Bool;
};
```
1. Define una variable llamada `studentProfileStore`, que es un `HashMap` para almacenar el perfil de los estudiantes. Las claves en este mapa son de tipo `Principal` y representan la identidad de los estudiantes, mientras que los valores son de tipo `StudentProfile`.
2. Implementa la función `addMyProfile` que acepta un `perfil` de tipo `StudentProfile` y lo agrega al `studentProfileStore`. Esta función asume que el `caller` es el estudiante correspondiente al perfil.
```motoko
addMyProfile: shared (profile : StudentProfile) -> async Result.Result<(), Text>;
```
3. Implementa la función de consulta `seeAProfile`, que acepta un principal `p` de tipo `Principal` y devuelve el perfil del estudiante correspondiente (si existe) como un valor opcional.
```motoko
seeAProfile : query (p : Principal) -> async ?StudentProfile;
```
4. Implementa la función `updateMyProfile` que permite a un estudiante realizar una modificación en su perfil de estudiante. Si todo funciona, y el perfil se actualiza, la función debe devolver un valor unitario simple envuelto en un resultado `Ok`. Si el `caller` no tiene un perfil de estudiante, la función debe devolver un mensaje de error envuelto en un resultado `Err`.
```motoko
updateMyProfile : shared (profile : StudentProfile) -> async Result.Result<(), Text>;
```
5. Implementa la función `deleteMyProfile` que permite a un estudiante eliminar su perfil de estudiante. Si todo funciona y el perfil se elimina, la función debe devolver un valor unitario simple envuelto en un resultado `Ok`. Si el `caller` no tiene un perfil de estudiante, la función debe devolver un mensaje de error envuelto en un resultado `Err`.
```motoko
deleteMyProfile : shared (profile : StudentProfile) -> async Result.Result<(), Text>;
```
6. Asegúrate de que `studentProfileStore` sea resistente a las actualizaciones, lo que significa que todos los perfiles de estudiantes se conservarán incluso si el canister se actualiza. Implementa esto utilizando los ganchos `pre_upgrade` y `post_upgrade`.

## Parte 2: Pruebas de la calculadora simple.
La idea en esta sección es implementar el código que realiza la prueba en la calculadora simple.
Vamos a probar:
- La función `reset`.
- La función `add`.
- La función `sub`.

Si esas tres funciones se implementan correctamente, entonces la prueba es positiva y se valida el canister.

### Paso a paso
El tipo `TestResult` se define de la siguiente manera:
```motoko
    public type TestResult = Result.Result<(), TestError>;
    public type TestError = {
        #UnexpectedValue : Text;
        #UnexpectedError : Text;
    };
```
1. Implementa la función `test` que toma un `canisterId` de tipo `Principal` y devuelve el resultado de la prueba de tipo `TestResult`. Asegúrate de distinguir entre los dos tipos de errores.

- Se debe devolver `UnexpectedValue` cada vez que la calculadora devuelve un valor incorrecto. Por ejemplo, si una llamada a `reset` seguida de `add(1)` devuelve 2.
- Se debe devolver `UnexpectedError` para todos los demás tipos de errores. Por ejemplo, si la función `add` ni siquiera está implementada como parte de la interfaz del canister.
```motoko
test: shared (canisterId : Principal) -> async TestResult;
```

## Parte 3: Verificar el controlador de la calculadora.
En esta sección queremos asegurarnos de que el propietario del canister verificado sea realmente el estudiante que lo registró. De lo contrario, un estudiante podría usar el canister de otro.
### Paso a paso
1. Implementa la función `verifyOwnership` que toma un `canisterId` de tipo `Principal` y un `principalId` de tipo `Principal` y devuelve un booleano que indica si el `principalId` está entre los controladores del canister correspondiente al `canisterId` proporcionado.

> Desafortunadamente, a partir de hoy, el método `canister_status` del canister de administración solo se puede usar cuando el canister que lo llama también es uno de los controladores del canister que estás intentando verificar. [Lee el tema dedicado para obtener más información](https://forum.dfinity.org/t/how-to-find-out-the-controllers-of-a-canister/14345/3).

## Parte 4: ¡Graduación!
En esta sección, la idea es permitir que los estudiantes envíen su trabajo y verifiquen automáticamente el canister. Si se aprueban las pruebas, el campo `graduation` del estudiante se cambia automáticamente.
1. Implementa la función `verifyWork` que toma un `canisterId` de tipo `Principal` y realiza las verificaciones necesarias en el canister. Si se validan todos los criterios para la graduación, entonces el campo `graduation` se actualiza en consecuencia.

## Parte 5: Lista de graduados 🎓
En esta sección, la idea es implementar una función para manejar solicitudes HTTP dentro del canister verificador. Cualquiera debería poder ir a ...

1. Crea un `Array` llamado `graduates` que almacena el nombre de los graduados.
2. Implementa un temporizador para que el array se actualice cada hora.
3. Implementa el método `http_request`.

## 📺 Interfaz
> Al final del proyecto, tu canister debe implementar la siguiente interfaz:
```motoko
actor Verifier {

};
```

