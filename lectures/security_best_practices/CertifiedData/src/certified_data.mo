import CertifiedData "mo:base/CertifiedData";
import Text "mo:base/Text";
import Int "mo:base/Int";

actor Counter {

  type CertifiedCounter = {
    certificate : ?Blob;
    value : Int;
  };

  var count : Int = 0;

  public shared query func val() : async CertifiedCounter {

    let validation : CertifiedCounter = {
      certificate = CertifiedData.getCertificate();
      value = count;
    };
    return validation;
  };

  public func inc() : async Int {
    count += 1;

    let blob_temp : Blob = Text.encodeUtf8(Int.toText(count));
    CertifiedData.set(blob_temp);

    return count;
  
  };

};
