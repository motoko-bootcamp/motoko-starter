# Capítulo 7: Tipos no primitivos.
## 👯 Tuplas
Las tuplas son unidades básicas que pueden abarcar múltiples elementos. Si bien los elementos pueden variar en tipo de datos, una vez declarado, el número y tipo de elementos en una tupla no se pueden alterar. Por ejemplo, se podría hacer una tupla que contenga el nombre de un estudiante, su edad y su lenguaje de programación favorito.
```motoko
type Student = (Text, Nat, Text);
let me : Student  = ("Bob Smith", 25, "Motoko");
```
En situaciones más complejas, crearíamos nuestro propio objeto con campos nombrados, lo que lo haría más legible.

El tipo de tupla vacío `()` se llama tipo `unit`. Por lo general, se utiliza como tipo de retorno para una función que no devuelve nada.

```motoko
public func print(t : Text) : async () {
    Debug.print(t);
};
```
## 🎨 Objetos
Los objetos son más legibles que las tuplas ya que cada campo tiene un nombre. También se asigna un tipo diferente a cada campo, que no se puede modificar una vez declarado. 

Definamos un objeto llamado `student`, que contiene 4 campos:
- `name` que es un `Text` que indica el nombre del estudiante.
- `age` que es un `Nat` que indica la edad del estudiante.
- `favoriteLanguage` que es un `Text` que indica el lenguaje de programación favorito del estudiante.
- `graduate` que es un `Bool` que indica si el estudiante ya se ha graduado del Bootcamp de Motoko.

```motoko
let student = {
    name = "John";
    age = 35;
    favoriteLanguage: "Motoko":
    graduate : true;
};
```
Al igual que otras variables en Motoko, los objetos pueden ser mutables o inmutables. El objeto que acabamos de definir es inmutable, una vez que los campos han sido asignados un valor, no se pueden modificar.

```motoko
let student = {
    name = "John";
    age = 35;
    favoriteLanguage: "Motoko":
    graduate : true;
};
student.age += 1;  
```

Este código lanzará un error `expected mutable assignment target`.

Para crear un objeto que se pueda modificar, debemos usar la palabra clave `var` en la definición del campo. Modifiquemos el ejemplo anterior para que solo se pueda cambiar la edad del estudiante, mientras que los otros campos siguen siendo constantes.

```motoko
let student = {
    name = "John";
    var age = 35;
    favoriteLanguage: "Motoko":
    graduate : true;
};
student.age += 1; 
```

A menudo, a los objetos se les asignan tipos. En este caso, debemos crear un **tipo personalizado**. Definamos un tipo llamado `Student` que corresponda al objeto que creamos anteriormente.

```motoko
type Student = {
    name : Text;
    age : Nat;
    favoriteLanguage : Text;
    graduate : Bool;
};
```

## 🌈 Variantes
Una variante le permite crear un tipo que contiene diferentes casos. Un valor del tipo de variante representa un valor que es exactamente uno de los casos o etiquetas dados. Definamos un tipo de variante para un `Vehicle` que puede ser un automóvil, una moto o un avión.

```motoko
type Vehicle = {
    #Car;
    #Moto;
    #Plane;
};
```
A cada etiqueta se le puede asociar su propio tipo personalizado.
```motoko
type Car = { make : Text; model : Text; year : Nat; color: Text };
type Moto = { make : Text; model : Text; year : Nat; type : Text };
type Plane = { make : Text; model : Text; year : Nat; seats : Nat };

type Vehicle = {
    #Car : Car;
    #Moto : Moto;
    #Plane : Plane;
};
```

Las variantes se utilizan a menudo con `switch/case`, lo que permite realizar el control de flujo en un objeto de variante.
```motoko
public func start(v : Vehicle) : async Text {
    switch(v){
        case(#Car(car)){
            // We can access the car object. For instance we can access the make field by using car.make
            let make = car.age;
            return("Vroom 🏎️");
        };
        case(#Moto(m)){
            // We can give the object any name that is convenient. In this case we can access the type by using m.type.
            let type = m.type;
              return("Roar 🏍️");
        };
        case(#Plane(x)){
            // Here we go again.. we can access the number of seats by using x.seats
            let seats = x.seats;
             return("Whoosh 🛫");
        };
    };
};
```

## ✍️ Arrays mutables
Read [this section](https://web3.motoko-book.dev/common-programming-concepts/types/mutable-arrays.html?highlight=Mutable%20arrays#mutable-arrays) from the Motoko Book. 

## ⏭️ Iteradores
Read [this section](https://web3.motoko-book.dev/base-library/utils/iter.html?highlight=Itera#iteriterate) from the Motoko Book. 
