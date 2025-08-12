import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/viewmodels/login_view_model.dart';
import 'package:teamfit/src/presentation/views/signup/add_user_goal_page.dart';
import 'package:teamfit/src/presentation/views/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/presentation/widgets/custom_dropdown_menu.dart';
import 'package:teamfit/src/presentation/widgets/custom_text_field.dart';
import 'package:teamfit/src/presentation/widgets/input_box_item.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddUserStackPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddUserStackPage> createState() => _AddUserStackPageState();
}

class _AddUserStackPageState extends ConsumerState<AddUserStackPage> {
  bool _isPossible = false;

  final TextEditingController _userStackTextController =
      TextEditingController();
  List<String> userStacks = [];
  String? selectedCareer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SignInStepTitle('signin_page.user_stack.title'.tr()),
          _infomationInputBox(),
          NextStepBottomButton(
            title: 'button_text.next'.tr(),
            isPossible: _isPossible,
            moveNext: () {
              final vm = ref.read(loginViewModel.notifier);
              vm.setUserStack(selectedCareer!, userStacks);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserGoalPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _infomationInputBox() {
    return Expanded(child: ListView(children: [userCareer(), userStack()]));
  }

  InputBoxItem userStack() {
    return InputBoxItem(
      title: 'signin_page.user_stack.stack.title'.tr(),
      body: Column(
        children: [
          CustomTextField(
            textController: _userStackTextController,
            hintText: 'signin_page.user_stack.stack.hint_text'.tr(),
            onSubmit: () {
              setState(() {
                userStacks.add(_userStackTextController.text.trim());
                _userStackTextController.clear();
              });
            },
          ),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 5,
              runSpacing: -5,
              children:
                  userStacks.map((e) {
                    return Chip(
                      backgroundColor: CustomColor.gray_90,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text(
                        e,
                        style: CustomText.Label_Heavy_XS_12.copyWith(
                          color: CustomColor.gray_10,
                        ),
                      ),
                      deleteIcon: Icon(Icons.close, size: 18),
                      onDeleted: () {
                        setState(() {
                          userStacks.remove(e);
                        });
                      },
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  InputBoxItem userCareer() {
    return InputBoxItem(
      title: 'signin_page.user_stack.career.title'.tr(),
      body: CustomDropdownMenu(
        title: 'signin_page.user_stack.career.non_select'.tr(),
        items: 'signin_page.user_stack.career.items'.tr().split(","),
        selectedItem: selectedCareer,
        onSelect: (value) {
          setState(() {
            selectedCareer = value;
            _isPossible = selectedCareer != null;
          });
        },
      ),
    );
  }
}
