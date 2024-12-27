import 'package:get/get.dart';
import 'package:stream_vids/models/user/logout/logout_model.dart';
import 'package:stream_vids/repository/user/logout_repository/logout_repository.dart';
import 'package:stream_vids/res/cookies/cookie_manager';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/res/user_preferences/user_preferences.dart';

class LogoutController extends GetxController {
  final LogoutRepository _api = LogoutRepository();
  UserPreferences userPreferences = UserPreferences();
  CookieManager cookieManager = CookieManager();
  RxBool loading = false.obs;

  void logout() async {
    loading.value = true; // Show loading indicator

    try {
      // Get user preferences
      final user = await userPreferences.getUser();
      final accessToken = user.accessToken;

      // Call logout API
      final response = await _api.logoutApi({"accessToken": accessToken}).onError((err,stackTrace){
        Utils.snackBar("Error", "Error while Api call");
      });
      final logoutModel = LogoutModel.fromJson(response);

      if (logoutModel.statusCode == 200) {
        // Logout successful
        await userPreferences.clearUser(); 
        cookieManager.removeCookie('accessToken');
        cookieManager.removeCookie('refreshToken');
        Get.delete<LogoutController>(); 
        Get.toNamed(RouteName.loginScreen); 
        Utils.snackBar("Success", "Logout Successfully");
      } else {
        // Logout failed
        Utils.snackBar("Error", "Logout Failed");
      }
    } catch (e) {
      // Handle errors
      Utils.snackBar("Error", "Logout failed:");
    } finally {
      // Hide loading indicator
      loading.value = false;
    }
  }
}
