import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

enum InputFieldState {
  unselected, // 미선택 (비어있음)
  selected, // 선택됨 (비어있음, 포커스)
  typing, // 입력중 (텍스트 있음, 포커스)
  completed, // 입력완료 (텍스트 있음, 포커스 해제)
}

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final String? guideText;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool enabled;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;

  const CustomInputField({
    Key? key,
    required this.controller,
    this.label,
    this.hintText,
    this.guideText,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _isFocused = false;
  InputFieldState _currentState = InputFieldState.unselected;

  @override
  void initState() {
    super.initState();
    _updateState();
    widget.controller.addListener(_updateState);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    final hasText = widget.controller.text.isNotEmpty;

    InputFieldState newState;
    if (!_isFocused && !hasText) {
      newState = InputFieldState.unselected;
    } else if (_isFocused && !hasText) {
      newState = InputFieldState.selected;
    } else if (_isFocused && hasText) {
      newState = InputFieldState.typing;
    } else {
      newState = InputFieldState.completed;
    }

    if (mounted && _currentState != newState) {
      setState(() {
        _currentState = newState;
      });
    }
  }

  Color _getBorderColor() {
    switch (_currentState) {
      case InputFieldState.unselected:
        return CustomColor.gray_80;
      case InputFieldState.selected:
        return CustomColor.primary_60;
      case InputFieldState.typing:
        return CustomColor.primary_60;
      case InputFieldState.completed:
        return CustomColor.gray_10;
    }
  }

  Color _getTextColor() {
    switch (_currentState) {
      case InputFieldState.unselected:
        return CustomColor.gray_50;
      case InputFieldState.selected:
        return CustomColor.gray_50;
      case InputFieldState.typing:
        return CustomColor.gray_10;
      case InputFieldState.completed:
        return CustomColor.gray_10;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: CustomText.Label_Heavy_S_14.copyWith(
              color: CustomColor.gray_10,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: widget.controller,
          enabled: widget.enabled,
          maxLength: widget.maxLength,
          minLines: widget.minLines ?? 1,
          maxLines: widget.maxLines ?? 1,
          style: CustomText.Body_Light_M_14.copyWith(color: _getTextColor()),
          onTap: () {
            if (widget.onTap != null) widget.onTap!();
          },
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
          },
          onSubmitted: (value) {
            if (widget.onSubmitted != null) widget.onSubmitted!(value);
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            hintText: widget.hintText,
            hintStyle: CustomText.Body_Light_M_14.copyWith(
              color: CustomColor.gray_50,
            ),
            counterText: widget.maxLength != null ? null : '',
            suffixIcon:
                _currentState == InputFieldState.typing ||
                        _currentState == InputFieldState.completed
                    ? IconButton(
                      icon: Icon(
                        Icons.close,
                        color: CustomColor.gray_60,
                        size: 20,
                      ),
                      onPressed: () {
                        widget.controller.clear();
                        if (widget.onChanged != null) {
                          widget.onChanged!('');
                        }
                      },
                    )
                    : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: _getBorderColor(), width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: _getBorderColor(), width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CustomColor.gray_90, width: 1.0),
            ),
          ),
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
        ),
        if (widget.guideText != null) ...[
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.guideText!,
                style: CustomText.Body_Light_XS_12.copyWith(
                  color: CustomColor.gray_50,
                ),
              ),
              if (widget.maxLength != null)
                Text(
                  '${widget.controller.text.length}/${widget.maxLength}',
                  style: CustomText.Body_Light_XS_12.copyWith(
                    color: CustomColor.gray_50,
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final focusScope = FocusScope.of(context);
    focusScope.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    final newFocused = FocusScope.of(context).hasFocus;
    if (_isFocused != newFocused) {
      setState(() {
        _isFocused = newFocused;
      });
      _updateState();
    }
  }
}
