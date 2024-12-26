import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/models/user/update_account/update_account_model.dart';
import 'package:stream_vids/repository/user/update_account/update_account_repository.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';

class UpdateAccountController extends GetxController {
  final UpdateAccountRepository _api = UpdateAccountRepository();

  final fullnameController = TextEditingController().obs;
  final usernameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;

  final fullnameFocusNode = FocusNode().obs;
  final usernameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;

  RxBool isLoading = false.obs;

  void updateAccount() async {
    isLoading.value = true;

    Map<String, String> data = {
      "fullname": fullnameController.value.text.trim(),
      "username": usernameController.value.text.trim(),
      "email": emailController.value.text.trim(),
    };

    try {
      final response = await _api.updateAccountApi(data);
      if (response['statusCode'] == 200) {
        final model = UpdateAccountModel.fromJson(response);
        if (model.statusCode == 200) {
          Get.delete<UpdateAccountController>();
          Utils.snackBar("Success", "Account Updated successfully");
          Get.toNamed(RouteName.navBarScreen,arguments: {'initialIndex': 2});
        }else{
          Utils.snackBar("Error", model.message!);
        }
      }else{
        Utils.snackBar("Error", "Response arrives with status code  ${response['statusCode']}");
      }
    } catch (e) {
      Utils.snackBar("Error", "Failed to call the Api:$e");
    } finally {
      isLoading.value = false;
    }
  }
}
