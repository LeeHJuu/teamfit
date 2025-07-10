import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textController;
  final int? maxLength;
  final int? minLine;
  final String? hintText;
  final String? helperText;
  final void Function()? onchange;

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
        // hintText: hintText,
        // helperText: helperText,
        hint: Text(
          hintText ?? '',
          style: CustomText.Body_Light_M.copyWith(color: CustomColor.gray_80),
        ),
        helper: Text(
          helperText ?? '',
          style: CustomText.Body_Light_XS.copyWith(color: CustomColor.gray_50),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColor.gray_90),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColor.primary_60),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) {
        if (onchange != null) {
          onchange!();
        }
      },
    );
  }
}
