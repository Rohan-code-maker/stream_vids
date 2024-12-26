import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Reactive variable for the selected index
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Check if an argument is passed and update the index accordingly
    if (Get.arguments != null && Get.arguments['initialIndex'] != null) {
      selectedIndex.value = Get.arguments['initialIndex'];
    }
  }

  // Method to update the index
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
