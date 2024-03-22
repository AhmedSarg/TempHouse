import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/text_styles.dart';
import '../../resources/values_manager.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.textStyle,
    this.backgroundColor = ColorManager.secondary,
    required this.onTap,

  });

  final String text;
  final TextStyle textStyle;
  final void Function() onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s30),
        color: backgroundColor,
      ),
      child: TextButton(
        onPressed: onTap,
        child: Center(
          child: FittedBox(
            child: Text(
              text,
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
