import 'package:stream_vids/models/user/login/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // Method to save the user data
  Future<bool> saveUser(Data responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('id', responseModel.user!.sId.toString());
    sp.setString('accessToken', responseModel.accessToken.toString());
    sp.setString('refreshToken', responseModel.refreshToken.toString());

    return true;
  }

  // Asynchronous method to retrieve user data
  Future<Data> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? sId = sp.getString('id');
    String? accessToken = sp.getString('accessToken');
    String? refreshToken = sp.getString('refreshToken');

    User user = User(sId: sId);
    return Data(
        user: user,
        accessToken: accessToken ?? "",
        refreshToken: refreshToken ?? "");
  }

  // Method to clear the stored user data
  Future<bool> clearUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('id');
    await sp.remove('accessToken');
    await sp.remove('refreshToken');

    return true;
  }
}
