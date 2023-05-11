# Homework diary 📔
On the second day at school, you and your classmates find yourselves diving into your first collaborative assignment. Though working together is stimulating, the challenge of managing responsibilities and progress for each team member becomes quickly apparent... 😩 <br/>

During a lunch break, your group brainstorms solutions for a better system to organize the tasks and assignments. <br/>

One of your classmates proposes the idea of creating a homework diary on the famous **Joogle Cloud**, where each member can update tasks and monitor progress. The group quickly agrees and starts building the diary. As you observe the project taking shape, you notice a sly smile forming on the face of one student. 😼 <br/>

The next day, you discover that this cunning student has exploited their access to the API keys, altering the diary to mark all their homework as completed. 🫢 <br/>

Shocked and disappointment spread through the group, and you realize that the centralized solution has failed to provide the transparency and security you all craved for. 

Determined to find a better way, the group gathers once more, and you share the idea of building the collaborative homework diary on the **Internet Computer**. <br/>
Your classmates' eyes light up as they understand the potential of a decentralized platform to foster transparency, unity, and trust among your classmates. 🫂
## 🧑‍🏫 Requirements 
Your task is to create a collaborative homework diary, implement as a canister. The homework diary will allow students to create, edit, delete, and view their homework tasks.
## 📒 Steps
0. Import the type `Time` for the `Time` library.
1. Define a record type `Homework` that represents a homework task. A Homework has a title field of type `Text`, a description field of type `Text`, a dueDate field of type `Time`, and a completed field of type `Bool`.
2. Define a variable called `homeworkDiary` that will be used to store the homework tasks. Use a suitable data structure (such as `Buffer` or `Array`) for this variable.
3. Implement `addHomework`, which accepts a homework of type `Homework`, adds the homework to the `homeworkDiary`, and returns the id of the homework. The id should correspond to the index of the homework in `homeworkDiary`.
```motoko
addHomework: shared (homework: Homework) -> async Nat;
```
4. Implement `getHomework`, which accepts a homeworkId of type `Nat`, and returns the corresponding homework wrapped in an Ok result. 
If the homeworkId is invalid, the function should return an error message wrapped in an `Err` result.
```motoko
getHomework: shared query (id: Nat) -> async Result.Result<Homework, Text>;
```
5. Implement `updateHomework`, which accepts a homeworkId of type `Nat` and a homework of type `Homework`, updates the corresponding homework in `homeworkDiary`, and returns a unit value wrapped in an `Ok` result. If the homeworkId is invalid, the function should return an error message wrapped in an `Err` result.
```motoko
updateHomework: shared (id: Nat, homework: Homework) -> async Result.Result<(), Text>;
```
6. Implement `markAsComplete`, which accepts a homeworkId of type `Nat` and updates the completed field of the corresponding homework to `true`, and returns a unit value wrapped in an `Ok` result. If the `homeworkId` is invalid, the function should return an error message wrapped in an `Err` result.
```motoko
markAsCompleted: shared (id: Nat) -> async Result.Result<(), Text>;
```
7. Implement `deleteHomework`, which accepts a `homeworkId` of type `Nat`, removes the corresponding homework from the `homeworkDiary`, and returns a unit value wrapped in an `Ok` result. If the `homeworkId` is invalid, the function should return an error message wrapped in an `Err` result.
```motoko
deleteHomework: shared (id: Nat) -> async Result.Result<(), Text>;
```
8. Implement `getAllHomework`, which returns the list of all homework tasks in `homeworkDiary`.
```motoko
getAllHomework: shared query () -> async [Homework];
```
9. Implement `getPendingHomework` which returns the list of all uncompleted homework tasks in `homeworkDiary`.
```motoko
getPendingHomework: shared query () -> async [Homework];
```
10. Implement a `searchHomework` query function that accepts a `searchTerm` of type `Text` and returns a list of homework tasks that have the given `searchTerm` in their title or description.
```motoko
searchHomework: shared query (searchTerm: Text) -> async [Homework];
```
11. Deploy the howework diary on the Internet Computer.
## 📺 Interface
> At the end of the project, your canister should implement the following interface.
```motoko
actor {
    // Add a new homework task
    addHomework: shared (homework: Homework) -> async Nat;

    // Get a specific homework task by id
    getHomework: shared query (id: Nat) -> async Result.Result<Homework, Text>;

    // Update a homework task's title, description, and/or due date
    updateHomework: shared (id: Nat, homework: Homework) -> async Result.Result<(), Text>;

    // Mark a homework task as completed 
    markAsCompleted: shared (id: Nat) -> async Result.Result<(), Text>;

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
