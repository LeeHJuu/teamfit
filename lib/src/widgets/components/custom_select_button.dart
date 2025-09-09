import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class CustomSelectButton extends StatefulWidget {
  String title;
  int textAlign;
  bool isSelected;
  void Function() onPress;
  CustomSelectButton({
    required this.title,
    required this.textAlign,
    required this.isSelected,
    required this.onPress,
  });

  @override
  State<CustomSelectButton> createState() => _CustomSelectButtonState();
}

class _CustomSelectButtonState extends State<CustomSelectButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: OutlinedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          widget.onPress();
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16),
          backgroundColor:
              widget.isSelected ? CustomColor.primary_95 : Colors.white,
          side: BorderSide(
            color:
                widget.isSelected
                    ? CustomColor.primary_60
                    : CustomColor.gray_80,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),
        child: Row(
          children: [
            if (widget.textAlign == 0) ...[
              Text(
                widget.title,
                style: CustomText.Label_Heavy_S_14,
                textAlign: TextAlign.left,
              ),
              Spacer(),
            ] else ...[
              Expanded(
                child: Center(
                  child: Text(
                    widget.title,
                    style: CustomText.Label_Heavy_S_14,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
