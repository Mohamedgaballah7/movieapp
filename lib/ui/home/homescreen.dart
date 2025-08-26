import 'package:flutter/material.dart';
import 'package:movieapproute/ui/home/tabs/browse/browse_tab.dart';
import 'package:movieapproute/ui/home/tabs/home/home_tab.dart';
import 'package:movieapproute/ui/home/tabs/profile/profile_tabs.dart';
import 'package:movieapproute/ui/home/tabs/search/search_tab.dart';

import '../../utils/app_colors.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectedIndex = 0;
  late double width;

  final List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        selectedItemColor: AppColors.yellowColor,
        unselectedItemColor: AppColors.whiteColor,
        backgroundColor: AppColors.greyDarkColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [

          buildBottomNavigationBarItem(
            index: 0,
            selectedIconName: Icons.home,
            unSelectedIconName: Icons.home_outlined,
            name: 'home'
          ),
          buildBottomNavigationBarItem(
            index: 1,
            selectedIconName: Icons.search,
            unSelectedIconName: Icons.search_outlined,
            name: 'search'

          ),
          buildBottomNavigationBarItem(
            index: 2,
            selectedIconName: Icons.explore,
            unSelectedIconName: Icons.explore_outlined,
            name: 'browse'
          ),
          buildBottomNavigationBarItem(
            index: 3,
            selectedIconName: Icons.person,
            unSelectedIconName: Icons.person_outline,
            name: 'profile'
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required int index,
    required String name,
    required IconData selectedIconName,
    required IconData unSelectedIconName,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        selectedIndex == index ? selectedIconName : unSelectedIconName,
        size: width * 0.055,
        color: selectedIndex == index
            ? AppColors.yellowColor
            : AppColors.whiteColor,
      ),
      label: name,

    );
  }
}
