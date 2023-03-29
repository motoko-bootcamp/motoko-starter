import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Iter "mo:base/Iter";

actor {

    type Post = {
        userPrincipal : Principal;
        title : Text;
        description : Text;
    };

    var posts = HashMap.HashMap<Nat, Post>(1, Nat.equal, Hash.hash);

    stable var postIdCount : Nat = 0;

    public func createPost (post : Post) : async () {

        //1. auth

        //2. Prepare data.
        let id : Nat = postIdCount;
        postIdCount+=1;

        //3. Create Post.
        posts.put(id, post);

        //4. return confirmation.
        ();


    };

    public query func readPost (id : Nat) : async ?Post {

        // 1. Auth

        //2. Query data.
        let postRes : ?Post = posts.get(id);

        //3. Return requested Post or null.
        postRes;

    };
    
    public query func readAllPosts () : async [(Nat, Post)] {
        //1. authenticate

        //2. Hashmap to Iter.
            let postsIter : Iter.Iter<(Nat, Post)> = posts.entries();
            
        //3. Iter to Array.
            let postsArray : [(Nat, Post)] = Iter.toArray(postsIter);

        //4. Iter to Array.
            postsArray;
    };

    public func updatePost (post : Post, id : Nat) : async Text {

        //1. auth.

        //2. Query data.
        let postRes : ?Post = posts.get(id);

        //3. Validate if exists.

        switch (postRes) {
            case (null) {
                "You're trying to update a non-existent post.";
            };
            case (?currentPost) {
        //4. Update new Post data.
                let updatedPost : Post = {
                    userPrincipal = currentPost.userPrincipal;
                    title = post.title;
                    description = post.description;
                };

        // 5. Update Post.
                posts.put(id, updatedPost);

        // 6. Return Succes.
                "Updated succesfuly!";
            };
        };
    };
 
    public func removePost (id : Nat) : async Text {
        
        //1. Auth

        //2. Query data.
        let postRes : ?Post = posts.get(id);
        
        //3. Validate if exists.
        switch (postRes) {
            case (null) {
                //3.1 Return "error".
                "You're trying to remove a non-existent post.";
            };
            case (_) {

        //5. Remove Post.
                ignore posts.remove(id);
        //6. Return Success.
                "Post has been succesfuly removed!";
            };
        };
    };
 
}
