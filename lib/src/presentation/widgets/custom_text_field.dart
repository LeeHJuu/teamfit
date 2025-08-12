import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      maxLength: widget.maxLength, // 글자 수 제한
      minLines: widget.minLine,
      maxLines: widget.minLine ?? 1,
      textInputAction: TextInputAction.done,
      onTap: () {
        setState(() {
          isFocused = true;
        });
      },
      onEditingComplete: () {
        setState(() {
          isFocused = false;
        });
      },
      decoration: InputDecoration(
        isDense: true,
        hint:
            widget.hintText != null && widget.hintText!.isNotEmpty
                ? Text(
                  widget.hintText!,
                  style: CustomText.Body_Light_M_14.copyWith(
                    color: CustomColor.gray_80,
                  ),
                )
                : SizedBox.shrink(),
        helper:
            widget.helperText != null && widget.helperText!.isNotEmpty
                ? Text(
                  widget.helperText!,
                  style: CustomText.Body_Light_XS_12.copyWith(
                    color: CustomColor.gray_50,
                  ),
                )
                : SizedBox.shrink(),
        // ... existing code ...
        suffixIcon:
            isFocused
                ? IconButton(
                  icon: Icon(Icons.close, color: CustomColor.gray_80, size: 20),
                  onPressed: () {
                    widget.textController.clear();
                    if (widget.onChange != null) {
                      widget.onChange!();
                    }
                  },
                )
                : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                widget.textController.text.isEmpty
                    ? CustomColor.gray_80
                    : CustomColor.gray_10,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                widget.textController.text.isEmpty
                    ? CustomColor.gray_80
                    : CustomColor.primary_60,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) {
        if (widget.onChange != null) {
          widget.onChange!(); // onChange 호출
        }
      },
      onSubmitted: (value) {
        if (widget.onSubmit != null) {
          widget.onSubmit!(); // onSubmit 호출
        }
      },
    );
  }
}
