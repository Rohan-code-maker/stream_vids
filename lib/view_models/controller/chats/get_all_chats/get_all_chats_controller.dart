import 'package:get/get.dart';
import 'package:stream_vids/models/chats/get_all_chats/get_all_chats_model.dart';
import 'package:stream_vids/repository/chats/get_all_chats/get_all_chats_repo.dart';
import 'package:stream_vids/utils/utils.dart';

class GetAllChatsController extends GetxController {
  final _api = GetAllChatsRepo();
  final isLoading = false.obs;
  final chatsList = <Data>[].obs; // Stores all chat details
  var searchQuery = ''.obs;

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
        Utils.snackBar("error".tr, response["message"]);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    } finally {
      isLoading.value = false;
    }
  }

  List<Data> get filteredChats {
    if (searchQuery.value.isEmpty) return chatsList;
    var query = searchQuery.value.toLowerCase();

    // Prioritize matches by name and move to top
    var matches = chatsList.where((c) => c.name!.toLowerCase().contains(query)).toList();
    var others = chatsList.where((c) => !c.name!.toLowerCase().contains(query)).toList();
    return [...matches, ...others];
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

}
