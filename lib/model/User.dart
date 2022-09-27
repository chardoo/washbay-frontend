class UserModel {
  String id = '';
  String name = "";
  String contact = "";
  String password = "";

  UserModel(this.id, this.name, this.contact);

  UserModel.empty() {
    id = '';
    name = "";
    contact = "";
  }

  //deserialization
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json["name"] as String,
      json["contact"] as String,
      json["password"] as String,
    );
  }
  factory UserModel.fromJson1(Map<String, dynamic> json) {
    return UserModel(
      json["id"] as String,
      json["name"] as String,
      json["contact"] as String,
    );
  }

  factory UserModel.fromJson2(Map<String, dynamic> json) {
    return UserModel(
      json["user"]["id"] as String,
      json["user"]["name"] as String,
      json["user"]["contact"] as String,
    );
  }
  //serialization
  Map<String, dynamic> toJson() {
    var map = {
      "id": name,
      "name": contact,
      "contact": password,
    };
    return map;
  }
}
