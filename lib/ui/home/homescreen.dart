import 'package:flutter/material.dart';
import 'package:movieapproute/ui/home/tabs/browse/browse_tab.dart';
import 'package:movieapproute/ui/home/tabs/home/home_tab.dart';
import 'package:movieapproute/ui/home/tabs/profile/profile_tabs.dart';
import 'package:movieapproute/ui/home/tabs/search/search_tab.dart';

import '../../utils/app_assets.dart';
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
        showSelectedLabels: false,
        showUnselectedLabels: false,
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
              selectedIconName: AppAssets.selectedHomeTabIcon,
              unSelectedIconName: AppAssets.unSelectedHomeTabIcon,
              name: 'home'
          ),
          buildBottomNavigationBarItem(
              index: 1,
              selectedIconName: AppAssets.selectedSearchTabIcon,
              unSelectedIconName: AppAssets.unSelectedSearchTabIcon,
              name: 'search'

          ),
          buildBottomNavigationBarItem(
              index: 2,
              selectedIconName: AppAssets.selectedBrowseTabIcon,
              unSelectedIconName: AppAssets.unSelectedBrowseTabIcon,
              name: 'browse'
          ),
          buildBottomNavigationBarItem(
              index: 3,
              selectedIconName: AppAssets.selectedProfileTabIcon,
              unSelectedIconName: AppAssets.unSelectedProfileTabIcon,
              name: 'profile'
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required int index,
    required String name,
    required String selectedIconName,
    required String unSelectedIconName,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(
        selectedIndex == index ? selectedIconName : unSelectedIconName,
      )
      ),
      label: name,

    );
  }
}