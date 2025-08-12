import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';

class InputBoxItem extends StatelessWidget {
  InputBoxItem({
    super.key,
    required this.title,
    required this.body,
    this.helpText,
  });

  String title;
  Widget body;
  String? helpText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: CustomText.Label_Light_S_14),
              if (helpText != null) ...[
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _showHelpDialog(context, helpText!),
                  child: Icon(
                    Icons.help_outline,
                    size: 18,
                    color: CustomColor.gray_60,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 8),
          body,
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context, String helpText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: CustomColor.primary_60,
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '도움말',
                      style: CustomText.Label_Light_M_16.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  helpText,
                  style: CustomText.Body_Light_M_14,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.primary_60,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      '확인',
                      style: CustomText.Body_Light_M_14.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
