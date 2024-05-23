import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    this.controller,
    required this.focusNode,
    required this.nextFocus,
    this.label,
    required this.hint,
    this.isObscured = false,
    this.prefixIcon,
    this.textInputType = TextInputType.text,
    this.backgroundColor,
    this.hintTextStyle,
    this.labelTextStyle,
    this.cursorColor = ColorManager.white,
    this.readOnly = false,
    this.validation,
    this.onTap,
    this.surffixIcon,
    this.surffixIconFunc,
    this.initialValue,
    this.inputFormatters,
    this.minLines,
    this.maxLines,
  });

  final TextEditingController? controller;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final bool isObscured;
  final String? label;
  final String hint;
  final int? minLines;

  final int? maxLines;

  final String? initialValue;
  final TextInputType textInputType;
  final IconData? prefixIcon;
  final IconData? surffixIcon;
  final void Function()? surffixIconFunc;
  final List<TextInputFormatter>? inputFormatters;
  final Color? backgroundColor;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color cursorColor;
  final bool readOnly;
  final String? Function(String?)? validation;
  final void Function()? onTap;

  @override
  State<SearchTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<SearchTextField> {
  late bool hidden = widget.isObscured;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          initialValue: widget.initialValue,
          inputFormatters: widget.inputFormatters,
          controller: widget.controller,
          focusNode: widget.focusNode,
          readOnly: widget.readOnly,
          style:
              widget.hintTextStyle ?? AppTextStyles.authHintTextStyle(context),
          obscureText: hidden,
          keyboardType: widget.textInputType,
          obscuringCharacter: '*',
          cursorColor: widget.cursorColor,
          onTap: widget.onTap,
          onEditingComplete: () {
            widget.focusNode?.unfocus();
            if (widget.nextFocus != null) {
              FocusScope.of(context).requestFocus(widget.nextFocus);
            }
          },
          textInputAction: widget.nextFocus == null
              ? TextInputAction.done
              : TextInputAction.next,
          validator: (value) {
            if (widget.validation == null) {
              setState(() {
                errorText = null;
              });
            } else {
              setState(() {
                errorText = widget.validation!(value);
              });
            }
            return errorText;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(AppPadding.p12),
            hintText: widget.hint,
            prefixIcon: IconButton(
              onPressed: widget.surffixIconFunc,
              icon: Icon(
                widget.prefixIcon,
                color: Colors.white,
                size: 30,
              ),
            ),
            suffixIcon: Icon(
              widget.surffixIcon,
              color: Colors.white,
              size: 30,
            ),
            hintStyle: widget.hintTextStyle ??
                AppTextStyles.sharePostTextStyle(context),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorManager.grey, style: BorderStyle.solid)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorManager.grey, style: BorderStyle.solid)),
            errorStyle: const TextStyle(
              fontSize: AppSize.s0,
              color: ColorManager.transparent,
            ),
          ),
        ),
        errorText == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p8,
                  left: AppPadding.p8,
                ),
                child: Text(
                  errorText!,
                  style: AppTextStyles.authErrorTextStyle(context),
                ),
              ),
      ],
    );
  }
}
