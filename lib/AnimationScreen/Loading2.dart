import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Loading3.dart';

class Loading2 extends StatefulWidget {
  const Loading2({super.key});

  @override
  State<Loading2> createState() => _Loading2State();
}

class _Loading2State extends State<Loading2> {

  double width = 50;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        width = 200;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Get.off(() => const Loading3(), routeName: '/Loading3');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: 4,
          width: width,
          color: Colors.blue,
        ),
      ),
    );
  }
}
