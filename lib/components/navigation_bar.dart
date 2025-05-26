import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/home_screen.dart';
import '../controller/navbar_controller.dart';
import '../screens/artical_page.dart';
import '../screens/profile_page.dart';

class NewsAppNavBar extends StatelessWidget {
  NewsAppNavBar({super.key});

  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> screens = [
    const HomeScreen(),
   ArticalPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: screens[navController.selectedIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navController.selectedIndex.value,
        onTap: navController.changeIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article_outlined), label: 'Artical'),
        ],
      ),
    ),);
  }
}
