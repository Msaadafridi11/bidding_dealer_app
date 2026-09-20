import 'package:bidding_user/Screens/LanguageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'path_to_your_controller.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  final controller = Get.put(LanguageController());

  final List<Map<String, String>> langList = [
    {'name': 'English', 'flag': '🇺🇸', 'code': 'en', 'country': 'US'},
    {'name': 'Arabic', 'flag': '🇦🇪', 'code': 'ar', 'country': 'SA'}, // ar_SA matches your MyTranslations
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            const SizedBox(height: 20),

            // Language Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Obx(() => Column(
                  children: langList.map((lang) {
                    bool isSelected = controller.selectedLanguage.value == lang['name'];
                    return _buildLangItem(lang, isSelected);
                  }).toList(),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            style: IconButton.styleFrom(backgroundColor: Colors.white),
          ),
          Expanded(
            child: Center(
              child: Text('language'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 45),
        ],
      ),
    );
  }

  Widget _buildLangItem(Map<String, String> lang, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.changeLanguage(lang['name']!, lang['code']!, lang['country']!),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E88E5) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(lang['flag']!, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 15),
            Text(
              lang['name']!,
              style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
              ),
            ),
          ],
        ),
      ),
    );
  }
}