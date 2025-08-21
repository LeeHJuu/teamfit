import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/viewmodels/login_view_model.dart';
import 'package:teamfit/src/views/home/pages/home_tap_page/widgets/project_preview_box.dart';
import 'package:teamfit/src/views/project/project_page.dart';
import 'package:teamfit/src/views/personality_test/personality_test_alert.dart';

class HomeTapPage extends ConsumerStatefulWidget {
  const HomeTapPage({super.key});

  @override
  ConsumerState<HomeTapPage> createState() => _HomeTapPageState();
}

class _HomeTapPageState extends ConsumerState<HomeTapPage> {
  final items = [1, 2, 3, 4, 5];
  // final items = [];

  int _current = 0;
  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final loginState = ref.read(loginViewModel);
    return loginState?.detailData?.personalityType == null
        ? PersonalityTestAlert()
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_carouselSlider(), _carouselNavigator()],
        );
  }

  Row _carouselNavigator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          items.map((i) {
            return GestureDetector(
              onTap: () => _carouselSliderController.animateToPage(i - 1),
              child: Container(
                width: _current == i - 1 ? 24.0 : 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _current == i - 1 ? Colors.black : Colors.grey,
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _carouselSlider() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProjectPage();
            },
          ),
        );
      },
      child: CarouselSlider(
        carouselController: _carouselSliderController,
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.7,
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
    );
  }
}
