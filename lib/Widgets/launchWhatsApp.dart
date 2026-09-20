import 'package:url_launcher/url_launcher.dart';

Future<void> launchWhatsApp({
  required String phone,
  required String message,
}) async {
  final Uri url = Uri.parse(
    "https://wa.me/$phone?text=${Uri.encodeComponent(message)}",
  );

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception("Could not launch WhatsApp");
  }
}