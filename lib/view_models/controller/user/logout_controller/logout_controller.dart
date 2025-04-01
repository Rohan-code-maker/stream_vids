import 'package:get/get.dart';
import 'package:stream_vids/models/user/logout/logout_model.dart';
import 'package:stream_vids/repository/user/logout_repository/logout_repository.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/res/user_preferences/user_preferences.dart';

class LogoutController extends GetxController {
  final LogoutRepository _api = LogoutRepository();
  UserPreferences userPreferences = UserPreferences();
  RxBool loading = false.obs;

  void logout() async {
    loading.value = true;

    try {
      // Get user preferences
      final user = await userPreferences.getUser();
      final accessToken = user.accessToken;

      // Call logout API
      final response = await _api
          .logoutApi({"accessToken": accessToken}).onError((err, stackTrace) {
        Utils.snackBar("error".tr, "error_api_call".tr);
      });
      final logoutModel = LogoutModel.fromJson(response);

      if (logoutModel.statusCode == 200) {
        // Logout successful
        await userPreferences.clearUser();
        Get.delete<LogoutController>();
        Get.offAllNamed(RouteName.loginScreen);
        Utils.snackBar("success".tr, "logout_success".tr);
      } else {
        // Logout failed
        Utils.snackBar("error".tr, "logout_failed".tr);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    } finally {
      // Hide loading indicator
      loading.value = false;
    }
  }
}
