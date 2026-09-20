import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Loading2.dart';

class Loading1 extends StatefulWidget {
  const Loading1({super.key});

  @override
  State<Loading1> createState() => _Loading1State();
}

class _Loading1State extends State<Loading1> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Get.off(() => const Loading2(), routeName: '/Loading2');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
