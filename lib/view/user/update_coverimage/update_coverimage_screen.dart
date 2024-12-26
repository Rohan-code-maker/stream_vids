import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateCoverimageScreen extends StatefulWidget {
  const UpdateCoverimageScreen({super.key});

  @override
  State<UpdateCoverimageScreen> createState() => _UpdateCoverimageScreenState();
}

class _UpdateCoverimageScreenState extends State<UpdateCoverimageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('update_coverimage'.tr),
      ),
    );
  }
}