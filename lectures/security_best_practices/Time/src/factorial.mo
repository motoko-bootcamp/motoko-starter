import Int "mo:base/Int";

actor Factorial {

  public shared func computation(n : Int) : async Int {

    func recurse(n : Int) : Int {
      if (n == 0) {
        return 1;
      } else {
        return n * recurse(n - 1);
      };
    };
    
    return recurse(n);
  };

}