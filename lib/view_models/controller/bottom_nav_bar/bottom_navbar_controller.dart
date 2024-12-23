import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Reactive variable for the selected index
  var selectedIndex = 0.obs;

  // Method to update the index
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
