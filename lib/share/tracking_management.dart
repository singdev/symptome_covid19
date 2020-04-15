
import 'package:shared_preferences/shared_preferences.dart';

class TrackingManager {

  static const String TRACKING_DAY = "symptome_covid_tracking_day";
  static const String TRACKING_ID = "symptome_covid_tracking_id";

  Future<String> getCurrentTrackingId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(TRACKING_ID);
  }

  Future<int> getCurrentTrackingDay() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(TRACKING_DAY);
  }

  Future<void> persistTrackingId({ String id}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(TRACKING_ID, id);
  }

  Future<void> persistCurrentTrackingDay({ String day}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(TRACKING_DAY, day);
  }

  Future<void> removeTrackingData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(TRACKING_ID);
    sharedPreferences.remove(TRACKING_DAY);
  }

  Future<bool> onTracking() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(TRACKING_ID) &&
        sharedPreferences.containsKey(TRACKING_DAY);
  }
}