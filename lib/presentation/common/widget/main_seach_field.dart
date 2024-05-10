import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/text_styles.dart';

class MainSearch extends StatelessWidget {
  const MainSearch({
    Key? key,
    required this.hintText,
    required this.leadingIcon,
    required this.trailingIcon,
    this.controller,
    this.onSubmit, this.onChanged,
  }) : super(key: key);

  final String hintText;
  final IconData leadingIcon;
  final Widget trailingIcon;
  final TextEditingController? controller;
  final Function? onSubmit;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.offwhite.withOpacity(.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        cursorColor: ColorManager.white,
        onChanged: onChanged,
        onSubmitted: (value) {
          if (onSubmit != null) {
            onSubmit!(value);
          }
        },
        style: AppTextStyles.searchTextStyle(context),
        decoration: InputDecoration(
          prefixIcon: Icon(leadingIcon),
          prefixIconColor: ColorManager.offwhite.withOpacity(.86),
          suffixIcon: trailingIcon,
          suffixIconColor: ColorManager.offwhite.withOpacity(.86),
          hintText: hintText,
          hintStyle: AppTextStyles.searchHintTextStyle(context),
          border: InputBorder.none,
          fillColor: Colors.transparent,
          filled: false,
        ),
      ),
    );
  }
}
