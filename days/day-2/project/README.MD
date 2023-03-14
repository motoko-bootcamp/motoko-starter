# Student wall 🎨
## 🧑‍🏫 Requirements 
Your task is to develop the code for a student wall, implemented as a canister - a digital platform that will revolutionize how students communicate and stay informed about events, clubs, and activities in the school community. <br/>
Imagine a dynamic and interactive space where students can share their thoughts, ideas, and upcoming events with each other.
This wall will be the go-to destination for students looking to get the latest scoop on what's happening in the school community. 
## 📺 Interface
Your canister should implement the following interface:
```motoko
actor {
    write: shared (c : Content) -> async Nat;
    clean: shared (messageId : Nat) -> async Result.Result<(), Text>;
    vote: shared (messageId : Nat, answerId : Nat) -> async Result.Result<(), Text>;
    getMessage: shared query (messageId : Nat) -> async Result.Result<Message, Text>;
    getAllMessages : shared query () -> async [Message];
    getAllImages : shared query () -> async [Blob];
    getAllSurveys : shared query () -> async [Survey];
};
```
## 📒 Steps
We define a variant type called `Content` that represents the content of messages that can be published on the wall.
```motoko
public type Content = {
    #Text: Text;
    #Image: Blob;
};
```
1. Define a new record type called `Message`. A message of type `Message` contains a field `id` of type `Nat` and a field `content` of type `Content`. 
2. Define a variable called `wall` of type `Buffer` that will be used for storing messages.
3. Implement `write`, which accepts a content `c` of type `Content`, creates a message from the content, adds the message to the wall and returns the id of the message. The id of the message should corresponds to the index of the message in `wall`. 
4. Implement `clean`, which accepts an id of type `Nat` and removes the corresponding message from the wall. `clean` will returns a value of type `Result.Result<(),Text>` that corresponds to an error message if the message corresponding to the id doesn't exist.  

We define new types:
- `Answer` is a tupple type that represents a choice in a survey. Each answer contains a `Text` field that describes the answer, and a var Nat field that represents the number of times the answer has been selected by respondents. 
```motoko
type Answer = (Text, var Nat);
``` 
- `Survey` is a record type that represents a survey. Each survey contains a `title` field that describes the survey, and a `answers` field that is an array of `Answer` objects, each representing a possible answer in the survey.
```motoko
type Survey = {
    title : Text;
    answers : [Answer];
};
``` 
5. Modify the variant type `Content` to include `Survey`. 
6. Implement `vote`, which accepts `messageId` of type `Nat` and `answerId` of type `Nat`, and updates the corresponding answer `count` in the survey associated with the message. This function will return a value of type `Result.Result<(), Text>` that corresponds to an error message if either the `messageId` or `answerId` is invalid.
7. Implement the query function `getMessage`, which accepts `messageId` of type `Nat` and returns the message wrapped in an `Ok` result. If the `messageId` is invalid, the function should return an error message wrapped in an Err result.
8. Implement the query function `getAllMessages`, which returns the list of all messages. 
9. Implement the query function `getAllImages`, which returns the list of all images that have been added to the wall. 
10. Implement the query function `getAllSurveys`, which returns the list of all surveys that have been added to the wall. To accomplish this, you can iterate over all the messages on the wall and add any surveys to a new list. Then, return this list of surveys.

## Verification
WIP
