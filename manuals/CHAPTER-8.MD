# Chapter 8: Advanced Types.
## ? Optional types
WIP
## 👤 Generic Type
A generic type, usually written as `T`, allows you to write functions and code that can adapt to different types. When we talk about `T`, it refers to **whatever type you want**. This means that you can create a single function or class that can handle multiple types of inputs or data, without having to write separate code for each type.

Let's imagine that we have a task at hand - to determine if the size of an array is even or not. We're going to write a function called `isArrayEven` that takes an array as an input and returns a `Bool` value indicating whether the size of that array is even or not.
```motoko
public func isArrayEven(array : [Nat]) : async Bool {
    let size = array.size();
    if(size % 2 == 0){
        return true;
    } else {
        return false;
    };
};
```
This function works as intended, but is limited to arrays filled with `Nat`. So, what if we want to check the size of an array filled with `Text` or `Int`? <br>
One approach would be to create a separate function for each possible type: 
- `isArrayEvenNat`
- `isArrayEvenText`
- `isArrayEvenInt` 

As you can imagine, this quickly becomes hard to manage and maintain. A better solution is to utilize the power of generics. With generics, we can write a single function that works for any type of array. It's a more elegant and efficient way to solve the problem. So, let's embrace our new friend - generics - and make our code more dynamic and flexible!
```motoko
func isArrayEven<T>(array : [T]) : Bool {
    let size = array.size();
    if(size % 2 == 0){
        return true;
    } else {
        return false;
    };
};
```
Notice `<T>` following the name of the function. It means that this function now depends on the type of `T`. We need to specify the type of `T` when we want to use the function.
```motoko
let array : [Nat] = [1,2,3,4];
let bool : Boolean = isArrayEvent<Nat>(array); // Replace T with the actual type when you use the function. 
```

We've  already used generics when playing with `Buffer` & `Array` without talking about it. 
- The type `Buffer<T>` is a generic class and we need to provide a type when creating a new buffer.
    ```motoko
    let b = Buffer.Buffer<Nat>(2);
    ```

- `Array.append<T>` is a generic function and we need to provide the type of the elements of the arrays we are concatening.
    ```motoko
    let array1 = [1, 2, 3];
    let array2 = [4, 5, 6];
    Array.append<Nat>(array1, array2) // [1, 2, 3, 4, 5, 6];
    ```
## Recursive types.
WIP
## Shared types.
WIP