# Capítulo 6: Almacenamiento de datos en estructuras de datos.
## 🗃️ Array
En Motoko, una matriz de tipo `Array` es un grupo de elementos **similares** (es decir, del mismo tipo) que se almacenan juntos. Para crear una matriz, se debe especificar los tipos de elementos que la matriz contendrá. 
Por ejemplo, así es como se crea una matriz que contendrá `Nat`.
```motoko
let ages : [Nat] = [16, 32, 25, 8, 89];
```
Un arreglo que guarde valores de tipo `Text`.
```motoko
let words : [Text] = ["Motoko", "is", "the", "best", "language"];
```
Contrario a otros lenguajes de programación que pueden ser más flexibles en ese sentido, en Motoko no podemos mezclar elementos de diferentes tipos en el mismo array. <br/>
El siguiente código generará un error: `literal of type Text does not have expected type Nat`. 
```motoko
let array : [Nat] = [14, 16, 32, 25, "Motoko"];
```
<p align="center"> <img src="assets/array.png" width="600px" style="border: 2px solid black;"></p>
Para acceder a un elemento específico dentro de un array, usamos su índice. Tenga en cuenta que los arrays en Motoko comienzan en cero, lo que significa que el primer elemento está en la posición 0, el segundo elemento está en la posición 1, y así sucesivamente. Por ejemplo, para acceder al primer elemento de un array llamado `myArray`, usaríamos `myArray[0]`, y para acceder al segundo elemento, usaríamos `myArray[1]`.
```motoko
let myArray : [Nat] = [23, 16, 32, 25];
let a = myArray[0]  // 23
let b = myArray[3]  // 25
```
Podemos acceder al tamaño de un array usando el método `.size()`.

```motoko
let names : [Text] = ["Emma Smith", "Olivia Johnson", "Ava Brown", "Isabella Davis"];
let size = names.size();    // 4
```

Para iterar sobre un array, podemos usar el iterador `.vals()`. Aquí hay un ejemplo que nos daría la suma de un array.
```motoko
actor {
    let array : [Nat] = [1, 2, 3, 4, 5];
    var sum : Nat = 0;

    public func somme_array() : async Nat {
        for (value in array.vals()){
          sum := sum + value;
        };
       return sum; 
    };
};
```

En Motoko, los arrays tienen un tamaño fijo que se determina cuando se crea el array. Esto significa que el tamaño no se puede aumentar más tarde. Para agregar un nuevo elemento a un array, se debe crear un nuevo array y transferir manualmente todos los elementos existentes al nuevo array. Esto hace que `Array` no sea realmente adecuado para estructuras de datos que necesiten ser actualizadas constantemente.

