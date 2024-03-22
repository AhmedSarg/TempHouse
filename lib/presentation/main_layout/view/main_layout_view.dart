import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';

import '../../resources/text_styles.dart';
import '../../under_construction_screen/view/under_construction_view.dart';
import '../pages/home_screen/view/home_page.dart';
import '../pages/notifications_screen/view/notifications_view.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          enableFeedback: true,
          onTap: (index) {
            setState(() {
              selectedTabIndex = index;
            });
          },
          selectedLabelStyle: AppTextStyles.mainNavBarLabel(context),
          currentIndex: selectedTabIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: AppStrings.homeNavBarHome.tr(),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.favorite_border),
              activeIcon: const Icon(Icons.favorite),
              label: AppStrings.homeNavBarFavourite.tr(),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.notifications_outlined),
              activeIcon: const Icon(Icons.notifications),
              label: AppStrings.homeNavBarNotifications.tr(),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.person_outline_rounded),
              activeIcon: const Icon(Icons.person_rounded),
              label: AppStrings.homeNavBarProfile.tr(),
            ),
          ],
        ),
        body: tabs[selectedTabIndex],
      ),
    );
  }

  List<Widget> tabs = [
    const HomePage(),
    const UnderConstruction(),
    const NotificationsScreen(),
    const UnderConstruction()
  ];
}
