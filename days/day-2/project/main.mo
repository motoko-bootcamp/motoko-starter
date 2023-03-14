import Nat "mo:base/Nat";
import Buffer "mo:base/Buffer";
actor StudentWall {

    public type Content =  {
        #Text: Text;
        #Image: Blob;
    };

    public type Message = {
        id: Nat;
        content: Content;
    };

    let wall : Buffer.Buffer<Message> = Buffer.Buffer<Message>(10);



};