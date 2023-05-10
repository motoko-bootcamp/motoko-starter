# Chapter 7: Non-primitives Types.
## 👯 Tuples
Tuples are basic units that can encompass multiple elements. While the elements can vary in data type, once declared, the number and type of elements in a tuple cannot be altered. For instance, you could make a tuple that holds a student's name, age & favorite programming language.
```motoko
type Student = (Text, Nat, Text);
let me : Student  = ("Bob Smith", 25, "Motoko");
```
In more complex situations, we would create our own object with named fields, making it more readable. 

The empty tuple type `()` is called the `unit` type. It is usually used as return type for function that returns nothing. 
 
```motoko
public func print(t : Text) : async () {
    Debug.print(t);
};
```
## 🎨 Objects
Objects are more readable than tuples since each field has a name. The  different fields are also each assigned a type which cannot be modified once declared.  
 Let's define an object called `student`, which contains 4 fields: 
 - name which is a `Text` indicating the name of the student.
 - age which is a `Nat` indicating the age of the student.
 - favoriteLanguage which is a `Text` indicating the favorite programming language of the student.
 - graduate which is a `Bool` indicating if the students has already graduated from the Motoko Bootcamp. 

```motoko
let student = {
    name = "John";
    age = 35;
    favoriteLanguage = "Motoko";
    graduate = true;
};
```
Similar to other variables in Motoko, objects can be mutable or immutable. The object we've just defined is immutable, once the fields have been assigned a value they cannot be modified. 

```motoko
let student = {
    name = "John";
    age = 35;
    favoriteLanguage = "Motoko";
    graduate = true;
};
student.age += 1;  
```
This code will throw an error `expected mutable assignment target`.

To create an object that can be modified, we must use the `var` keyword in the field definition. Let's modify the previous example so that only the student's age can be changed, while the other fields remain constant.
```motoko
let student = {
    name = "John";
    var age = 35;
    favoriteLanguage = "Motoko";
    graduate = true;
};
student.age += 1; 
```
Objects are often assigned types. In this case we need to create **custom type**.  Let's define a type called `Student` which corresponds the object we've previously created. 
```motoko
type Student = {
    name : Text;
    age : Nat;
    favoriteLanguage : Text;
    graduate : Bool;
};
```

## 🌈 Variants
A variant allows you to create a type that contains different cases. A value from the variant type represents one value that is exactly one of the given cases, or tags. Let's define a variant type for a `Vehicle` which can be either a car, a moto or a plane.

```motoko
type Vehicle = {
    #Car;
    #Moto;
    #Plane;
};
```
Each tag can be associated it's own custom type. 
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

Variants are often used with `switch/case`, which allows to perform control flow on a variant object. 
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
## ✍️ Mutable Arrays
Read [this section](https://web3.motoko-book.dev/common-programming-concepts/types/mutable-arrays.html?highlight=Mutable%20arrays#mutable-arrays) from the Motoko Book. 
## ⏭️ Iterators
Read [this section](https://web3.motoko-book.dev/base-library/utils/iter.html?highlight=Itera#iteriterate) from the Motoko Book. 
