import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {

  static late SharedPreferences _sharedPreferences;
  static PreferencesUtil? _currentInstance;
  PreferencesUtil._internal();

  factory PreferencesUtil(){
    _currentInstance = _currentInstance ?? PreferencesUtil._internal();

    return _currentInstance!;
  }

  Future<void> init() async{
    _sharedPreferences=await SharedPreferences.getInstance();//too get the instance
  }

  Future<bool> setCities (String key, List<String> value) async{
    return await _sharedPreferences.setStringList(key, value);

  }

  List<String>? getCities(String key){
    return _sharedPreferences.getStringList(key);
  }


}