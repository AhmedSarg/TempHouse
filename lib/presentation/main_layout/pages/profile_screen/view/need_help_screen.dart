import 'package:flutter/material.dart';
import 'package:temp_house/presentation/common/widget/main_button.dart';
import 'package:temp_house/presentation/common/widget/main_text_field.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

class NeedHelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.offwhite,
      appBar: AppBar(
        title: Text('Need Help?',style: AppTextStyles.profileSettingAppBarTextStyle(),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'How can we assist you?',style: AppTextStyles.profileSettingHeadQAppBarTextStyle(),
            ),
            SizedBox(height: 20),
            Text(
              'Please describe the issue or assistance you need:',
                style: AppTextStyles.profileSettingSubHeadQAppBarTextStyle()
            ),
            SizedBox(height: 10),
        MainTextField(hint: 'Type your message here...',maxLines: 3,backgroundColor: ColorManager.primary.withOpacity(.8)),
            SizedBox(height: 20),
           Center(
             child: MainButton(backgroundColor: ColorManager.primary,text: 'Submit', textStyle:AppTextStyles.profileSettingBtnTextStyle() , onTap: () {

             },),
           )
          ],
        ),
      ),
    );
  }
}
