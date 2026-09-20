import 'package:bidding_user/CarsListScreens.dart';
import 'package:bidding_user/Screens/MyBidsScreens.dart';
import 'package:bidding_user/Screens/ProfileScreen.dart';
import 'package:flutter/material.dart';

class Bottemnevigatonscreen extends StatefulWidget {
  const Bottemnevigatonscreen({super.key});

  @override
  State<Bottemnevigatonscreen> createState() => _BottemnevigatonscreenState();
}

class _BottemnevigatonscreenState extends State<Bottemnevigatonscreen> {
  int currentIndex = 1;
  List<Widget> pages = [
    Mybidsscreens(),
    const Carslistscreens(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: currentIndex,
          children: pages,
        ),

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            // Use Image.asset instead of Icon
            icon: Image.asset(
              'assets/judge.png',
              width: 50, // Standard navigation icon size
              height: 40,
            ),
            label: 'Bids',
          ),
          BottomNavigationBarItem(
            // Use Image.asset instead of Icon
            icon: Image.asset(
              'assets/Frame 74.png',
              width: 70, // Standard navigation icon size
              height: 40,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            // Use Image.asset instead of Icon
            icon: Image.asset(
              'assets/category-2.png',
              width: 50, // Standard navigation icon size
              height: 40,
            ),
            label: 'Account',
          ),
        ],
      )
    );
  }
}
