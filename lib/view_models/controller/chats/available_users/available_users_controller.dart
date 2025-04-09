import 'package:get/get.dart';
import 'package:stream_vids/models/chats/available_user/available_user_model.dart';
import 'package:stream_vids/repository/chats/available_users/available_users_repo.dart';
import 'package:stream_vids/utils/utils.dart';

class AvailableUsersController extends GetxController {
  final _api = AvailableUsersRepo();
  final isLoading = false.obs;
  final availableUsersList = <Data>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getAllChats(); // Fetch chats when controller initializes
  }

  void getAllChats() async {
    try {
      isLoading.value = true;
      final response = await _api.getAvailableUsers();
      if (response["statusCode"] == 200) {
        final chatsModel = AvailableUserModel.fromJson(response);
        if (chatsModel.success!) {
          Get.delete<AvailableUsersController>();
          availableUsersList.value = chatsModel.data!;
        } else {
          Utils.snackBar("error".tr, chatsModel.message!);
        }
      } else {
        Utils.snackBar("error".tr, response["message"] ?? "Failed to fetch chats");
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    } finally {
      isLoading.value = false;
    }
  }

  List<Data> get filteredChats {
    if (searchQuery.value.isEmpty) return availableUsersList;
    var query = searchQuery.value.toLowerCase();

    // Prioritize matches by name and move to top
    var matches = availableUsersList
        .where((c) => c.username!.toLowerCase().contains(query))
        .toList();
    var others = availableUsersList
        .where((c) => !c.username!.toLowerCase().contains(query))
        .toList();
    return [...matches, ...others];
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }
}
