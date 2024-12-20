import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/screen_provider.dart';
import 'package:tofu/screens/main/home.dart';
import 'package:tofu/screens/main/portfolio.dart';
import 'package:tofu/screens/main/profile.dart';
import 'package:tofu/theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List _screens = [
    const HomeScreen(),
    const PortfolioScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenProvider screenProvider = Provider.of(context);

    Widget bottomBar() {
      return BottomAppBar(
        color: backgroundPrimaryColor,
        clipBehavior: Clip.antiAlias,
        child: Wrap(
          children: [
            BottomNavigationBar(
              backgroundColor: backgroundPrimaryColor,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: screenProvider.currentIndex,
              onTap: (value) {
                screenProvider.currentIndex = value;
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      screenProvider.currentIndex == 0
                          ? Icons.home
                          : Icons.home_outlined,
                      size: 24,
                      color: screenProvider.currentIndex == 0
                          ? primaryColor
                          : Colors.grey,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      screenProvider.currentIndex == 1
                          ? Icons.pie_chart
                          : Icons.pie_chart_outline,
                      size: 24,
                      color: screenProvider.currentIndex == 1
                          ? primaryColor
                          : Colors.grey,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      screenProvider.currentIndex == 2
                          ? Icons.person
                          : Icons.person_outlined,
                      size: 24,
                      color: screenProvider.currentIndex == 2
                          ? primaryColor
                          : Colors.grey,
                    ),
                    label: ''),
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
        child: Container(
          color: backgroundSecondaryColor,
          child: Column(
            children: [
              Expanded(
                child: _screens[screenProvider.currentIndex],
              ),
              bottomBar(), // Bottom bar stays at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
