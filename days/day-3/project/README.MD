# Motoko encyclopedia 📓
## 🧑‍🏫 Requirements 
Your task is to develop a collaborative encyclopedia or wiki for a decentralized autonomous organization DAO focused on education. This encyclopedia will be a platform for students, teachers, and the broader community to share knowledge, insights, and resources.

The encyclopedia should allow any member to contribute to the wiki, but it should also incorporate a mechanism for content moderation to ensure the accuracy and quality of the content. Finally, a reputation system will be implemented to incentivize members to contribute quality content and moderate the wiki. Members can earn reputation points for their contributions, which can be used to give them more influence in the DAO.
## 📺 Interface
```motoko
actor {
    // Contributors 
    addContributor: shared (name : Text) -> async Result.Result<(), Text>;
    getContributor: shared query (p : Principal) -> async Result.Result<Contributor, Text>;
    updateContributor: shared (name : Text) -> async Result.Result<(), Text>;
    deleteContributor: shared () -> async Result.Result<(), Text>;

    // Content
    addContent: shared (c : Content) -> async Result.Result<(), Text>;
    getContent: shared query (id : Nat) -> async Result.Result<Content, Text>;
    updateContent: shared (id : Nat, c : Content) -> async Result.Result<(), Text>;
    deleteContent: shared (id : Nat) -> async Result.Result<(), Text>;

    // Voting
    upVote: shared (id : Nat) -> async Result.Result<(), Text>;
    downVote: shared (id : Nat) -> async Result.Result<(), Text>;

    //Moderation system
    moderateContent(id : Nat, c : Content) -> async Result.Result<(), Text>;

}
```
## 📒 Steps
1. Define a new record type `Contributor`, that represents a contributor to the encyclopedia. A contributor has a `name` field of type `Text`, and a `reputation` field of type `Int` that represents the contributor's reputation.
2. Define a variable called `contributors`. This variable is a key/value store (`HashMap` or `TrieMap`)  where the keys are of type `Principal` and the values of type `Contributors`.
3. Implement `addContributor`, which accepts a name of type `Text`, adds the caller to the key/value store. All contributors start with a reputation score of 0. This function returns an error message wrapped in `Err` if the contributor is already stored.
4. Implement the query function `getContributor`, which accepts `p` of type `Principal` and returns the corresponding contributor wrapped in Ok. This function returns an error message wrapped in `Err` if the contributor doesn't exist.
5. Implement `deleteContributor`, which delete the caller from the key/value store. This function returns an error message wrapped in `Err` if the contributor is not found.
We define the type `Content` as follows:
```motoko
public type Content = {
    title : Text;
    body : Text;
    comments :  [Text];
    upvote: Nat;
    downvote: Nat;
    creator : Principal;
};
```
6. Similar to previous steps, implement `addContent`, `editContent`, `removeContent` & `getContent`. In step 6, only the creator of a content is able to modify it. 
7. Implement `upVote`, which accepts an `id` of type `Nat` and adds one upvote to the content and one reputation points to the contributor who added the corresponding content. The function should return a value of type `Result.Result<(), Text>` that corresponds to an error message if the `id` is invalid.
8. Implement `downVote`, which accepts an `id` of type `Nat` and add one downvote to the content and remove one reputation points to the contributor who added the corresponding content. The function should return a value of type `Result.Result<(), Text>` that corresponds to an error message if the `id` is invalid.
9. Implement `moderateContent`, which accepts a tupple composed of `id` of type `Nat` and `c` of type `Content`. This function will perfom two checks:
- Has the content more downvotes than upvotes?
- Has the creator of this content less reputation point that the caller? 
If both checks are passed, then the content can be replaced by the new one. In other cases, this function returns an adapted error message wrapped in `Err`.
10. Implement the necessary code in `pre_upgrade` and `post_upgrade` to retain the state of this canister through upgrades.
## Verification
WIP


