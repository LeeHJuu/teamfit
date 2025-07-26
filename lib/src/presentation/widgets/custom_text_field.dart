import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textController;
  final int? maxLength;
  final int? minLine;
  final String? hintText;
  final String? helperText;
  final void Function()? onChange;
  final void Function()? onSubmit;

  CustomTextField({
    required this.textController,
    this.maxLength,
    this.minLine,
    this.hintText,
    this.helperText,
    this.onChange,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      maxLength: maxLength, // 글자 수 제한
      minLines: minLine,
      maxLines: minLine ?? 1,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hint: Text(
          hintText ?? '',
          style: CustomText.Body_Light_M.copyWith(color: CustomColor.gray_80),
        ),
        helper: Text(
          helperText ?? '',
          style: CustomText.Body_Light_XS.copyWith(color: CustomColor.gray_50),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                textController.text.isEmpty
                    ? CustomColor.gray_80
                    : CustomColor.gray_10,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                textController.text.isEmpty
                    ? CustomColor.gray_80
                    : CustomColor.primary_60,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) {
        if (onChange != null) {
          onChange!(); // onChange 호출
        }
      },
      onSubmitted: (value) {
        if (onSubmit != null) {
          onSubmit!(); // onSubmit 호출
        }
      },
    );
  }
}
