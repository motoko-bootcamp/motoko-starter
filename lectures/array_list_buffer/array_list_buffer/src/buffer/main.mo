import Buffer "mo:base/Buffer";
actor TestBuffer {
    let studentNames = Buffer.Buffer<Text>(10);

    // Add a new student
    public func joinSchool(name : Text ) : async Text {
        studentNames.add(name);
        return "Welcome to school, " # name;
    };

    // Show the content of the buffer
    public query func showStudents() : async [Text] {
        return(Buffer.toArray(studentNames));
    }; 

    // Removes a student by name
    public func removeStudent(name : Text) : async () {
        var counter : Nat = 0;
        for(nameInside in studentNames.vals()){
            if(nameInside == name){
                let removedName = studentNames.remove(counter);
            };
            counter := counter + 1;
        };
    };
};