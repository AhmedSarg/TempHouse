import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:temp_house/presentation/share_post_screen/view/widgets/share_text_field.dart';

import '../../../common/validators/validators.dart';
import '../../../common/widget/main_button.dart';
import '../../../common/widget/register_field_dialog.dart';
import '../../../map_screen/view/map_screen_share.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles.dart';
import '../../../resources/values_manager.dart';
import '../../viewmodel/share_view_model.dart';
import 'image_picker.dart';

class SharePostScreenBody extends StatelessWidget {
  const SharePostScreenBody({
    super.key,
    required this.viewModel,
    required this.formKey,
    required this.titleFocusNode,
    required this.priceFocusNode,
    required this.locationFocusNode,
    required this.categoryFocusNode,
    required this.conditionFocusNode,
    required this.descriptionFocusNode,
    required this.bedFocusNode,
    required this.wifiFocusNode,
    required this.bathroomFocusNode,
    required this.areaFocusNode,
  });

  final ShareViewModel viewModel;

  final GlobalKey<FormState> formKey;

  final FocusNode titleFocusNode;

  final FocusNode priceFocusNode;

  final FocusNode locationFocusNode;

  final FocusNode categoryFocusNode;

  final FocusNode conditionFocusNode;

  final FocusNode descriptionFocusNode;

  final FocusNode bedFocusNode;

  final FocusNode wifiFocusNode;

  final FocusNode bathroomFocusNode;

  final FocusNode areaFocusNode;


  static final categoryList = [
    AppStrings.categoryDaily.tr(),
    AppStrings.categoryMonthly.tr(),
    AppStrings.categoryYearly.tr(),
  ];
  static final wifiServices = [
    AppStrings.wifiServicesNo.tr(),
    AppStrings.wifiServicesYes.tr(),
  ];
  static final conditionList = [
    AppStrings.conditionBad.tr(),
    AppStrings.conditionGood.tr(),
    AppStrings.conditionVeryGood.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p10,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImagePickerField(
                    viewModel: viewModel,
                    onImagePicked: (image) {
                      if (viewModel.getImages.length <= 10) {
                        viewModel.addImage = File(image);
                      }
                    },
                  ),
                  const SizedBox(height: AppSize.s5),
                  Text(
                    '${AppStrings.addPhotosDescription1.tr()} ${viewModel.getImages.length}${AppStrings.addPhotosDescription2.tr()}',
                    style: AppTextStyles.addImagesDescriptionTextStyle(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                controller: viewModel.getTitleController,
                focusNode: titleFocusNode,
                nextFocus: areaFocusNode,
                validation: AppValidators.validateText,
                isObscured: false,
                hint: AppStrings.title.tr(),
                textInputType: TextInputType.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                controller: viewModel.getAreaController,
                focusNode: areaFocusNode,
                nextFocus: priceFocusNode,
                isObscured: false,
                validation: AppValidators.validatePrice,
                hint: AppStrings.area.tr(),
                textInputType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                controller: viewModel.getPriceController,
                focusNode: priceFocusNode,
                nextFocus: categoryFocusNode,
                isObscured: false,
                validation: AppValidators.validatePrice,
                hint: AppStrings.price.tr(),
                textInputType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                controller: viewModel.getCategoryController,
                focusNode: categoryFocusNode,
                nextFocus: conditionFocusNode,
                isObscured: false,
                readOnly: true,
                surffixIcon: Icons.arrow_drop_down,
                validation: AppValidators.validateMartialStatus,
                hint: AppStrings.category.tr(),
                textInputType: TextInputType.text,
                onTap: () {
                  showRegisterDialog(
                    context,
                    onSelect: (v) {
                      viewModel.getCategoryController.text = v;
                    },
                    items: categoryList,
                    title: AppStrings.category.tr(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                controller: viewModel.getConditionController,
                focusNode: conditionFocusNode,
                nextFocus: wifiFocusNode,
                isObscured: false,
                readOnly: true,
                surffixIcon: Icons.arrow_drop_down,
                validation: AppValidators.validateMartialStatus,
                hint: AppStrings.condition.tr(),
                textInputType: TextInputType.text,
                onTap: () {
                  showRegisterDialog(
                    context,
                    onSelect: (v) {
                      viewModel.getConditionController.text = v;
                    },
                    items: conditionList,
                    title: AppStrings.condition.tr(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                controller: viewModel.getWifiController,
                focusNode: wifiFocusNode,
                nextFocus: bedFocusNode,
                isObscured: false,
                readOnly: true,
                surffixIcon: Icons.arrow_drop_down,
                validation: AppValidators.validateMartialStatus,
                hint: AppStrings.wifiServices.tr(),
                textInputType: TextInputType.text,
                onTap: () {
                  showRegisterDialog(
                    context,
                    onSelect: (v) {
                      viewModel.getWifiController.text = v;
                    },
                    items: wifiServices,
                    title: AppStrings.wifiServices.tr(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                controller: viewModel.getBedController,
                focusNode: bedFocusNode,
                nextFocus: bathroomFocusNode,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                isObscured: false,
                validation: AppValidators.validateMartialStatus,
                hint: AppStrings.numberOfbeds.tr(),
                textInputType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                controller: viewModel.getBathRoomController,
                focusNode: bathroomFocusNode,
                nextFocus: descriptionFocusNode,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                isObscured: false,
                validation: AppValidators.validateMartialStatus,
                hint: AppStrings.numberOfbathroom.tr(),
                textInputType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                minLines: 1,
                maxLines: 10,
                controller: viewModel.getDescriptionController,
                focusNode: descriptionFocusNode,
                nextFocus: locationFocusNode,
                isObscured: false,
                validation: AppValidators.validateText,
                hint: AppStrings.description.tr(),
                textInputType: TextInputType.multiline,
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: SearchTextField(
                controller: viewModel.getLocationController,
                focusNode: locationFocusNode,
                // readOnly: true,
                prefixIcon: Icons.location_on_rounded,
                surffixIconFunc: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoogleMapScreenShare(viewModel: viewModel),
                    ),
                  );

                },
                readOnly: true,
                nextFocus: locationFocusNode,
                isObscured: false,
                validation: AppValidators.validateText,
                hint: AppStrings.location.tr(),
                textInputType: TextInputType.multiline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p30),
              child: MainButton(
                text: AppStrings.publish.tr(),
                textStyle: AppTextStyles.sharePostBtnTextStyle(context),
                onTap: publish,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void publish() {
    print(viewModel.getImages.length);
    if (formKey.currentState!.validate()) {
      viewModel.sharePost();
    }
  }
}