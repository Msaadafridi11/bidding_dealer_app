import 'package:flutter/material.dart';

class Auctionstatusbadgescreen extends StatelessWidget {
  const Auctionstatusbadgescreen({super.key, required this.isLive});
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isLive ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isLive ? 'LIVE' : 'EXPIRED',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
