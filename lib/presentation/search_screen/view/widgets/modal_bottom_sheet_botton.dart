import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

class modalBottomSheetBotton extends StatelessWidget {
  const modalBottomSheetBotton({super.key, this.onPressed, required this.btName, required this.backGroundColor, required this.btNameColor});
  final Function()? onPressed;
  final String btName;
  final Color btNameColor;
  final Color backGroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s40,
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(color: Colors.black)
      ),
      child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backGroundColor,
          elevation: 0
        ),
        child: Text(
          btName,
          style: AppTextStyles.modalBottomSheetBottonTextStyle(
            context,
            btNameColor,
          ),
        ),
      ),
    );
  }
}
