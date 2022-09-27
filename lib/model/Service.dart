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

class Service {
  late String id;
  late String userId;
  late  String serviceTypeId;
  late  int amount;
  late int balance;

  Service(this.id, this.userId, this.serviceTypeId, this.amount, this.balance);
  
  factory Service.fromMap(Map<String, dynamic> json) {
    return Service(
      json["id"],
      json["userId"],
      json["serviceTypeId"],
      int.parse(json["amount"]),
      int.parse(json["balance"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "serviceTypeId": serviceTypeId,
        "amount": amount,
        "balance": balance,
      };

  //serialization
  @override
  String toString() {
    return "{ id: $id, userId: $userId, serviceTypeId: $serviceTypeId,  amount: $amount  "
        "balance: $balance, }";
  }
}
