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

  List<String> userRoles = [
    '개발',
    '마케팅/광고',
    '경영/비즈니스',
    '디자인',
    '이커머스/리테일',
    'HR',
    '의료/제약/바이오',
    '금융',
    '미디어',
    '게임 기획/개발',
    '교육',
    '법률/특허',
  ];

  String selectedRole = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SignInStepTitle('나의 직무 또는 전공을\n선택해주세요.'),
          _userRoleTagsBox(),
          NextStepBottomButton(
            title: '다음',
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

  Widget _userRoleTagsBox() {
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
          itemCount: userRoles.length, // 총 아이템 갯수
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
              title: userRoles[index],
              textAlign: 1,
              isSelected: selectedRole == userRoles[index],
              onPress: () {
                setState(() {
                  selectedRole = userRoles[index];
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
