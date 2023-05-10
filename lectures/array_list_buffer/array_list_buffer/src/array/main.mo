import Debug "mo:base/Debug";
import Array "mo:base/Array";
actor TestArray {

   var words : [Text] = ["Motoko", "is", "the", "best" , "language"];

    // Print all elements of the provided array
    public func printAllElements(array : [Text]) : async () {
        for(i in array.vals()){
            Debug.print(i);
        };
    };

    // Add two arrays together
    public func addArrays(array1 : [Text], array2: [Text]) : async [Text] {
        return(Array.append(array1, array2));
    };

    private func _addOne (n : Nat) : Nat {
        n + 1;
    };

    // Add 1 to all elements inside the array
    public func addOne(array : [Nat]) : async [Nat] {
        return(Array.map(array, _addOne));
    };


};