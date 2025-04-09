import 'package:get/get.dart';
import 'package:stream_vids/models/chats/create_one_chat/create_one_chat_model.dart';
import 'package:stream_vids/repository/chats/create_one_chat/create_one_chat_repo.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';

class CreateOneChatController extends GetxController {
  final _api = CreateOneChatRepo();
  var isLoading = false.obs;

  void addChat(String userId) async {
    try {
      isLoading.value = true;
      final response = await _api.createOneChat(userId);
      if (response["statusCode"] == 200) {
        final model = CreateOneOnOneChatModel.fromJson(response);
        if (model.success!) {
          Get.delete<CreateOneChatController>();
          Utils.snackBar("success".tr, "chat_created".tr);
          Get.toNamed(RouteName.chatScreen);
        } else {
          Utils.snackBar("error".tr, model.message!);
        }
      } else {
        // Handle error response
        Utils.snackBar("error".tr, response["message"]);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    } finally {
      isLoading.value = false;
    }
  }
}
