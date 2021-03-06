import 'dart:convert';

import 'package:symptomecovid19/share/entity/symptom.dart';
import 'package:symptomecovid19/share/entity/tracking.dart';
import 'package:http/http.dart' as http;

class TrackingRepository {
  final String url = "http://54.38.190.167:20201";


  Future<Tracking> createTracking({ String token }) async {
    final response = await http.post("$url/tracking", headers: {
      "Content-Type": "Application/json",
      "Authorization": "Bearer " + token
    }, body: jsonEncode({}));

    if (response.statusCode == 200) {
      return Tracking.fromJson(jsonDecode(response.body)["newTracking"]);
    } else {
      throw new Exception(response.body);
    }
  }

  Future<Tracking> getTracking({ String token, String id }) async {
    final response = await http.get("$url/tracking/$id", headers: {
      "Content-Type": "Application/json",
      "Authorization": "Bearer " + token
    });

    if (response.statusCode == 200) {
      return Tracking.fromJson(jsonDecode(response.body));
    } else {
      throw new Exception(response.body);
    }
  }

  Future<List<Tracking>> getAllTracking({ String token }) async {
    final response = await http.get("$url/tracking/search/by-user", headers: {
      "Content-Type": "Application/json",
      "Authorization": "Bearer " + token
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return List.generate(responseData.length,
              (index) => Tracking.fromJson(responseData[index]));
    } else {
      throw new Exception(response.body);
    }
  }

  Future<Tracking> updateSymptomForCurrentDay(
      { String token, String id, Symptom symptom}) async {
    final response = await http.put("$url/tracking/$id", headers: {
      "Content-Type": "Application/json",
      "Authorization": "Bearer " + token
    }, body: jsonEncode(symptom.toJson()));

    if (response.statusCode == 200) {
      return Tracking.fromJson(jsonDecode(response.body));
    } else {
      throw new Exception(response.body);
    }
  }
}