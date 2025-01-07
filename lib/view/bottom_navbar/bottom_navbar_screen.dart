import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/view/user/watch_history/watch_history_screen.dart';
import 'package:stream_vids/view/video_folder/add_video/add_video_screen.dart';
import 'package:stream_vids/view/video_folder/home/home_screen.dart';
import 'package:stream_vids/view/user/profile/profile_screen.dart';
import 'package:stream_vids/view/video_folder/search/search_screen.dart';
import 'package:stream_vids/view_models/controller/bottom_nav_bar/bottom_navbar_controller.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  BottomNavigationBarScreen({super.key});

  // Initialize the BottomNavController
  final BottomNavController _controller = Get.put(BottomNavController());

  // List of pages for the navigation
  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const AddVideoScreen(),
    const WatchHistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[_controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: _controller.selectedIndex.value,
            onTap: (index) => _controller.changeIndex(index),
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                label: 'Post Video',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.watch_later),
                label: 'Watch History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          )),
    );
  }
}
