import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

enum SearchBarState {
  unselected, // 미선택 (비어있음)
  selected, // 선택됨 (비어있음, 포커스)
  typing, // 입력중 (텍스트 있음, 포커스)
  completed, // 입력완료 (텍스트 있음, 포커스 해제)
}

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final Function()? onSearchPressed;
  final bool enabled;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onSearchPressed,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool _isFocused = false;
  SearchBarState _currentState = SearchBarState.unselected;

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

    SearchBarState newState;
    if (!_isFocused && !hasText) {
      newState = SearchBarState.unselected;
    } else if (_isFocused && !hasText) {
      newState = SearchBarState.selected;
    } else if (_isFocused && hasText) {
      newState = SearchBarState.typing;
    } else {
      newState = SearchBarState.completed;
    }

    if (mounted && _currentState != newState) {
      setState(() {
        _currentState = newState;
      });
    }
  }

  Color _getBorderColor() {
    switch (_currentState) {
      case SearchBarState.unselected:
        return CustomColor.gray_80;
      case SearchBarState.selected:
        return CustomColor.primary_60;
      case SearchBarState.typing:
        return CustomColor.primary_60;
      case SearchBarState.completed:
        return CustomColor.gray_10;
    }
  }

  Color _getTextColor() {
    switch (_currentState) {
      case SearchBarState.unselected:
        return CustomColor.gray_50;
      case SearchBarState.selected:
        return CustomColor.gray_50;
      case SearchBarState.typing:
        return CustomColor.gray_10;
      case SearchBarState.completed:
        return CustomColor.gray_10;
    }
  }

  Color _getIconColor() {
    switch (_currentState) {
      case SearchBarState.unselected:
        return CustomColor.gray_60;
      case SearchBarState.selected:
        return CustomColor.primary_60;
      case SearchBarState.typing:
        return CustomColor.primary_60;
      case SearchBarState.completed:
        return CustomColor.gray_60;
    }
  }

  Widget _buildSuffixIcon() {
    if (_currentState == SearchBarState.typing ||
        _currentState == SearchBarState.completed) {
      return IconButton(
        icon: Icon(Icons.close, color: CustomColor.gray_60, size: 20),
        onPressed: () {
          widget.controller.clear();
          if (widget.onChanged != null) {
            widget.onChanged!('');
          }
        },
      );
    } else {
      return IconButton(
        icon: Icon(Icons.search, color: _getIconColor(), size: 24),
        onPressed: () {
          if (widget.onSearchPressed != null) {
            widget.onSearchPressed!();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      enabled: widget.enabled,
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
        hintText: widget.hintText ?? '찾으시는 팀프로젝트를 입력해주세요',
        hintStyle: CustomText.Body_Light_M_14.copyWith(
          color: CustomColor.gray_50,
        ),
        suffixIcon: _buildSuffixIcon(),
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
