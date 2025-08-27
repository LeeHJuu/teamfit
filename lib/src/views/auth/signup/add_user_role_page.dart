import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/enums.dart';
import 'package:teamfit/src/viewmodels/login_view_model.dart';
import 'package:teamfit/src/views/auth/signup/add_user_stack_page.dart';
import 'package:teamfit/src/views/auth/signup/widgets/sign_in_step_title.dart';
import 'package:teamfit/src/widgets/custom_select_button.dart';
import 'package:teamfit/src/widgets/next_step_bottom_button.dart';

class AddUserRolePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddUserRolePage> createState() => _AddUserRolePageState();
}

class _AddUserRolePageState extends ConsumerState<AddUserRolePage> {
  bool _isPossible = false;
  UserRole? selectedRole;

  @override
  Widget build(BuildContext context) {
    List<UserRole> userRoles = UserRole.values;
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

  Widget _userRoleTagsBox(List<UserRole> items) {
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
            return CustomSelectButton(
              title: items[index].label,
              textAlign: 1,
              isSelected: selectedRole == items[index],
              onPress: () {
                setState(() {
                  selectedRole = items[index];
                  _isPossible = selectedRole != null;
                });
                final vm = ref.read(loginViewModel.notifier);
                vm.setUserRole(selectedRole!);
              },
            );
          },
        ),
      ),
    );
  }
}
