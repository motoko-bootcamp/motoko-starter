# Homework diary 📔
## 🧑‍🏫 Requirements 
Your task is to create a collaborative homework diary. The homework diary will allow students to create, edit, delete, and view their homework tasks.
## 📺 Interface
```motoko
actor {
    // Add a new homework task
    addHomework: shared (title: Text, description: Text, dueDate: Int) -> async Nat;

    // Get a specific homework task by id
    getHomework: shared query (id: Nat) -> async Result.Result<Homework, Text>;

    // Update a homework task's title, description, and/or due date
    updateHomework: shared (id: Nat, title: Text, description: Text, dueDate: Int) -> async Result.Result<(), Text>;

    // Mark a homework task as completed or not completed
    setCompleted: shared (id: Nat, completed: Bool) -> async Result.Result<(), Text>;

    // Delete a homework task by id
    deleteHomework: shared (id: Nat) -> async Result.Result<(), Text>;

    // Get the list of all homework tasks
    getAllHomework: shared query () -> async [Homework];

    // Get the list of pending (not completed) homework tasks
    getPendingHomework: shared query () -> async [Homework];

    // Search for homework tasks based on a search terms
    searchHomework: shared query (searchTerm: Text) -> async [Homework];
}
```
## 📒 Steps
We import the type `Time` for the `Time` library. 
1. Define a record type `Homework` that represents a homework task. A Homework has a title field of type `Text`, a description field of type `Text`, a dueDate field of type `Time`, and a completed field of type `Bool`.
2. Define a variable called `homeworkDiary` that will be used to store the homework tasks. Use a suitable data structure (such as `Buffer` or `Array`) for this variable.
3. Implement `createHomework`, which accepts a homework of type `Homework`, adds the homework to the `homeworkDiary`, and returns the id of the homework. The id should correspond to the index of the homework in `homeworkDiary`.
4. Implement `getHomework`, which accepts a homeworkId of type Nat, and returns the corresponding homework wrapped in an Ok result. If the homeworkId is invalid, the function should return an error message wrapped in an `Err` result.
5. Implement `updateHomework`, which accepts a homeworkId of type `Nat` and a homework of type `Homework`, updates the corresponding homework in `homeworkDiary`, and returns a unit value wrapped in an `Ok` result. If the homeworkId is invalid, the function should return an error message wrapped in an `Err` result.
6. Implement `deleteHomework`, which accepts a `homeworkId` of type `Nat`, removes the corresponding homework from the `homeworkDiary`, and returns a unit value wrapped in an `Ok` result. If the `homeworkId` is invalid, the function should return an error message wrapped in an `Err` result.
7. Implement `getAllHomework`, which returns the list of all homework tasks in `homeworkDiary`.
8. Implement `markAsComplete`, which accepts a homeworkId of type `Nat`, updates the completed field of the corresponding homework to `true`, and returns a unit value wrapped in an `Ok result`. If the homeworkId is invalid, the function should return an error message wrapped in an Err result.
9. Implement a `getPendingHomework` query function that returns the list of all pending (not completed) homework tasks in `homeworkDiary`. This function should filter the tasks based on their completed field.
10. Implement a `searchHomework` query function that accepts a `searchTerm` of type `Text` and returns a list of homework tasks that have the given `searchTerm` in their `title` or `description`.