La concatenación de dos arrays en un `Array` se puede hacer usando `Array.append()` - una función del módulo [Array](https://internetcomputer.org/docs/current/motoko/main/base/Array). 
```motoko
let array1 = [1, 2, 3];
let array2 = [4, 5, 6];
Array.append<Nat>(array1, array2) // [1, 2, 3, 4, 5, 6];
```
Sin embargo, esta función está **obsoleta**. Se recomienda evitarla en el código de producción. Esto se debe a que, como mencionamos anteriormente, es imposible simplemente agregar elementos a un array. En realidad, `Array.append()` creará un nuevo array y copiará los valores de los dos arrays existentes, lo cual no es eficiente.

## 🥞 Buffer
Una estructura más adecuada para agregar dinámicamente nuevos elementos es el tipo `Buffer`. 
Un `Buffer` se puede instanciar utilizando la biblioteca [Buffer](https://internetcomputer.org/docs/current/motoko/main/base/Buffer). 
Es necesario proporcionar los tipos de elementos almacenados en el interior y la capacidad inicial. 
La capacidad inicial representa la longitud del array subyacente que respalda esta lista. En la mayoría de los casos, no tendrá que preocuparse por la `capacity` ya que el Buffer automáticamente crecerá o cambiará el tamaño del array subyacente que contiene los elementos.
```motoko
import Buffer "mo:base/Buffer";
actor {
    let b = Buffer.Buffer<Nat>(2);
}
```
En este caso, los tipos de elementos en el buffer son de type `Nat` y la capacidad inicial del buffer es `2`. 

Para agregar un elemento utilizar el método `.add()`.
```motoko
b.add(0);   // add 0 to buffer
b.add(10);   // add 10 to buffer
b.add(100)    // causes underlying arrray to increase in capacity since the capacity was set to 2
```
Para obtener el número de elementos en el buffer utilizar el método `.size()`. El `size` es diferente que la capacidad que mencionamos antes dado que representa el número de elementos que realmente están almacenados en el buffer.
```motoko
let b = Buffer.Buffer<Nat>(2);
b.add(0);   
b.add(10);   
b.add(100);  
b.size();   // 3
```
Para acceder a elementos en el buffer, utiliza el método `.get()` e indica el índice. Traps si `index` >= `size`. El índice se inicio en cero como el `Array`.
```motoko
let b = Buffer.Buffer<Nat>(2);
b.add(0);   
b.add(10);   
b.add(100);  
b.get(2);   // 10
```

Un buffer puedes facilmente ser convertido en un array utilizando la función `toArray()`  de la [Librería Buffer](https://internetcomputer.org/docs/current/motoko/main/base/Buffer#function-toarray-1).
```motoko
let b = Buffer.Buffer<Nat>(2);
b.add(0);   
b.add(10);   
Buffer.toArray<Nat>(b); // [0, 10];
```
## 🔗 List
Una lista de tipo List<T> es una lista enlazada que es o nula o una pareja opcional de un valor de tipo T y una cola, que es a su vez de tipo List<T>.

[Librería List](https://internetcomputer.org/docs/current/motoko/main/base/List/)

```motoko
type List<T> = ?(T, List<T>);
```
```
"La diferencia entre una lista y un arreglo es que un arreglo se almacena como un bloque continuo de bytes en memoria y una lista está 'esparcida' sin que los elementos tengan que estar juntos. La ventaja es que podemos usar la memoria de manera más eficiente llenando la memoria de manera más flexible. El inconveniente es que para operaciones en toda la lista, tenemos que visitar cada elemento uno por uno, lo que puede ser computacionalmente costoso." -(fuente)[https://web3.motoko-book.dev/base-library/data-structures/list.html]
Lee sobre listas y tipos recursivos aquí.

Aquí tienes un ejemplo de una función que recupera el último elemento de una lista en particular.
```motoko
func last<T>(l : List<T>) : ?T {
    switch l {
        case null { null };
        case (?(x, null)) { ?x };
        case (?(_, t)) { last<T>(t) };
    };
};
```

## 💿 HashMap y TrieMap
En Motoko, [HashMap](https://internetcomputer.org/docs/current/references/motoko-ref/HashMap) y [TrieMap](https://internetcomputer.org/docs/current/references/motoko-ref/HashMap) se implementan como una clase y tienen la misma interfaz. La única diferencia es que `TrieMap` se representa internamente como un `Trie`, mientras que `HashMap` utiliza `AssocList`. Todos los ejemplos que seguirán usarán `HashMap`, pero sería similar para `TrieMap`.

- K es el tipo de la clave (`Nat`, `Text`, `Principal`...)
- V es el tipo del valor que se almacenará (Datos de usuario, saldo de tokens...)

```motoko
class HashMap<K, V>(initCapacity : Nat, keyEq : (K, K) -> Bool, keyHash : K -> Hash.Hash)
```

Para instanciar un valor de la clase, necesitamos proporcionar:
1. Una capacidad inicial de tipo `Nat`.
    ```motoko
    initCapacity : Nat
    ```
2. Una función que se pueda utilizar para probar la igualdad de las claves.
    ```motoko
    keyEq : (K, K) -> Bool
    ```
3. Una función que se pueda utilizar para el hash de las claves.
    ```motoko
    keyHash : K -> Hash.Hash
    ```

Imaginemos que queremos almacenar un `Estudiante` asociado con su `Principal`. Donde `Estudiante` está definido como:```motoko
type Student = {
    name : Text;
    age : Nat;
    favoriteLanguage : Text;
    graduate : Bool;
};
```

En ese caso:
- K es de tipo `Principal` y representa la clave del HashMap.
- V es de tipo `User` y representa el valor almacenado.

Para iniciar nuestro `HashMap`, podemos hacer lo siguiente:
```motoko
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
actor {
    type Student = {
        name : Text;
        age : Nat;
        favoriteLanguage : Text;
        graduate : Bool;
    };

    let map = HashMap.HashMap<Principal, Student>(1, Principal.equal, Principal.hash);
}
```
Para agregar una nueva entrada al `map`, podemos usar el método `.put()`.
  
```motoko
map.put(principal, student);
```
Esto insertará el valor `student` con la clave `principal` y sobrescribirá cualquier valor anterior. Podemos usar este método para crear una función `register` que los estudiantes tendrían que llamar y proporcionar toda su información relevante.

```motoko
public shared ({ caller }) func register(name : Text, age : Nat, favoriteLanguage : Text) : async () {
    if(Principal.isAnonymous(caller)){
        // We don't want to register the anonymous identity
        return;
    };
    let student : Student = {
        name;
        age;
        favoriteLanguage;
        graduate = false;  
    };
    map.put(caller, student);
};
```

Una vez que se ha insertado un valor en el `map`, podemos acceder a él utilizando el método `.get()`.
```motoko
map.get(principal);
```
Esto devolverá un valor opcional `?Student` asociado con el `principal` proporcionado. Podemos usar este método para crear una función de consulta `getStudent` que devolvería información sobre los estudiantes.
```motoko
public query func getStudent(p : Principal) : async ?Student {
map.get(p);
};
```
Podemos eliminar un valor del `map` utilizando los métodos `.delete()` o `remove()`.
```motoko
map.delete(principal);   // Delete but doesn't return the value
let oldValue = map.remove(principal);   // Delete but returns the value
```
Es posible iterar sobre el mapa:
- Puede iterar sobre las claves con `.keys()`.
- Puede iterar sobre los valores con `.vals()`.
- Puede iterar sobre ambos con `.entries()`.
