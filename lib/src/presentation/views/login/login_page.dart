import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  // _appTitleColumn(),
                  SvgPicture.asset(
                    'assets/images/main_title.svg',
                    // width: 300,
                    // height: 300,
                  ),
                  // SvgPicture.asset(
                  //   'assets/images/main_img.svg',
                  //   width: 300,
                  //   height: 300,
                  // ),
                  Image.asset(
                    'assets/images/main_img.png',
                    width: 280,
                    height: 280,
                  ),
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
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
      child: Text(
        'login.guest_login_text'.tr(),
        style: CustomText.Body_Light_M.copyWith(
          decoration: TextDecoration.underline,
          color: Colors.black,
        ),
      ),
    );
  }

  Column _appTitleColumn() {
    return Column(
      children: [
        Text(
          'app.title'.tr(),
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        Text('app.sub_title'.tr(), style: CustomText.Title_S),
      ],
    );
  }
}
