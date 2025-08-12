import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class CustomSearchField extends StatefulWidget {
  final TextEditingController textController;
  final String? hintText;
  final VoidCallback? onSearch;
  final VoidCallback? onChange;

  const CustomSearchField({
    super.key,
    required this.textController,
    this.hintText,
    this.onSearch,
    this.onChange,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      textInputAction: TextInputAction.search,
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
                  style: CustomText.Body_Light_XS_12.copyWith(
                    color: CustomColor.gray_80,
                  ),
                )
                : null,
        suffixIcon: IconButton(
          icon: Icon(Icons.search, color: CustomColor.gray_80, size: 20),
          onPressed: widget.onSearch,
        ),
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
          widget.onChange!();
        }
      },
    );
  }
}
