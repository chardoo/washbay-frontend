class LoginResponseObject {
  String id = "";
  String name = "";
  String email = "";
  String role = "";
  String token = "";
  bool isValid = false;

  String expiration = "";

  LoginResponseObject(this.id, this.email, this.name, this.role,
       this.token, this.expiration, this.isValid);

  LoginResponseObject.empty() {
    id = "";
    email = "";
    name = "";
    role = "";
    token = "";
    expiration = "";
    isValid = false;
  }

  //deserialization
  factory LoginResponseObject.fromJson(Map<String, dynamic> json) {
    return LoginResponseObject(
      json["id"] as String,
      json["email"] as String,
      json["name"] as String,
      json["role"] as String,
      json["token"] as String,
      json["expiration"] as String,
      json["isValid"] as bool,
    );
  }

  //serialization
  Map<String, dynamic> toJson() {
    var map = {
      "id": id,
      "email": email,
      "name": name,
      "role": role,
      "token": token,
      "expiration": expiration,
      "isValid": isValid,
    };
    return map;
  }

  @override
  String toString() {
    return "LoginResponseObject = [ id: $id, email: $email, role: $role, token: $token "
        "name: $name , expiration: $expiration, isValid: $isValid]";
  }
}
