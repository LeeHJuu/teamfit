import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/presentation/viewmodels/login_view_model.dart';
import 'package:teamfit/src/presentation/views/signup/add_user_stack_page.dart';
import 'package:teamfit/src/presentation/views/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/presentation/widgets/custom_select_button.dart';
import 'package:teamfit/src/presentation/widgets/next_step_bottom_button.dart';

class AddUserRolePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddUserRolePage> createState() => _AddUserRolePageState();
}

class _AddUserRolePageState extends ConsumerState<AddUserRolePage> {
  bool _isPossible = false;

  String selectedRole = '';

  @override
  Widget build(BuildContext context) {
    List<String> userRoles = 'signin_page.user_role.items'.tr().split(',');
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SignInStepTitle('signin_page.user_role.title'.tr()),
          _userRoleTagsBox(userRoles),
          NextStepBottomButton(
            title: 'button_text.next'.tr(),
            isPossible: _isPossible,
            moveNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserStackPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _userRoleTagsBox(List<String> items) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20, // 상하 간격
            crossAxisSpacing: 10, // 좌우 간격
            mainAxisExtent: 50,
          ),
          itemCount: items.length, // 총 아이템 갯수
          itemBuilder: (context, index) {
            // return GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       selectedRole = userRoles[index];
            //       _isPossible = selectedRole.isNotEmpty;
            //     });
            //     final vm = ref.read(loginViewModel.notifier);
            //     vm.setUserRole(selectedRole);
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color:
            //           selectedRole == userRoles[index]
            //               ? Colors.amber
            //               : Colors.grey[300],
            //       borderRadius: BorderRadius.circular(50),
            //     ),
            //     child: Center(child: Text(userRoles[index])), // 텍스트 중앙 정렬
            //   ),
            // );
            return CustomSelectButton(
              title: items[index],
              textAlign: 1,
              isSelected: selectedRole == items[index],
              onPress: () {
                setState(() {
                  selectedRole = items[index];
                  _isPossible = selectedRole.isNotEmpty;
                });
                final vm = ref.read(loginViewModel.notifier);
                vm.setUserRole(selectedRole);
              },
            );
          },
        ),
      ),
    );
  }
}
