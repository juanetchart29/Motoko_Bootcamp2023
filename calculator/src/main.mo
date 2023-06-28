import Nat "mo:base/Nat";
import Float "mo:base/Float";

actor {
  var counter: Float = 0;
  
  public func add(valor_x:Float) : async Float {
    counter := counter + valor_x;
    return counter;
  };
  public func sub(valor_x:Float) : async Float {
    counter := counter - valor_x;
    return counter;
  };
  public func mul(valor_x:Float) : async Float {
    counter := counter * valor_x;
    return counter;
  };
  public func reset() : async Float {
    counter := 0;
    return counter;
  };
  public func div(valor_x:Float) : async Float {
    if (valor_x != 0){
      counter := counter / valor_x;
    };
    return counter;
  };
  public func see() : async Float {
    return counter;
  };
  public func power(valor_x:Float) : async Float {
    counter := counter**valor_x;
    return counter;
  };
  public func sqrt() : async Float {
    counter := Float.sqrt (counter);
    return counter
  };
  public func floor() : async Float {
    counter := Float.floor (counter);
    return counter
  };
  public func suma(n1:Float,n2:Float) : async Float{
    return n1 + n2;
  }
}; 
