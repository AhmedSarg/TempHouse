import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:temp_house/app/extensions.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/widgets/near_by_home_item.dart';
import 'package:temp_house/presentation/main_layout/viewmodel/main_layout_viewmodel.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/font_manager.dart';
import 'package:temp_house/presentation/resources/styles_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../../../../domain/models/domain.dart';
import '../../../home_details/home_details.dart';

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({super.key});

  static late MainLayoutViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = MainLayoutViewModel.get(context);
    return StreamBuilder<List<Future<HomeModel>>>(
      stream: _viewModel.getFavouriteHomesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorManager.offwhite,
            ),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(LottieAssets.error, width: context.width() * .4),
                const SizedBox(height: AppSize.s10),
                Text(
                  'Error: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: getSemiBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.f16,
                  ),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p40),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    LottieAssets.noContent,
                    repeat: false,
                    width: context.width() * .6,
                  ),
                  const SizedBox(height: AppSize.s10),
                  Text(
                    'You Don\'t Have any Favorite Items',
                    style: getSemiBoldStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.f16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: snapshot.data![index],
              builder: (context, futureHome) {
                if (futureHome.hasData) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeDetailsScreen(
                            home: futureHome.data!,
                          ),
                        ),
                      );
                    },
                    child: NearByHomeItem(
                      home: futureHome.data!,
                    ),
                  );
                } else if (futureHome.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(AppPadding.p40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          LottieAssets.error,
                          repeat: false,
                          width: context.width() * .4,
                        ),
                        const SizedBox(height: AppSize.s10),
                        Text(
                          'Error: ${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: getSemiBoldStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.f16,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.offwhite,
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
