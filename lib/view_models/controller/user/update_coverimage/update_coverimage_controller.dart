import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:stream_vids/models/user/update_account/update_account_model.dart';
import 'package:stream_vids/repository/user/update_coverimage/update_coverimage_repository.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';

class UpdateCoverimageController extends GetxController{
  final _api = UpdateCoverImageRepository();
  final loading = false.obs;
  var coverImage = Rx<dynamic>(null);
  var coverImageName = ''.obs;

  /// Function to pick an image from the gallery
  void pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        if (kIsWeb) {
          coverImage.value = pickedFile;
          coverImageName.value = pickedFile.name;
        } else {
          File selectedFile = File(pickedFile.path);
          String fileName = selectedFile.path.split('/').last;
          coverImage.value = selectedFile;
          coverImageName.value = fileName;
        }
      } else {
        Utils.toastMessageBottom('no_image_selected'.tr);
      }
    } catch (e) {
      Utils.toastMessageBottom('image_picker_error'.tr);
    }
  }

  /// Function to update the avatar image
  void updateCoverImage() async {
    loading.value = true;
    if (coverImageName.value.isEmpty) {
      Utils.snackBar("Error", "Please select an Cover image.");
      loading.value = false;
      return;
    }

    try {
      dio.FormData formData = dio.FormData();

      // Handle image upload differently based on platform
      if (kIsWeb) {
        // For web, use MultipartFile.fromBytes (use XFile for web)
        final mimeType = lookupMimeType(coverImage.value!.path) ??
            'application/octet-stream';

        formData.files.add(MapEntry(
          "coverImage",
          dio.MultipartFile.fromBytes(
            await coverImage.value!.readAsBytes(),
            filename: coverImageName.value,
            contentType: MediaType.parse(mimeType),
          ),
        ));
      } else {
        // For mobile/desktop, use MultipartFile.fromFile (supports dart:io)
        final avatarMimeType = lookupMimeType(coverImage.value!.path) ??
            'application/octet-stream';

        formData.files.add(MapEntry(
          "coverImage",
          await dio.MultipartFile.fromFile(
            coverImage.value!.path,
            filename: coverImageName.value,
            contentType: MediaType.parse(avatarMimeType),
          ),
        ));
      }
      // Call the register API
      try {
        final response = await _api.updateCoverImageApi(formData);
        if (response['statusCode'] == 200) {
          final model = UpdateAccountModel.fromJson(response);
          if (model.success == true) {
            Get.delete<UpdateCoverimageController>();
            Utils.snackBar("Success", "CoverImage Updated successfully");
            Get.toNamed(RouteName.navBarScreen, arguments: {'initialIndex': 2});
          } else {
            Utils.snackBar("Error", model.message!);
          }
        } else {
          // Handle unexpected status code
          Utils.snackBar(
              "Error", "Unexpected status code: ${response['statusCode']} \n ${response['message']}");
        }
      } catch (e) {
        final String err = Utils.extractErrorMessage(e.toString());
        Utils.snackBar("Error", err);
      }
    } catch (e) {
      Utils.snackBar("Error", "Error while uploading image: $e");
    } finally {
      loading.value = false;
    }
  }
}