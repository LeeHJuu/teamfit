import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';

class CustomDropdownMenu extends StatefulWidget {
  String title;
  List<String> items;

  CustomDropdownMenu({required this.title, required this.items});

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  bool isOpened = false;
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _menuTitle(() {
          setState(() {
            isOpened = !isOpened;
          });
        }),
        if (isOpened)
          Column(children: [SizedBox(height: 8), _menuItems(widget.items)]),
      ],
    );
  }

  Container _menuItems(List<String> items) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: CustomColor.gray_80),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          return Column(
            children: [
              if (index == 0) SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    print('${items[index]} 클릭됨');
                    setState(() {
                      selectedItem = items[index];
                      isOpened = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 16,
                    ),
                    child: Text(
                      items[index],
                      style: CustomText.Body_Light_M.copyWith(
                        color: CustomColor.gray_10,
                      ),
                    ),
                  ),
                ),
              ),
              if (index == items.length - 1) SizedBox(height: 8),
            ],
          );
        }),
      ),
    );
  }

  Widget _menuTitle(void Function() onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color:
                isOpened
                    ? CustomColor.primary_60
                    : (selectedItem != null
                        ? CustomColor.gray_10
                        : CustomColor.gray_80),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Expanded(
              child: Text(
                selectedItem ?? widget.title,
                style: CustomText.Label_Light_M.copyWith(
                  color:
                      selectedItem != null
                          ? CustomColor.gray_10
                          : (isOpened
                              ? CustomColor.gray_30
                              : CustomColor.gray_80),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
      ),
    );
  }
}
