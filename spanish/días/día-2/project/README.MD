# Diario de tareas 📔
En el segundo día de clases, tú y tus compañeros se encuentran inmersos en su primera tarea colaborativa. Aunque trabajar juntos es estimulante, el desafío de administrar responsabilidades y avances para cada miembro del equipo se hace evidente rápidamente... 😩 <br/>

Durante un descanso para almorzar, el grupo hace una lluvia de ideas para encontrar soluciones para un mejor sistema de organización de tareas y asignaciones. <br/>

Uno de tus compañeros propone la idea de crear un diario de tareas en la famosa **Joogle Cloud**, donde cada miembro puede actualizar tareas y monitorear el progreso. El grupo está de acuerdo y comienza a construir el diario. Mientras observas el proyecto tomando forma, notas una sonrisa astuta en el rostro de un estudiante. 😼 <br/>

Al día siguiente, descubres que este astuto estudiante ha explotado su acceso a las claves API, alterando el diario para marcar todas las tareas como completadas. 🫢 <br/>

La sorpresa y la desilusión se extienden por el grupo, y te das cuenta de que la solución centralizada no ha proporcionado la transparencia y seguridad que todos anhelaban.

Decididos a encontrar una mejor manera, el grupo se reúne una vez más, y tú compartes la idea de construir el diario colaborativo de tareas en el **Internet Computer**. <br/>
Los ojos de tus compañeros se iluminan al comprender el potencial de una plataforma descentralizada para fomentar la transparencia, la unidad y la confianza entre tus compañeros. 🫂

## 🧑‍🏫 Requisitos 
Tu tarea es crear un diario de tareas colaborativo, implementado como un canister. El diario de tareas permitirá a los estudiantes crear, editar, eliminar y ver sus tareas.
## 📒 Pasos
Importamos el tipo `Time` para la biblioteca `Time`. 
1. Define un tipo de registro `Homework` que represente una tarea. Un `Homework` tiene un campo de título de tipo `Text`, un campo de descripción de tipo `Text`, un campo de fecha de vencimiento de tipo `Time` y un campo de completado de tipo `Bool`.
2. Define una variable llamada `homeworkDiary` que se utilizará para almacenar las tareas. Utiliza una estructura de datos adecuada (como `Buffer` o `Array`) para esta variable.
3. Implementa `addHomework`, que acepta una tarea de tipo `Homework`, agrega la tarea al `homeworkDiary` y devuelve el ID de la tarea. El ID debe corresponder al índice de la tarea en `homeworkDiary`.
4. Implementa `getHomework`, que acepta un `homeworkId` de tipo `Nat` y devuelve la tarea correspondiente envuelta en un resultado Ok. Si `homeworkId` no es válido, la función debe devolver un mensaje de error envuelto en un resultado `Err`.
5. Implementa `updateHomework`, que acepta un `homeworkId` de tipo `Nat` y una tarea de tipo `Homework`, actualiza la tarea correspondiente en `homeworkDiary` y devuelve un valor unitario envuelto en un resultado `Ok`. Si `homeworkId` no es válido, la función debe devolver un mensaje de error envuelto en un resultado `Err`.
6. Implementa `markAsComplete`, que acepta un `homeworkId` de tipo `Nat` y actualiza el campo `completed` de la tarea correspondiente a `true` y devuelve un valor unitario envuelto en un resultado `Ok`. Si `homeworkId` no es válido, la función debe devolver un mensaje de error envuelto en un resultado `Err`.
7. Implementa `deleteHomework`, que acepta un `homeworkId` de tipo `Nat`, elimina la tarea correspondiente de `homeworkDiary` y devuelve un valor unitario envuelto en un resultado `Ok`. Si `homeworkId` no es válido, la función debe devolver un mensaje de error envuelto en un resultado `Err`.
8. Implementa `getAllHomework`, que devuelve la lista de todas las tareas en `homeworkDiary`.
9. Implementa `getPendingHomework`, que devuelve la lista de todas las tareas en `homeworkDiary`.
10. Implementa una función de consulta `searchHomework` que acepta un `searchTerm` de tipo `Text` y devuelve una lista de tareas que tienen el `searchTerm` dado en su título o descripción.
11. Despliega el diario de tareas en Internet Computer.
## 📺 Interfaz
> Al final del proyecto, tu canister debería implementar la siguiente interfaz.
```motoko
actor {
    // Agregar nueva tarea.
    addHomework: shared (homework: Homework) -> async Nat;

    // Obtener una tarea específica por id.
    getHomework: shared query (id: Nat) -> async Result.Result<Homework, Text>;

    // Actualizar el título, descripción y/o fecha de vencimiento de una tarea.
    updateHomework: shared (id: Nat, homework: Homework) -> async Result.Result<(), Text>;

    // Marcar tarea como completada.
    markAsCompleted: shared (id: Nat) -> async Result.Result<(), Text>;

    // Eliminar tarea por id.
    deleteHomework: shared (id: Nat) -> async Result.Result<(), Text>;

    // Obtener lista de todas las tareas.
    getAllHomework: shared query () -> async [Homework];

    // Obtener lista de tarea listas (No completadas).
    getPendingHomework: shared query () -> async [Homework];

    // Buscar tareas en base a términos de búsqueda.
    searchHomework: shared query (searchTerm: Text) -> async [Homework];
}
```
