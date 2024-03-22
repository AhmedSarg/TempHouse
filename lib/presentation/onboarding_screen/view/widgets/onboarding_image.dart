import 'package:flutter/material.dart';

class OnboardingImage extends StatelessWidget {
  const OnboardingImage({Key? key, required this.onboardImage}) : super(key: key);

  final String onboardImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          onboardImage,
          width: double.infinity,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height*.7,
        ),
      ],
    );
  }
}