import 'package:flutter/material.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/widgets/input_box_item.dart';
import 'package:teamfit/src/widgets/shadow_box_container.dart';

class DesiredRoleBox extends StatelessWidget {
  final UserRole role;
  final int count;
  final List<String> technologies;

  const DesiredRoleBox({
    super.key,
    required this.role,
    required this.count,
    required this.technologies,
  });

  @override
  Widget build(BuildContext context) {
    return ShadowBoxContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputItem(title: '직무', body: role.label),
          CustomInputItem(title: '인원', body: '$count명'),
          CustomInputItem(
            title: '사용 기술',
            body: technologies.isEmpty ? '기술 미지정' : '',
            technologies: technologies,
          ),
        ],
      ),
    );
  }
}

class CustomInputItem extends StatelessWidget {
  final String title;
  final String body;
  final List<String>? technologies;

  const CustomInputItem({
    super.key,
    required this.title,
    required this.body,
    this.technologies,
  });

  @override
  Widget build(BuildContext context) {
    return InputBoxItem(
      title: title,
      body:
          technologies != null && technologies!.isNotEmpty
              ? SizedBox(
                width: double.infinity,
                child: Wrap(
                  children:
                      technologies!
                          .map(
                            (tech) => ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 4,
                                  bottom: 4,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                color: Colors.grey[200],
                                child: Text(
                                  tech,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              )
              : Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Center(child: Text(body)),
              ),
    );
  }
}
