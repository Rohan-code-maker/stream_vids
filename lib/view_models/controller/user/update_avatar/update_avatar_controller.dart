import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:stream_vids/models/user/update_account/update_account_model.dart';
import 'package:stream_vids/repository/user/update_avatar/update_avatar_repository.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';

class UpdateAvatarController extends GetxController {
  final UpdateAvatarRepository _api = UpdateAvatarRepository();
  final avatarController = TextEditingController().obs;
  final loading = false.obs;
  var avatarImage = Rx<dynamic>(null);
  var avatarImageName = ''.obs;

  /// Function to pick an image from the gallery
  void pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        if (kIsWeb) {
          avatarImage.value = pickedFile;
          avatarImageName.value = pickedFile.name;
        } else {
          File selectedFile = File(pickedFile.path);
          String fileName = selectedFile.path.split('/').last;
          avatarImage.value = selectedFile;
          avatarImageName.value = fileName;
        }
      } else {
        Utils.toastMessageBottom('no_image_selected'.tr);
      }
    } catch (e) {
      Utils.toastMessageBottom('image_picker_error'.tr);
      debugPrint('Error picking image: $e');
    }
  }

  /// Function to update the avatar image
  void updateAvatar() async {
    if (avatarImageName.value.isEmpty) {
      Utils.snackBar("Error", "Please select an avatar image.");
      loading.value = false;
      return;
    }

    loading.value = true;

    try {
      dio.FormData formData = dio.FormData();

      // Handle image upload differently based on platform
      if (kIsWeb) {
        // For web, use MultipartFile.fromBytes (use XFile for web)
        final mimeType = lookupMimeType(avatarImage.value!.path) ??
            'application/octet-stream';

        formData.files.add(MapEntry(
          "avatar",
          dio.MultipartFile.fromBytes(
            await avatarImage.value!.readAsBytes(),
            filename: avatarImageName.value,
            contentType: MediaType.parse(mimeType),
          ),
        ));
      } else {
        // For mobile/desktop, use MultipartFile.fromFile (supports dart:io)
        final avatarMimeType = lookupMimeType(avatarImage.value!.path) ??
            'application/octet-stream';

        formData.files.add(MapEntry(
          "avatar",
          await dio.MultipartFile.fromFile(
            avatarImage.value!.path,
            filename: avatarImageName.value,
            contentType: MediaType.parse(avatarMimeType),
          ),
        ));

        // Call the register API
        try {
          final response = await _api.updateAvatarApi(formData);
          if (response['statusCode'] == 200) {
            final model = UpdateAccountModel.fromJson(response);
            if (model.success == true) {
              Get.delete<UpdateAvatarController>();
              Utils.snackBar("Success", "Avatar Updated successfully");
              Get.toNamed(RouteName.navBarScreen,
                  arguments: {'initialIndex': 2});
            }else{
              Utils.snackBar("Error", model.message!);
            }
          } else {
            // Handle unexpected status code
            Utils.snackBar(
                "Error", "Unexpected status code: ${response['statusCode']}");
          }
        } catch (err) {
          Utils.snackBar("Error", "Error while Updating: $err");
        }
      }
    } catch (e) {
      Utils.snackBar("Error", "Error while uploading image: $e");
    } finally {
      loading.value = false;
    }
  }
}
