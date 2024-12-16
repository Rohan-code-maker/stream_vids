import 'package:stream_vids/models/login/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(Data responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('accessToken', responseModel.accessToken.toString());
    return true;
  }

  Future<Data> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? accessToken = sp.getString('accessToken');
    return Data(accessToken: accessToken ?? "");
  }

  Future<bool> clearUser() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
}
