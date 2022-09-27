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

class Event {
  final String eventName;
  final String eventDate;

  Event(this.eventName, this.eventDate);

  //deserialization
  factory Event.fromMap(Map<String, dynamic> json) {
    return Event(
      json["eventName"],
      json["eventDate"],
    );
  }
  Map<String, dynamic> toJson() => {
        "eventName": eventName,
        "eventDate": eventDate,
      };

  String geteventName() {
    return eventName;
  }

  // String dateskds() {
  //  DateTime dt =  DateTime.parse(eventDate);

  // }

  //serialization
  @override
  String toString() {
    return ' $eventName ';
  }
}
