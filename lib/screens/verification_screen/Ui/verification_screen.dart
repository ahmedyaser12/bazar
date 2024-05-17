import 'package:book_shop/core/widget/app_buttons.dart';
import 'package:book_shop/screens/verification_screen/Ui/widget/verify_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/common_functions.dart';
import '../../../core/utils/styles.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final userDetails = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.blackColor),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Verification Email',
                style: TextStyles.font24BlackBold(context),
              ),
              heightSpace(8),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Please enter the code we just sent to',
                        style: TextStyles.font16grey(context)),
                    // TextSpan(
                    //   text: '\n${userDetails!.email}',
                    //   style: TextStyles.font15BlackMedium,
                    // ),
                  ]),
                ),
              ),
              heightSpace(40),
              const VerifyTextField(),
              heightSpace(24),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'If you didn’t receive a code?',
                      style: TextStyles.font16grey(context),
                    ),
                    TextSpan(
                      text: ' Resend',
                      style: TextStyles.font16PrimarySemi,
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
              heightSpace(40),
              primaryButton(title: 'Continue', borderRadius: 50),
            ],
          ),
        ),
      ),
    );
  }
}
