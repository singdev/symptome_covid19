
import 'package:symptomecovid19/share/entity/symptom.dart';

class Tracking {
  final DateTime firstDate;
  final List<Symptom> days;
  final String id;

  Tracking({this.firstDate, this.days, this.id});

  factory Tracking.fromJson(Map<String, dynamic> map){
    return Tracking(
      firstDate: DateTime.parse(map["firstDate"]),
      days: List.generate((map["days"].length), (index) => Symptom.fromJson(map["days"][index])),
      id: map["_id"]
    );
  }

  Map<String, dynamic> toJson() => {
     "firstDate": this.firstDate,
     "_id": this.id,
     "days": this.days
  };
}