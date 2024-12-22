import 'package:flutter/material.dart';
import 'package:stream_vids/res/colors/app_colors.dart';
import 'package:stream_vids/utils/utils.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      this.obscure = false,
      required this.hintText,
      required this.labelText,
      this.obscureChar = "*",
      required this.controller,
      required this.currentFocusNode,
      required this.nextFocusNode,
      this.validator});

  final bool obscure;
  final String hintText, labelText, obscureChar;
  final TextEditingController controller;
  final FocusNode currentFocusNode, nextFocusNode;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      maxLines: 1,
      autofocus: false,
      controller: controller,
      focusNode: currentFocusNode,
      validator: validator,
      onFieldSubmitted: (value) {
        Utils.fieldFocusChange(context, currentFocusNode, nextFocusNode);
      },
      obscureText: obscure,
      obscuringCharacter: obscureChar,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        errorStyle: const TextStyle(color: AppColors.red)
      ),
    );
  }
}
