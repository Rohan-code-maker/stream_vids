// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:stream_vids/utils/utils.dart';

// class ImagePickerService {
//   final ImagePicker _picker = ImagePicker();

//   // Variables to store selected images dynamically
//   Rx<dynamic> selectedImage = Rx<dynamic>(null);
//   Rx<String> selectedImageName = Rx<String>('');

//   Future<void> pickImage() async {
//     try {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//       if (pickedFile != null) {
//         String fileName = '';

//         if (kIsWeb) {
//           // Web: Use XFile for web platforms
//           fileName = pickedFile.name;
//           selectedImage.value = pickedFile;
//           selectedImageName.value = fileName;
//         } else {
//           // Mobile/desktop: Use File for non-web platforms
//           File selectedFile = File(pickedFile.path);
//           fileName = selectedFile.path.split('/').last;
//           selectedImage.value = selectedFile;
//           selectedImageName.value = fileName;
//         }
//       } else {
//         Utils.snackBar("Error", "No image selected");
//       }
//     } catch (e) {
//       Utils.snackBar("Error", "Failed to pick an image: $e");
//     }
//   }

//   // Clear selected image dynamically
//   void clearImage() {
//     selectedImage.value = null;
//     selectedImageName.value = '';
//   }
// }
