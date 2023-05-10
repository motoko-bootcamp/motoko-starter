# Chapter 6: Storing data in data structures.
## 🗃️ Array
In Motoko, an array of type `Array` is a group of **similar** elements (i.e same type) that are stored together. To create an array, one must specify the types of elements that the array will contain. 
For instance, here is how to create an array that will hold `Nat`.
```motoko
let ages : [Nat] = [16, 32, 25, 8, 89];
```
An array that will hold values of type `Text`.
```motoko
let words : [Text] = ["Motoko", "is", "the", "best", "language"];
```
Contrary to other programming languages which might be more flexible in that regard, in Motoko we can't mix elements of different types in the same array. <br/>
The following code will throw an error: `literal of type Text does not have expected type Nat`. 
```motoko
let array : [Nat] = [14, 16, 32, 25, "Motoko"];
```
<p align="center"> <img src="assets/array.png" width="600px" style="border: 2px solid black;"></p>
To access a specific element within an array, we use its index. Keep in mind that arrays in Motoko are zero-indexed, which means that the first element is at position 0, the second element is at position 1, and so on. For example, to access the first element of an array named `myArray`, we would use `myArray[0]`, and to access the second element, we would use `myArray[1]`.
```motoko
let myArray : [Nat] = [23, 16, 32, 25];
let a = myArray[0]  // 23
let b = myArray[3]  // 25
```
We can access the size of an array using the `.size()` method.

```motoko
let names : [Text] = ["Emma Smith", "Olivia Johnson", "Ava Brown", "Isabella Davis"];
let size = names.size();    // 4
```

To loop over an array we can use the `.vals()` iterator. Here is an example that would gave us the sum of an array.
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

In Motoko, arrays have a fixed size that is determined when the array is created. This means that the size cannot be increased later on. To add a new element to an array, a new array must be created and all of the existing elements must be transferred to the new array manually. This makes `Array` not really adapted for datastructures that needs be constantly updated. 

