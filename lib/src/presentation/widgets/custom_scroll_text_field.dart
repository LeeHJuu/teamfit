import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/widgets/custom_text_field.dart';

class CustomScrollTextField extends StatelessWidget {
  const CustomScrollTextField({
    super.key,
    required this.scrollController,
    required TextEditingController descriptionController,
  }) : textController = descriptionController;

  final ScrollController scrollController;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      padding: EdgeInsets.only(right: 8, top: 10),
      trackVisibility: true,
      thumbVisibility: true,
      thumbColor: Colors.black,
      thickness: 5,
      radius: Radius.circular(10),
      controller: scrollController,
      child: CustomTextField(
        textController: textController,
        minLine: 5,
        maxLength: 300, // 글자 수 제한
      ),
    );
  }
}
