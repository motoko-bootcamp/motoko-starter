# Student wall 🎨
It was your third day at Motoko School, and you were determined to start making some good friends. <br/>
Being a big fan of music, you thought organizing a little music concert could be a great way to meet other like-minded students. 🎶

As you wandered the halls during lunchtime, you overheard two students discussing how they wished there was a better way to stay informed about school events and activities. They complained about how they had missed out on attending the previous year's [ICP Community Conference](https://twitter.com/icp_cc) because they weren't aware of it in time, and how they were determined not to let that happen again this year. 💪

This sparked an idea in your mind.  <br/>

What if you could create a digital platform where students share upcoming events and activities. It would be the perfect way to advertise your music concert and help other students stay informed about everything happening on campus. 📅

You quickly shared your idea with the two students and they loved it. They introduced you to a few others who were also interested in the idea, and before you knew it, you had a group of motivated students ready to bring your idea to life. 🚀

You all gathered in the computer lab and began brainstorming the features of your student wall. You wanted it to be more than just a bulletin board, so you came up with the idea to include images and surveys as well. You divided the work and got started coding.
## 🧑‍🏫 Requirements 
Your task is to develop the code for a student wall, implemented as a canister - a digital platform that will revolutionize how students communicate and stay informed about events, clubs, and activities in the community. Imagine a dynamic and interactive space where students can share their thoughts, ideas, and upcoming events with each other. 
This wall will be the go-to destination for students looking to get the latest scoop on what's happening in the school. 
## 📺 Interface
Your canister should implement the following interface:
```motoko
actor {
   
    // Add a new message to the wall
    writeMessage: shared (c : Content) -> async Nat;

    //Get a specific message by ID
    getMessage: shared query (messageId : Nat) -> async Result.Result<Message, Text>;

    // Update the content for a specific message by ID
    updateMessage: shared (messageId : Nat, c : Content) -> async Result.Result<(), Text>;

    //Delete a specific message by ID
    deleteMessage: shared (messageId : Nat) -> async Result.Result<(), Text>;

    // Voting
    upVote: shared (messageId  : Nat) -> async Result.Result<(), Text>;
    downVote: shared (messageId  : Nat) -> async Result.Result<(), Text>;

    //Get all messages
    getAllMessages : query () -> async [Message];

    //Get all messages
    getAllMessagesRanked : query () -> async [Message];
};
```
## 📒 Steps
We define a variant type called `Content` that represents the type of content of the messages that can be published on the wall.
```motoko
public type Content = {
    #Text: Text;
    #Image: Blob;
    #Video: Blob;
};
```
1. Define a new record type called `Message`. A message of type `Message` contains a field `vote` of type `Int`, a field `content` of type `Content` and a field `creator` of type `Principal` that represents the creator of the message.
2. Define a variable called `messageId` that serves as a continuously increasing counter, maintaining a record of the total number of messages posted.
3. Create a variable named `wall`, which is a `HashMap` designed to store messages. In this wall, the keys are of type `Nat` and represents message IDs, whereas the values are of type `Message`. 
4. Implement `writeMessage`, which accepts a content `c` of type `Content`, creates a message from the content, adds the message to the wall and returns the id of the message.
5. Implement `getMessage`, which accepts an `messageId` of type `Nat` and returns the corresponding message wrapped in an `Ok` result. If the `messageId` is invalid, the function should return an error message wrapped in an `Err` result.
6. Implement `updateMessage`, which accepts a `messageId` of type `Nat` and a concent `c` of type `Content` and updates the content of the corresponding message. This should only work if the caller is the `creator` of the message. If `messageId` is invalid or the caller is not the `creator` the function should return an error message wrapped in an `Err` result. If everything works, and the message is updated the function should return a simple unit value wrapped in an `Ok` result.
7. Implement `deleteMessage`, which accepts a `messageId` of type `Nat`, removes the corresponding message from the `wall`, and returns a unit value wrapped in an `Ok` result. If the `homeworkId` is invalid, the function should return an error message wrapped in an `Err` result.
8. Implement `upVote`, which accepts a `messageId` of type `Nat` and adds one vote to the message and returns a unit value wrapped in an `Ok` result. If the `messageId` is invalid, the function should return an error message wrapped in an `Err` result.
9. Implement `downVote`, which accepts a `messageId` of type `Nat` and removes one vote to the message and returns a unit value wrapped in an `Ok` result. If the `messageId` is invalid, the function should return an error message wrapped in an `Err` result.
10. Implement the query function `getAllMessages`, which returns the list of all messages. 
11. Implement the query function `getAllMessagesRanked`, which returns the list of all messages, where each message are ordered by the number of votes. The first message in the list should be the message with the most votes.
12. Deploy the student Wall on the Internet Computer.
13. (Bonus step) Build a frontend for the wall and integrate Internet Identity to authenticate users posting on the wall.

