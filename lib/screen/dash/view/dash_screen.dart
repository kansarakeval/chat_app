import 'package:chat_app/screen/dash/controller/dash_controller.dart';
import 'package:chat_app/screen/home/view/home_screen.dart';
import 'package:chat_app/screen/profile/view/profile_sceen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  List<Widget> screen = [
    const HomeScreen(),
    const ProfileScreen(),

  ];

  DashController controller = DashController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
              () => PageView(
            controller: controller.pageController.value,
            onPageChanged: (value) {
              controller.screenIndex.value = value;
            },
            children: screen,
          ),
        ),
        bottomNavigationBar: Obx(
              () => NavigationBar(
            selectedIndex: controller.screenIndex.value,
            onDestinationSelected: (value) {
              controller.pageController.value.animateToPage(value,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeIn);
              controller.screenIndex.value = value;
            },
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined), label: "Home"),
              NavigationDestination(
                  icon: Icon(Icons.account_circle_outlined), label: "profile"),
              NavigationDestination(
                  icon: Icon(Icons.account_circle_outlined), label: "profile"),

            ],
            animationDuration: const Duration(microseconds: 1000),
          ),
        ),
      ),
    );
  }
}