/*
{
  id: "",
  eventName: "",
  imageId: "",
  url: "",
  price: "",
  eventDate: "",
  identification: "",
}
*/

class ServiceTypeModel {
  String id;
  String name;
  int price;

  ServiceTypeModel(this.id, this.name, this.price);

  factory ServiceTypeModel.fromMap(Map<String, dynamic> json) {
    return ServiceTypeModel(
      json["id"],
      json["name"],
      int.parse(json["price"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };

  //serialization
  @override
  String toString() {
    return "{id: $id, name: $name, price: $price}";
  }
}
