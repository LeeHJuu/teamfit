import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:teamfit/src/presentation/views/home/pages/home_tap_page/widgets/project_preview_box.dart';

class HomeTapPage extends StatefulWidget {
  @override
  State<HomeTapPage> createState() => _HomeTapPageState();
}

class _HomeTapPageState extends State<HomeTapPage> {
  final items = [1, 2, 3, 4, 5];

  int _current = 0;

  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          carouselController: _carouselSliderController,
          options: CarouselOptions(
            height: 600,
            viewportFraction: 1.0,
            // enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items:
              items.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return ProjectPreviewBox();
                  },
                );
              }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              items.map((i) {
                return GestureDetector(
                  onTap: () => _carouselSliderController.animateToPage(i),
                  child: Container(
                    width: _current == i - 1 ? 24.0 : 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: _current == i - 1 ? Colors.black : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
