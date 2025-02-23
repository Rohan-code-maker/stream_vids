import 'package:get/get.dart';
import 'package:stream_vids/models/chats/get_all_chats_model.dart';
import 'package:stream_vids/repository/chats/get_all_chats/get_all_chats_repo.dart';
import 'package:stream_vids/utils/utils.dart';

class GetAllChatsController extends GetxController {
  final _api = GetAllChatsRepo();
  final isLoading = false.obs;
  final chatsList = <Data>[].obs; // Stores all chat details

  @override
  void onInit() {
    super.onInit();
    getAllChats(); // Fetch chats when controller initializes
  }

  void getAllChats() async {
    try {
      isLoading.value = true;
      final response = await _api.getAllChats();
      if (response["statusCode"] == 200) {
        final chatsModel = GetAllChatsModel.fromJson(response);
        chatsList.assignAll(chatsModel.data ?? []);
      } else {
        Utils.snackBar("Error", response["message"] ?? "Failed to fetch chats");
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("Error", err);
    } finally {
      isLoading.value = false;
    }
  }
}