Concatenating two arrays to an `Array` can be done using `Array.append()` - a function from the [Array](https://internetcomputer.org/docs/current/motoko/main/base/Array) module. 
```motoko
let array1 = [1, 2, 3];
let array2 = [4, 5, 6];
Array.append<Nat>(array1, array2) // [1, 2, 3, 4, 5, 6];
```
However, this function is **depreceated**. It is recommended to avoid it in production code. That's because as we've said before it is impossible to simply add elements to an array. Under the hood, `Array.append()` will create a new array and copy the values of the two existing arrays which is not efficient. 
## 🥞 Buffer
A more adapted structure to dynamically add new elements is the type `Buffer`. 
A `Buffer` can be instantiated using the [Buffer](https://internetcomputer.org/docs/current/motoko/main/base/Buffer) library. 
One needs to provide the types of elements stored inside and the initial capacity. 
The initial capacity represents the length of the underyling array that backs this list. In most cases, you will not have to worry about the `capacity` since the Buffer will automatically grow or resize the underlying array that holds the elements.
```motoko
import Buffer "mo:base/Buffer";
actor {
    let b = Buffer.Buffer<Nat>(2);
}
```
In this case, the types of elements in the buffer is `Nat` and the initial capacity of the buffer is `2`. 

To add an element use the `.add()` method.
```motoko
b.add(0);   // add 0 to buffer
b.add(10);   // add 10 to buffer
b.add(100)    // causes underlying arrray to increase in capacity since the capacity was set to 2
```
To get the number of elements in the buffer use the `.size()` method. The `size` is different than the capacity we've mentionned earlier since it represents the number of elements that are actually stored in the buffer.
```motoko
let b = Buffer.Buffer<Nat>(2);
b.add(0);   
b.add(10);   
b.add(100);  
b.size();   // 3
```
To access an elements in the buffer, use the `.get()` method and provides the index. Traps if `index` >= `size`. Indexing is zero-based like with `Array`.
```motoko
let b = Buffer.Buffer<Nat>(2);
b.add(0);   
b.add(10);   
b.add(100);  
b.get(2);   // 100
```

A buffer can easily be converted to an array using the `toArray()` function from the [Buffer library](https://internetcomputer.org/docs/current/motoko/main/base/Buffer#function-toarray-1).
```motoko
let b = Buffer.Buffer<Nat>(2);
b.add(0);   
b.add(10);   
Buffer.toArray<Nat>(b); // [0, 10];
```
## 🔗 List
Purely-functional, singly-linked lists. A list of type List<T> is either null or an optional pair of a value of type T and a tail, itself of type List<T>. 

[List library](https://internetcomputer.org/docs/current/motoko/main/base/List/)
```motoko
type List<T> = ?(T, List<T>);
```
"The difference between a list and an array is that an array is stored as one contiguous block of bytes in memory and a list is 'scattered' around without the elements having to be adjacent to each other. The advantage is that we can use memory more efficiently by filling the memory more flexibly. The downside is that for operations on the whole list, we have to visit each element one by one which may be computationally expensive."
[source](https://web3.motoko-book.dev/base-library/data-structures/list.html)

Read about Lists and Recursive types [here](https://web3.motoko-book.dev/advanced-types/recursive-types.html).

Here is an example of a function that retrieves the last element of a particular list.
```motoko
func last<T>(l : List<T>) : ?T {
    switch l {
        case null { null };
        case (?(x, null)) { ?x };
        case (?(_, t)) { last<T>(t) };
    };
};
```

## 💿 HashMap & TrieMap
In Motoko, [HashMap](https://internetcomputer.org/docs/current/references/motoko-ref/HashMap) and [TrieMap](https://internetcomputer.org/docs/current/references/motoko-ref/TrieMap) are both implemented as a Class and have the same interface. The only difference is that `TrieMap` is represented internaly by a `Trie` while `HashMap` is using `AssocList`. All examples that will follow use `HashMap` but it would be similar for `TrieMap`. 

- K is the type of the key (`Nat`, `Text`, `Principal`...)
- V is type of the value that will be stored (User data, Token balance...)

```motoko
class HashMap<K, V>(initCapacity : Nat, keyEq : (K, K) -> Bool, keyHash : K -> Hash.Hash)
```

To instantiate a value from the class, we need to provide:
1. An initial capacity of type `Nat`.
    ```motoko
    initCapacity : Nat
    ```
2. A function that can be used for testing equality of the keys.
    ```motoko
    keyEq : (K, K) -> Bool
    ```
3. A function that can be used for hashing the keys.
    ```motoko
    keyHash : K -> Hash.Hash
    ```

Let's imagine that we want to store a `Student` associated with his `Principal`. Where `Student` is defined as
```motoko
type Student = {
    name : Text;
    age : Nat;
    favoriteLanguage : Text;
    graduate : Bool;
};
```

In that case:
- K is of type `Principal` and represents the key of the HashMap.
- V is of type `User` and represents the stored value. 

To initiate our `HashMap`
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
To add a new entry to the `map` we can use the `.put()` method.
```motoko
map.put(principal, student);
```
This will insert the value `student` with key `principal` and overwrites any previous value. We can use this method to create a `register` function that students would need to call and provide all their relevant informations.

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

Once a value has been inserted in the `map`, we can access it using the `.get()` method.
```motoko
map.get(principal);
```
This will return an optional value `?Student` associated with the provided principal. We can use this method to create a `getStudent` `query` function that would return information on students.
```motoko
public query func getStudent(p : Principal) : async ?Student {
map.get(p);
};
```
We can delete a value from the `map` by using the `.delete()` or `remove()` methods.
```motoko
map.delete(principal);   // Delete but doesn't return the value
let oldValue = map.remove(principal);   // Delete but returns the value
```
It is possible to iterate over the map:
- You can iterate over the keys with `.keys()`.
- You can iterate over the values with `.vals()`.
- You can iterate over both with `.entries()`.
