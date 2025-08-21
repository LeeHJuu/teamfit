import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/views/home/pages/home_tap_page/widgets/project_schedule_preview.dart';
import 'package:teamfit/src/widgets/rounded_container.dart';

class ProjectSchedulePreviewBox extends StatelessWidget {
  const ProjectSchedulePreviewBox({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      background: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 60),
          _leftScheduleAlarm(context),
          ProjectSchedulePreview(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {},
                child: Text('button_text.record_work'.tr()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _leftScheduleAlarm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.all(20),
      // height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black12, width: 1),
        // color: Colors.black26,
      ),
      child: Row(
        children: [
          Text(
            'home_page.schedule_count_message'.tr(args: ['2']),
            style: CustomText.Label_Light_M_16,
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
