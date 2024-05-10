import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

import '../../../resources/values_manager.dart';

class NoContent extends StatelessWidget {
  const NoContent({super.key, required this.content});
final String content;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppPadding.p16),
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ColorManager.grey,width: AppSize.s8)
            ),
            child:
            SvgPicture.asset(
              SVGAssets.noMessage,
              width: AppSize.s50,
              height: AppSize.s50,
            ),
          ),
          Text(content,style: AppTextStyles.chatNoMessageTextStyle(context),)
        ],
      ),
    );
  }
}
