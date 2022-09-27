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

class DashboardModel {
  int customers = 0;
  int serviceType = 0;
  int service = 0;

  DashboardModel({
    required this.customers,
    required this.serviceType,
    required this.service,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      customers: json["customers"] as int,
      serviceType: json["serviceType"] as int,
      service: int.parse(json["service"]),
    );
  }

  Map<String, dynamic> toJson() {
    var map = {
      "customers": customers,
      "serviceType": serviceType,
      "service": service,
    };
    return map;
  }

  @override
  String toString() {
    return "customers; $customers";
  }
}
