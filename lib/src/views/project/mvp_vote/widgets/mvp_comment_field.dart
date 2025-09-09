import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class MvpCommentField extends StatefulWidget {
  final Function(String) onCommentChanged;
  final String? initialValue;
  final int maxLength;

  const MvpCommentField({
    Key? key,
    required this.onCommentChanged,
    this.initialValue,
    this.maxLength = 150,
  }) : super(key: key);

  @override
  _MvpCommentFieldState createState() => _MvpCommentFieldState();
}

class _MvpCommentFieldState extends State<MvpCommentField> {
  late TextEditingController _controller;
  int _currentLength = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
    _currentLength = _controller.text.length;
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _currentLength = _controller.text.length;
    });
    widget.onCommentChanged(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField(),
        SizedBox(height: 8),
        _buildCharacterCount(),
      ],
    );
  }

  Widget _buildTextField() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.gray_95,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _controller,
        maxLines: 5,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          hintText: '감사하거나 칭찬하고 싶은 말을 자유롭게 적어주세요!',
          hintStyle: CustomText.Body_Light_M_14.copyWith(
            color: CustomColor.gray_50,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
          counterText: '', // 기본 카운터 텍스트 숨김
        ),
        style: CustomText.Body_Light_M_14,
      ),
    );
  }

  Widget _buildCharacterCount() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        '$_currentLength/${widget.maxLength}',
        style: CustomText.Body_Light_XS_12.copyWith(
          color:
              _currentLength > widget.maxLength * 0.9
                  ? CustomColor.primary_60
                  : CustomColor.gray_50,
        ),
      ),
    );
  }
}
