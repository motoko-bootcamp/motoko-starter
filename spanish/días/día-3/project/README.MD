# Muro de estudiantes 🎨

Era tu tercer día en Motoko School y estabas decidido a empezar a hacer buenos amigos. Siendo un gran fanático de la música, pensaste que organizar un pequeño concierto podría ser una excelente manera de conocer a otros estudiantes con intereses similares. 🎶

Mientras paseabas por los pasillos durante la hora del almuerzo, escuchaste a dos estudiantes discutiendo cómo desearían que hubiera una mejor manera de mantenerse informados sobre los eventos y actividades escolares. Se quejaron de cómo se habían perdido la Conferencia de la Comunidad de ICP del año anterior porque no estaban al tanto a tiempo, y de cómo estaban decididos a no dejar que eso vuelva a suceder este año. 💪

Esto despertó una idea en tu mente. <br/>

¿Qué tal si pudieras crear una plataforma digital donde los estudiantes compartieran los eventos y actividades próximas? Sería la manera perfecta de publicitar tu concierto de música y ayudar a otros estudiantes a mantenerse informados sobre todo lo que sucede en el campus. 📅

Compartiste rápidamente tu idea con los dos estudiantes y les encantó. Te presentaron a otros interesados en la idea, y antes de que te dieras cuenta, tenías un grupo de estudiantes motivados listos para dar vida a tu idea. 🚀

Todos se reunieron en el laboratorio de computación y comenzaron a pensar en las características de su muro de estudiantes. Querían que fuera algo más que un tablero de anuncios, así que se les ocurrió la idea de incluir imágenes y encuestas también. Dividieron el trabajo y comenzaron a codificar.
## 🧑‍🏫 Requisitos
Tu tarea es desarrollar el código para un muro de estudiantes, implementado como un canister, una plataforma digital que revolucionará la forma en que los estudiantes se comunican y se mantienen informados sobre eventos, clubes y actividades de la comunidad. Imagina un espacio dinámico e interactivo donde los estudiantes puedan compartir sus pensamientos, ideas y eventos próximos entre ellos.

Este muro será el destino principal para los estudiantes que buscan obtener la información más reciente sobre lo que está sucediendo en la escuela.
## 📺 Interfaz
Tu canister debe implementar la siguiente interfaz:
```motoko
actor {
   
    // Add a new message to the wall
    writeMessage: shared (c : Content) -> async Nat;

    //Get a specific message by ID
    getMessage: shared query (messageId : Nat) -> async Result.Result<Message, Text>;

    // Update the content for a specific message by ID
    updateMessage: shared (messageId : Nat, c : Content) -> async Result.Result<(), Text>;

    //Delete a specific message by ID
    deleteMessage: shared (messageId : Nat) -> async Result.Result<(), Text>;

    // Voting
    upVote: shared (messageId  : Nat) -> async Result.Result<(), Text>;
    downVote: shared (messageId  : Nat) -> async Result.Result<(), Text>;

    //Get all messages
    getAllMessages : query () -> async [Message];

    //Get all messages
    getAllMessagesRanked : query () -> async [Message];
};
```
## 📒 Pasos
Definimos un tipo de variante llamado `Content` que representa el tipo de contenido de los mensajes que pueden ser publicados en el muro.
```motoko
public type Content = {
    #Text: Text;
    #Image: Blob;
    #Video: Blob;
};
```
1. Define un nuevo tipo de registro llamado `Message`. Un mensaje de tipo `Message` contiene un campo `vote` de tipo `Int`, un campo `content` de tipo `Content` y un campo `creator` de tipo `Principal` que representa al creador del mensaje.
2. Define una variable llamada `messageId` que sirve como un contador continuamente creciente, manteniendo un registro del total de mensajes publicados.
3. Crea una variable llamada `wall`, que es un `HashMap` diseñado para almacenar mensajes. En este muro, las claves son de tipo `Nat` y representan los ID de los mensajes, mientras que los valores son de tipo `Message`.
4. Implementa la función `writeMessage`, que acepta un contenido `c` de tipo `Content`, crea un mensaje a partir del contenido, lo agrega al muro y devuelve el ID del mensaje.
5. Implementa la función `getMessage`, que acepta un `messageId` de tipo `Nat` y devuelve el mensaje correspondiente envuelto en un resultado `Ok`. Si el `messageId` es inválido, la función debe devolver un mensaje de error envuelto en un resultado `Err`.
6. Implementa la función `updateMessage`, que acepta un `messageId` de tipo `Nat` y un contenido `c` de tipo `Content`, y actualiza el contenido del mensaje correspondiente. Esto solo debe funcionar si el llamador es el `creator` del mensaje. Si el `messageId` es inválido o el llamador no es el `creator`, la función debe devolver un mensaje de error envuelto en un resultado `Err`. Si todo funciona y el mensaje se actualiza, la función debe devolver un valor de unidad simple envuelto en un resultado `Ok`.
7. Implementa la función `deleteMessage`, que acepta un `messageId` de tipo `Nat`, elimina el mensaje correspondiente del `wall` y devuelve un valor de unidad envuelto en un resultado `Ok`. Si el `messageId` es inválido, la función debe devolver un mensaje de error envuelto en un resultado `Err`.
8. Implementa la función `upVote`, que acepta un `messageId` de tipo `Nat`, agrega un voto al mensaje y devuelve un valor de unidad envuelto en un resultado `Ok`. Si el `messageId` es inválido, la función debe devolver un mensaje de error envuelto en un resultado `Err`.
9. Implementa la función `downVote`, que acepta un `messageId` de tipo `Nat`, resta un voto al mensaje y devuelve un valor de unidad envuelto en un resultado `Ok`. Si el `messageId` es inválido, la función debe devolver un mensaje de error envuelto en un resultado `Err`.
10. Implementa la función de consulta `getAllMessages`, que devuelve la lista de todos los mensajes.
11. Implementa la función de consulta `getAllMessagesRanked`, que devuelve la lista de todos los mensajes, donde cada mensaje está ordenado por el número de votos. El primer mensaje de la lista debe ser el mensaje con más votos.
12. Despliega el muro de estudiantes en Internet Computer.
13. (Paso de bonificación) Construye una interfaz de usuario para el muro e integra Internet Identity para autenticar a los usuarios que publiquen en el muro.

