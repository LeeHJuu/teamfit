import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/presentation/viewmodels/login_view_model.dart';
import 'package:teamfit/src/presentation/views/home/home_page.dart';
import 'package:teamfit/src/presentation/views/login/widgets/login_button_column.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginVM = ref.read(loginViewModel.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Text('소셜 로그인', style: CustomText.Title_S),
            // newMethod(loginVM, context, ref),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 27),
              child: LoginButtonColumn(loginVM: loginVM),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text(
                '이메일로 로그인',
                style: CustomText.Body_Light_M.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
