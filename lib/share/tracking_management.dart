
import 'package:shared_preferences/shared_preferences.dart';

class TrackingManager {

  static const String TRACKING_DAY = "symptome_covid_tracking_day";
  static const String TRACKING_ID = "symptome_covid_tracking_id";

  Future<String> getCurrentTrackingId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(TRACKING_ID);
  }

  Future<void> persistTrackingId({ String id}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(TRACKING_ID, id);
  }

  Future<void> removeTrackingData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(TRACKING_ID);
  }

  Future<bool> onTracking() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(TRACKING_ID);
  }
}