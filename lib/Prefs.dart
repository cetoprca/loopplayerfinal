import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences{

  static late final SharedPreferences prefs;
  static bool isLoading = true;

  Future<void> initPrefs() async{
    prefs = await SharedPreferences.getInstance();
    isLoading = false;
  }
}