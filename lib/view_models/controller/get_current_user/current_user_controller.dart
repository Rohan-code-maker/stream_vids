import 'package:get/get.dart';
import 'package:stream_vids/models/get_current_user/current_user_model.dart';
import 'package:stream_vids/repository/get_current_user/current_user_repository.dart';
import 'package:stream_vids/utils/utils.dart';

class CurrentUserController extends GetxController {
  final CurrentUserRepository _api = CurrentUserRepository();

  var isLoading = true.obs;
  var currentUser = Data().obs; // Observable to hold the user data

  @override
  void onInit() {
    getCurrentUser();
    super.onInit();
  }

  void getCurrentUser() async {
    isLoading(true);
    try {
      final response = await _api.currentUserApi();
      final userModel = CurrentUserModel.fromJson(response);
      if (userModel.success!) {
        currentUser.value = userModel.data!; // Update the observable
      } else {
        Utils.snackBar("Error", userModel.message!);
      }
    } catch (e) {
      Utils.snackBar("Error", "Error occurred while fetching data: $e");
    } finally {
      isLoading(false);
    }
  }
}
