import 'package:get/get.dart';
import 'package:stream_vids/models/chats/get_all_messages/get_all_messages_model.dart';
import 'package:stream_vids/repository/chats/get_all_messages/get_all_messages_repo.dart';
import 'package:stream_vids/utils/utils.dart';

class GetAllMessagesController extends GetxController{
  final _api = GetAllMessagesRepo();
  var isLoading = true.obs;
  var messages = <Data>[].obs;

  void getAllMessages(String chatId) async {
    isLoading(true);
    try {
      final response = await _api.getAllMessages(chatId);
      if (response != null) {
        final model = GetAllMessageModel.fromJson(response);
        if(model.success == true) {
          messages.value = model.data!;
        } else {
          Utils.snackBar("error".tr, model.message.toString());
        }
      }else {
        Utils.snackBar("error".tr, response['message']);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    }
    finally {
      isLoading(false);
    }
  }
}