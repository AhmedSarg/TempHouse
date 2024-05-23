import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../../resources/text_styles.dart';

class PopularRow extends StatelessWidget {
  PopularRow(
      {super.key,
      required this.startedText,
      required this.endedText,
      required this.routeName,
      required this.rowStartedcolor,
      required this.rowEndedcolor});

  String startedText;
  String endedText;
  String routeName;
  final Color rowStartedcolor;
  final Color rowEndedcolor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            startedText ?? "",
            style: AppTextStyles.popularRowStartedTextStyle(
                context, rowStartedcolor),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, routeName);
            },
            child: Text(
              endedText ?? "",
              style: AppTextStyles.popularRowEndedTextStyle(
                  context, rowEndedcolor),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
