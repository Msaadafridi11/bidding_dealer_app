import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var selectedLanguage = 'English'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage(); // App khulte hi purani setting load karein
  }

  // Language change aur save karne ka function
  void changeLanguage(String name, String code, String country) async {
    selectedLanguage.value = name;

    // Locale update karein
    var locale = Locale(code, country);
    Get.updateLocale(locale);

    // Memory mein save karein taake restart par yaad rahe
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('langCode', code);
    await prefs.setString('countryCode', country);
    await prefs.setString('langName', name);
  }

  // Save ki hui language load karne ka function
  void loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('langCode');
    String? countryCode = prefs.getString('countryCode');
    String? langName = prefs.getString('langName');

    if (langCode != null && countryCode != null) {
      Get.updateLocale(Locale(langCode, countryCode));
      selectedLanguage.value = langName ?? 'English';
    }
  }
}