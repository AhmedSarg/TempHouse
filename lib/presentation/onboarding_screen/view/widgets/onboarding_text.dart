import 'package:flutter/material.dart';
import '../../../common/widget/main_button.dart';
import '../../../resources/text_styles.dart';

class OnboardingText extends StatelessWidget {
  const OnboardingText({
    Key? key,
    required this.btnName,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String btnName;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: AppTextStyles.onBoardingTextStyle(context),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        MainButton(
          onTap: () {
            onPressed();
          },
          text: btnName,
          textStyle: AppTextStyles.onBoardingButtonTextStyle(context),
        ),
        const Spacer(),
      ],
    );
  }
}
