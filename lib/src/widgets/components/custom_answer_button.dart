import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

enum AnswerButtonState {
  unselected, // 미선택 상태
  selected, // 선택된 상태
  pressed, // 눌림 상태 (애니메이션)
}

class CustomAnswerButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isSelected;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const CustomAnswerButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isSelected = false,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  State<CustomAnswerButton> createState() => _CustomAnswerButtonState();
}

class _CustomAnswerButtonState extends State<CustomAnswerButton>
    with SingleTickerProviderStateMixin {
  AnswerButtonState _currentState = AnswerButtonState.unselected;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _updateState();
  }

  @override
  void didUpdateWidget(CustomAnswerButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      _updateState();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateState() {
    final newState =
        widget.isSelected
            ? AnswerButtonState.selected
            : AnswerButtonState.unselected;

    if (_currentState != newState) {
      setState(() {
        _currentState = newState;
      });
    }
  }

  Color _getBackgroundColor() {
    switch (_currentState) {
      case AnswerButtonState.unselected:
        return CustomColor.gray_95;
      case AnswerButtonState.selected:
        return CustomColor.primary_90;
      case AnswerButtonState.pressed:
        return CustomColor.primary_60;
    }
  }

  Color _getBorderColor() {
    switch (_currentState) {
      case AnswerButtonState.unselected:
        return Colors.transparent;
      case AnswerButtonState.selected:
        return CustomColor.primary_60;
      case AnswerButtonState.pressed:
        return CustomColor.primary_60;
    }
  }

  Color _getTextColor() {
    switch (_currentState) {
      case AnswerButtonState.unselected:
        return CustomColor.gray_10;
      case AnswerButtonState.selected:
        return CustomColor.primary_60;
      case AnswerButtonState.pressed:
        return Colors.white;
    }
  }

  void _handlePress() {
    if (widget.onPressed == null) return;

    // 눌림 애니메이션 시작
    setState(() {
      _currentState = AnswerButtonState.pressed;
    });

    _animationController.forward();

    // 300ms 후 원래 상태로 돌아가고 콜백 실행
    Future.delayed(const Duration(milliseconds: 300), () {
      _animationController.reverse();
      _updateState();
      widget.onPressed!();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          widget.margin ??
          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: _getBackgroundColor(),
          side: BorderSide(
            color: _getBorderColor(),
            width: _currentState == AnswerButtonState.selected ? 1.5 : 1.0,
          ),
          foregroundColor: _getTextColor(),
          padding:
              widget.padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        onPressed: _handlePress,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.text,
            style: CustomText.Label_Light_S_14.copyWith(color: _getTextColor()),
          ),
        ),
      ),
    );
  }
}
