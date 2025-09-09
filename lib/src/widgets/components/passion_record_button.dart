import 'package:flutter/material.dart';

class PassionRecordButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const PassionRecordButton({
    super.key,
    this.onPressed,
    this.text = '기록하고 열정온도 올리기',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
