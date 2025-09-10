import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';

class CustomCarouselIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Function(int)? onTap;
  final double activeWidth;
  final double inactiveWidth;
  final double height;
  final double spacing;
  final Color activeColor;
  final Color inactiveColor;
  final Duration animationDuration;

  const CustomCarouselIndicator({
    Key? key,
    required this.itemCount,
    required this.currentIndex,
    this.onTap,
    this.activeWidth = 24.0,
    this.inactiveWidth = 12.0,
    this.height = 12.0,
    this.spacing = 4.0,
    this.activeColor = CustomColor.primary_60,
    this.inactiveColor = CustomColor.gray_90,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isActive = currentIndex == index;

        return GestureDetector(
          onTap: onTap != null ? () => onTap!(index) : null,
          child: AnimatedContainer(
            duration: animationDuration,
            curve: Curves.easeInOut,
            width: isActive ? activeWidth : inactiveWidth,
            height: height,
            margin: EdgeInsets.symmetric(horizontal: spacing),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height / 2),
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
        );
      }),
    );
  }
}
