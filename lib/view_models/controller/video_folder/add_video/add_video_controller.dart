import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:stream_vids/models/video_folder/publish_video/publish_video_model.dart';
import 'package:stream_vids/repository/video_folder/add_video_repository/add_video_repository.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';

class AddVideoController extends GetxController {
  final _api = AddVideoRepository();
  // Text editing controllers
  final titleController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  final titleFocusNode = FocusNode().obs;
  final descriptionFocusNode = FocusNode().obs;
  RxBool loading = false.obs;

  // Observables for video and thumbnail
  var videoFile = Rx<dynamic>(null);
  var thumbnailImage = Rx<dynamic>(null);
  var videoName = ''.obs;
  var thumbnailImageName = ''.obs;

Future<void> pickVideo() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      if (kIsWeb) {
        // For web, use XFile for video handling
        videoFile.value = XFile.fromData(
          result.files.single.bytes!,
          name: result.files.single.name,
        );
        videoName.value = videoFile.value.name;
      } else {
        // For mobile/desktop, use file path
        String? filePath = result.files.single.path;
        if (filePath != null) {
          videoFile.value = XFile(filePath);
          videoName.value = videoFile.value.name;
        } else {
          Utils.snackBar("Error", "No video selected");
        }
      }
    } else {
      Utils.snackBar("Error", "No video selected");
    }
  } catch (e) {
    Utils.snackBar("Error", "Error picking video: $e");
  }
}


  /// Function to pick an image from the gallery
  void pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        if (kIsWeb) {
          thumbnailImage.value = pickedFile;
          thumbnailImageName.value = pickedFile.name;
        } else {
          File selectedFile = File(pickedFile.path);
          String fileName = selectedFile.path.split('/').last;
          thumbnailImage.value = selectedFile;
          thumbnailImageName.value = fileName;
        }
      } else {
        Utils.toastMessageBottom('no_image_selected'.tr);
      }
    } catch (e) {
      Utils.toastMessageBottom('image_picker_error'.tr);
    }
  }

  // Method to submit the video
  Future<void> submitVideo() async {
    loading.value = true;
    try {
      dio.FormData formData = dio.FormData();
      formData.fields.add(MapEntry("title", titleController.value.text));
      formData.fields
          .add(MapEntry("description", descriptionController.value.text));

      final videoMimeType =
          lookupMimeType(videoFile.value!.path) ?? 'application/octet-stream';
      final imageMimeType =
          lookupMimeType(videoFile.value!.path) ?? 'application/octet-stream';

      // Handle image upload differently based on platform
      if (kIsWeb) {
        // For web, use MultipartFile.fromBytes (use XFile for web)

        formData.files.add(MapEntry(
          "videoFile",
          dio.MultipartFile.fromBytes(
            await videoFile.value!.readAsBytes(),
            filename: videoName.value,
            contentType: MediaType.parse(videoMimeType),
          ),
        ));
        formData.files.add(MapEntry(
          "thumbnail",
          dio.MultipartFile.fromBytes(
            await thumbnailImage.value!.readAsBytes(),
            filename: thumbnailImageName.value,
            contentType: MediaType.parse(imageMimeType),
          ),
        ));
      } else {
        // For mobile/desktop, use MultipartFile.fromFile (supports dart:io)

        formData.files.add(MapEntry(
          "videoFile",
          await dio.MultipartFile.fromFile(
            videoFile.value!.path,
            filename: videoName.value,
            contentType: MediaType.parse(videoMimeType),
          ),
        ));
        formData.files.add(MapEntry(
          "thumbnail",
          await dio.MultipartFile.fromFile(
            thumbnailImage.value!.path,
            filename: thumbnailImageName.value,
            contentType: MediaType.parse(imageMimeType),
          ),
        ));
      }
      // Call the register API
      try {
        final response = await _api.addVideo(formData);
        if (response['statusCode'] == 200) {
          final model = PublishVideoModel.fromJson(response);
          if (model.success == true) {
            Get.delete<AddVideoController>();
            Utils.snackBar("Success", "Avatar Updated successfully");
            Get.toNamed(RouteName.navBarScreen, arguments: {'initialIndex': 2});
          } else {
            Utils.snackBar("Error", model.message);
          }
        } else {
          // Handle unexpected status code
          Utils.snackBar("Error",
              "Unexpected status code: ${response['statusCode']} \n ${response['message']}");
        }
      } catch (err) {
        Utils.snackBar("Error", "Error while Updating: $err");
      }
    } catch (e) {
      Utils.snackBar("Error", "Error while uploading image: $e");
    } finally {
      loading.value = false;
    }
  }

  // Method to clear fields
  void clearFields() {
    titleController.value.clear();
    descriptionController.value.clear();
    videoFile.value = null;
    thumbnailImage.value = null;
  }
}
