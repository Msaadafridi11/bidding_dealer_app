import 'package:bidding_user/Models/item_model.dart';
import 'package:bidding_user/Widgets/launchWhatsApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WinnerScreen extends StatelessWidget {
  final ItemModel itemData; // Pura data yahan receive ho raha hai

  const WinnerScreen({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            // Celebration Icon
            const Icon(Icons.stars, size: 100, color: Colors.orange),
            const SizedBox(height: 20),

            const Text(
              "CONGRATULATIONS!",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),

            const SizedBox(height: 10),

            Text(
              "You have won the bid for",
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),

            // Item Title
            Text(
              itemData.title ?? "Unknown Car",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Winning Amount Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.green),
              ),
              child: Column(
                children: [
                  const Text("Your Winning Bid"),
                  Text(
                    "\$${itemData.currentBid}",
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Admin Instruction Message
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Our Admin team will contact you within 24 hours for the payment and delivery process.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),

            const SizedBox(height: 30),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),                      
                      onPressed: () {
                        launchWhatsApp(
                          phone: "923439798710",
                          message:
                          "Hello Admin! I have successfully won the auction for ${itemData.title}. My winning bid is \$${itemData.currentBid}. Please guide me on next steps.",
                        );
                      },
                      icon: const Icon(Icons.phone, color: Colors.white),
                      label: const Text("Contact Admin",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),

            TextButton(
              onPressed: () =>Get.back(),
              child: const Text("Go Back to Home"),
            )
          ],
        ),
      ),
    ),
  ),
);
  }
}
