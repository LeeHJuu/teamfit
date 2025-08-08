import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class CustomScrollTextField extends StatelessWidget {
  const CustomScrollTextField({
    super.key,
    required this.scrollController,
    required TextEditingController descriptionController,
    this.hintText,
    this.maxLength,
    this.minLine,
    this.helperText,
    this.onChange,
    this.onSubmit,
  }) : textController = descriptionController;

  final ScrollController scrollController;
  final TextEditingController textController;
  final String? hintText;
  final int? maxLength;
  final int? minLine;
  final String? helperText;
  final void Function()? onChange;
  final void Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      padding: const EdgeInsets.only(right: 8, top: 10),
      trackVisibility: true,
      thumbVisibility: true,
      thumbColor: Colors.black,
      thickness: 5,
      radius: const Radius.circular(10),
      controller: scrollController,
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.gray_95,
          borderRadius: BorderRadius.circular(10),
        ),
        child: _textField(
          textController: textController,
          maxLength: maxLength,
          minLine: minLine,
          hintText: hintText,
          helperText: helperText,
          onChange: onChange,
          onSubmit: onSubmit,
        ),
      ),
    );
  }
}

class _textField extends StatelessWidget {
  const _textField({
    super.key,
    required this.textController,
    required this.maxLength,
    required this.minLine,
    required this.hintText,
    required this.helperText,
    required this.onChange,
    required this.onSubmit,
  });

  final TextEditingController textController;
  final int? maxLength;
  final int? minLine;
  final String? hintText;
  final String? helperText;
  final void Function()? onChange;
  final void Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      maxLength: maxLength,
      minLines: minLine ?? 5,
      maxLines: minLine ?? 5,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: CustomText.Body_Light_XS_12.copyWith(
          color: CustomColor.gray_60,
        ),
        helperText: helperText,
        helperStyle: CustomText.Body_Light_XS_12.copyWith(
          color: CustomColor.gray_50,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: CustomColor.gray_95,
        contentPadding: const EdgeInsets.all(16),
      ),
      onChanged: (value) {
        if (onChange != null) {
          onChange!();
        }
      },
      onSubmitted: (value) {
        if (onSubmit != null) {
          onSubmit!();
        }
      },
    );
  }
}
