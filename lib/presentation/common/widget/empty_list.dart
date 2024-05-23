import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

import '../../resources/values_manager.dart';


class EmptyListItem extends StatelessWidget {
   const EmptyListItem({super.key, required this.content, required this.image, this.style});
  final String content;
  final String image;
  final TextStyle? style;
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
              image,
              width: AppSize.s60,
              height: AppSize.s60,
            ),
          ),
          Text(content,style: style,)
        ],
      ),
    );
  }
}
