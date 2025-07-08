import 'package:flutter/material.dart';
import 'package:foodcourt/utils/sharedpreference_utils.dart';



class CitiesProvider extends ChangeNotifier {
  PreferencesUtil preferencesUtil = PreferencesUtil();
  List<String> _selectedCities = ['Lagos', 'Abuja', 'Port Harcourt'];


  CitiesProvider() {
    _initPrefs();
  }
  List<String> get cities => _selectedCities;


  Future<void> _initPrefs() async {
    await preferencesUtil.init();
    _loadFromPrefs();
  }


  Future<void> _loadFromPrefs() async {
    // Only load if values exists,
    List<String>? loadCities = preferencesUtil.getCities('cities');
    if (loadCities != null) {
      _selectedCities = loadCities;
    }
    notifyListeners();
  }

  void addCity(String city) {
    if (!_selectedCities.contains(city)) {
      _selectedCities.add(city);
      _saveToPrefs();
      notifyListeners();
    }
  }

  void removeCity(String city){
    if(_selectedCities.contains(city)){
      _selectedCities.remove(city);
      _saveToPrefs();
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs() async {
    await preferencesUtil.setCities('cities', _selectedCities);
  }


}
