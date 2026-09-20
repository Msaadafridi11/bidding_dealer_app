// import 'package:bidding_user/FalterScreen/AllCarsScree.dart';
// import 'package:bidding_user/FalterScreen/ExpiredCarsScreen.dart';
// import 'package:bidding_user/FalterScreen/LiveCarsScreen.dart';
// import 'package:flutter/material.dart';
//
// class Carslistscreens extends StatefulWidget {
//   const Carslistscreens({super.key});
//   @override
//   State<Carslistscreens> createState() => _CarslistscreensState();
// }
//
// class _CarslistscreensState extends State<Carslistscreens>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _currentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//
//     _tabController.addListener(() {
//       if (!_tabController.indexIsChanging) {
//         setState(() {
//           _currentIndex = _tabController.index;
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(45),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Container(
//               height: 45,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicator: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.black,
//                 dividerColor: Colors.transparent,
//                 tabs: const [
//                   SizedBox(height: 45, width: 80, child: Tab(text: 'All')),
//                   SizedBox(height: 45, width: 80, child: Tab(text: 'Live')),
//                   SizedBox(height: 45, width: 80, child: Tab(text: 'Expired')),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       //IndexedStack here
//       body: IndexedStack(
//         index: _currentIndex,
//         children: [
//           Allcarsscree(),
//           const LiveCarsScreen(),
//           const Expiredcarsscreen(),
//         ],
//       ),
//     );
//   }
// }

import 'package:bidding_user/FalterScreen/AllCarsScree.dart';
import 'package:bidding_user/FalterScreen/ExpiredCarsScreen.dart';
import 'package:bidding_user/FalterScreen/LiveCarsScreen.dart';
import 'package:flutter/material.dart';

class Carslistscreens extends StatefulWidget {
  const Carslistscreens({super.key});

  @override
  State<Carslistscreens> createState() => _CarslistscreensState();
}

class _CarslistscreensState extends State<Carslistscreens>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                dividerColor: Colors.transparent,
                tabs: const [
                  SizedBox(height: 45, width: 80, child: Tab(text: 'All')),
                  SizedBox(height: 45, width: 80, child: Tab(text: 'Live')),
                  SizedBox(height: 45, width: 80, child: Tab(text: 'Expired')),
                ],
              ),
            ),
          ),
        ),
      ),

      /// 🔥 TabBarView instead of IndexedStack
      body: TabBarView(
        controller: _tabController,
        children: const [
          Allcarsscree(),
          LiveCarsScreen(),
          Expiredcarsscreen(),
        ],
      ),
    );
  }
}

