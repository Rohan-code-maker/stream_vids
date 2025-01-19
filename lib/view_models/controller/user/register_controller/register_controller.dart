import 'dart:io';
import 'package:mime/mime.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:stream_vids/models/user/register/register_model.dart';
import 'package:stream_vids/repository/user/register_repository/register_repository.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';

class RegisterController extends GetxController {
  final _api = RegisterRepository();

  // TextEditingControllers for form fields
  final fullnameController = TextEditingController().obs;
  final usernameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  // FocusNodes for form fields
  final fullnameFocusNode = FocusNode().obs;
  final usernameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  // Image-related properties
  final ImagePicker _picker = ImagePicker();
  var avatarImage = Rx<dynamic>(null);
  var coverImage = Rx<dynamic>(null);
  var avatarImageName = ''.obs;
  var coverImageName = ''.obs;

  RxBool loading = false.obs;

  // Function to pick an image
  Future<void> pickImage({required bool isAvatar}) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        if (kIsWeb) {
          // Web: Use XFile for web platforms
          String fileName = pickedFile.name;

          if (isAvatar) {
            avatarImage.value = pickedFile; // Store as XFile
            avatarImageName.value = fileName;
          } else {
            coverImage.value = pickedFile; // Store as XFile
            coverImageName.value = fileName;
          }
        } else {
          // Mobile/desktop: Use File for non-web platforms
          File selectedFile = File(pickedFile.path);
          String fileName = selectedFile.path.split('/').last;

          if (isAvatar) {
            avatarImage.value = selectedFile;
            avatarImageName.value = fileName;
          } else {
            coverImage.value = selectedFile;
            coverImageName.value = fileName;
          }
        }
      } else {
        Utils.snackBar("Error", "No image selected");
      }
    } catch (e) {
      
      Utils.snackBar("Error", "Failed to pick an image: $e");
    }
  }

  // Clear selected image
  void clearImage({required bool isAvatar}) {
    if (isAvatar) {
      avatarImage.value = null;
      avatarImageName.value = '';
    } else {
      coverImage.value = null;
      coverImageName.value = '';
    }
  }

  // Register function
  void register() async {
    loading.value = true;

    if (avatarImageName.value.isEmpty) {
      Utils.snackBar("Error", "Please select an avatar image.");
      loading.value = false;
      return;
    }

    try {
      dio.FormData formData = dio.FormData();

      // Add text fields to formData
      formData.fields.add(MapEntry("fullname", fullnameController.value.text));
      formData.fields.add(MapEntry("username", usernameController.value.text));
      formData.fields.add(MapEntry("email", emailController.value.text));
      formData.fields.add(MapEntry("password", passwordController.value.text));

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

        // Add cover image if available (for web)
        if (coverImageName.value.isNotEmpty) {
          final coverMimeType = lookupMimeType(coverImage.value!.path) ??
              'application/octet-stream';

          formData.files.add(MapEntry(
            "coverImage",
            dio.MultipartFile.fromBytes(
              await coverImage.value!.readAsBytes(),
              filename: coverImageName.value,
              contentType: MediaType.parse(coverMimeType),
            ),
          ));
        }
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

        // Add cover image if available (for mobile/desktop)
        if (coverImage.value != null) {
          final coverMimeType = lookupMimeType(coverImage.value!.path) ??
              'application/octet-stream';

          formData.files.add(MapEntry(
            "coverImage",
            await dio.MultipartFile.fromFile(
              coverImage.value!.path,
              filename: coverImageName.value,
              contentType: MediaType.parse(coverMimeType),
            ),
          ));
        }
      }

      // Call the register API
      try {
        final response = await _api.registerApi(formData);
        if (response['statusCode'] == 200) {
          final registerModel = RegisterModel.fromJson(response);

          if (registerModel.statusCode == 200) {
            // Registration successful
            Get.delete<RegisterController>();
            Get.toNamed(RouteName.loginScreen);
            Utils.snackBar("Success", "Registration Successful");
            clearFields();
          } else {
            Utils.snackBar(
                "Error", registerModel.message ?? "Unknown error occurred");
          }
        } else {
          // Handle unexpected status code
          Utils.snackBar(
              "Error", "Unexpected status code: ${response['statusCode']}");
        }
      } catch (e) {
        final String err = Utils.extractErrorMessage(e.toString());
        Utils.snackBar("Error", "Error while registering: $err");
      }
    } catch (error) {
      Utils.snackBar("Error", "Registration failed: $error");
    } finally {
      loading.value = false;
    }
  }

  void clearFields() {
    fullnameController.value.clear();
    usernameController.value.clear();
    emailController.value.clear();
    passwordController.value.clear();
    avatarImage.value = null;
    coverImage.value = null;
  }
}
