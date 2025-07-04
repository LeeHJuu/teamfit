import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';

class CustomSelectButton extends StatefulWidget {
  String title;
  bool isSelected;
  void Function() onPress;
  CustomSelectButton({
    required this.title,
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
      height: 54,
      child: OutlinedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          widget.onPress();
        },
        style: OutlinedButton.styleFrom(
          foregroundColor:
              widget.isSelected ? CustomColor.primary_60 : Colors.black,
          side: BorderSide(
            color:
                widget.isSelected
                    ? CustomColor.primary_60
                    : Colors.grey, // 테두리 색상 변경
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),
        child: Text(widget.title),
      ),
    );
  }
}
