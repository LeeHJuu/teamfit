import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController textController;
  int? maxLength;
  int? minLine;
  String? hintText;
  String? helperText;
  void Function()? onchange;

  CustomTextField({
    required this.textController,
    this.maxLength,
    this.minLine,
    this.hintText,
    this.helperText,
    this.onchange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      maxLength: maxLength, // 글자 수 제한
      minLines: minLine,
      maxLines: minLine ?? 1,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: hintText,
        helperText: helperText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
