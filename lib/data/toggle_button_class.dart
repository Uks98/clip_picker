import 'package:shared_preferences/shared_preferences.dart';

class Toggles{

  bool switchControl = false;
  var textHolder = 'OFF';

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);
    print('Switch Value saved $value');
    return prefs.setBool("switchState", value);
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitchedFT = prefs.getBool("switchState") ?? false;
    print("${isSwitchedFT}입니다");
    return isSwitchedFT;
  }


  Future<bool> saveSwitchStateLn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState2", value);
    print('Switch Value saved $value');
    return prefs.setBool("switchState2", value);
  }

  Future<bool> getSwitchStateLn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitchedFT = prefs.getBool("switchState2") ?? false;
    print("${isSwitchedFT}입니다");
    return isSwitchedFT;
  }
}