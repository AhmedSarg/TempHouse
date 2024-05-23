import 'package:flutter/material.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';

class MeasurementSelectionModal {
  void show(BuildContext context, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildMeasurementSelectionModal(context, onSelect);
      },
    );
  }

  Widget _buildMeasurementSelectionModal(
      BuildContext context, Function(String) onSelect) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p22),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: AppSize.s4,
              width: AppPadding.p40,
              decoration: BoxDecoration(
                  color: ColorManager.grey,
                  borderRadius: BorderRadius.circular(AppSize.s20)),
            ),
          ),
          SizedBox(
            height: AppSize.s20,
          ),
          Text('Measurement System',
              style: AppTextStyles.profileSettingTextStyle(context)),
          GestureDetector(
            onTap: () {
              onSelect('Metric (m^2 , Km)');
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p22),
              child: Text('Metric (m^2 , Km)',
                  style: AppTextStyles.profileSettingInfoTextStyle(context)),
            ),
          ),
          GestureDetector(
            onTap: () {
              onSelect('Imperial (Ft^2 , mi)');
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p22),
              child: Text('Imperial (Ft^2 , mi)',
                  style: AppTextStyles.profileSettingInfoTextStyle(context)),
            ),
          ),
        ],
      ),
    );
  }
}
