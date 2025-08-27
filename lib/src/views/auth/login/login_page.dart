import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'package:teamfit/src/viewmodels/login_view_model.dart';
import 'package:teamfit/src/views/auth/login/widgets/login_button_column.dart';
import 'package:teamfit/src/views/home/home_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginVM = ref.read(loginViewModel.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  SvgPicture.asset('assets/images/main_title.svg'),
                  Image.asset('assets/images/main_img.png', width: 250),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: LoginButtonColumn(loginVM: loginVM),
            ),
            _guestLoginButton(context),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  TextButton _guestLoginButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
            settings: RouteSettings(name: "/"),
          ),
        );
      },
      child: Text(
        'login.guest_login_text'.tr(),
        style: CustomText.Body_Light_M_14.copyWith(
          decoration: TextDecoration.underline,
          color: Colors.black,
        ),
      ),
    );
  }
}
