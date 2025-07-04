import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  String title;
  List<String> items;

  CustomDropdownMenu({required this.title, required this.items});

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  bool isOpened = false;

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
        border: Border.all(width: 1),
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
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(items[index]),
                  ),
                ),
              ),
              if (index == items.length - 1) SizedBox(height: 8),
              if (index < items.length - 1) Divider(),
            ],
          );
        }),
      ),
    );
  }

  Container _menuTitle(void Function() onClick) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1),
      ),
      child: Row(
        children: [
          SizedBox(width: 10),
          Expanded(child: Text(widget.title)),
          IconButton(onPressed: onClick, icon: Icon(Icons.arrow_drop_down)),
        ],
      ),
    );
  }
}
