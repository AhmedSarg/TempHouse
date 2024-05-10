import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';

import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/routes_manager.dart';
import '../../../../../resources/text_styles.dart';
import '../../../../../resources/values_manager.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(.3),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            width: AppSize.s50,
            height: AppSize.s50,
            child: Image.asset(ImageAssets.personImage),
          ),
          const SizedBox(width: AppSize.s10),
          SvgPicture.asset(SVGAssets.pin),
          const SizedBox(width: AppSize.s10),
          Expanded(
            child: Text(
              DataIntent.getUser().name,
              style: AppTextStyles.mainAppBarText(context),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.chatsRoute);
            },
            icon: SvgPicture.asset(SVGAssets.chat),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.notificationsRoute);
            },
            icon: SvgPicture.asset(SVGAssets.bell),
          )
        ],
      ),
    );
  }
}
