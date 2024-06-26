import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/base/cubit_builder.dart';
import 'package:temp_house/presentation/base/cubit_listener.dart';
import 'package:temp_house/presentation/main_layout/viewmodel/main_layout_viewmodel.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';
import 'package:temp_house/presentation/search_screen/view/widgets/all_search.dart';
import 'package:temp_house/presentation/search_screen/view/widgets/cheapest_price.dart';
import 'package:temp_house/presentation/search_screen/view/widgets/latest_search.dart';
import 'package:temp_house/presentation/search_screen/view/widgets/modal_bottom_sheet_botton.dart';
import 'package:temp_house/presentation/search_screen/view/widgets/price_search.dart';

import '../../resources/constants_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  double _minValue = AppConstants.initialMinPrice;
  double _maxValue = AppConstants.initialMaxPrice;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: AppSize.s0,
        toolbarHeight: AppSize.s30,
        bottom: TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: ColorManager.grey,
          labelPadding: const EdgeInsets.symmetric(
            vertical: AppPadding.p15,
            horizontal: AppPadding.p15,
          ),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8),
            border: Border.all(
              color: ColorManager.tertiary,
              width: 1, // Border width
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          indicatorPadding:
              const EdgeInsets.symmetric(vertical: AppPadding.p15),
          controller: _tabController,
          tabs: [
            Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                child: Text(AppStrings.tapBarSearchAll.tr(),
                    style: AppTextStyles.unselectedSearchTabTextStyle(context)),
              ),
            ),
            Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                child: Text(AppStrings.tapBarSearchLatest.tr(),
                    style: AppTextStyles.unselectedSearchTabTextStyle(context)),
              ),
            ),
            Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                child: Text(AppStrings.tapBarSearchPopular.tr(),
                    style: AppTextStyles.unselectedSearchTabTextStyle(context)),
              ),
            ),
            GestureDetector(
              onTap: () {
                _tabController.index == 3
                    ? _showBottomSheet(context)
                    : _tabController.index == 3;
              },
              child: Tab(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                  child: Text(AppStrings.tapBarSearchPrice.tr(),
                      style:
                          AppTextStyles.unselectedSearchTabTextStyle(context)),
                ),
              ),
            ),
            Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                child: Text(AppStrings.tapBarSearchCheapest.tr(),
                    style: AppTextStyles.unselectedSearchTabTextStyle(context)),
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => MainLayoutViewModel()..start(),
        child: BlocConsumer<MainLayoutViewModel, BaseStates>(
          listener: (context, state) {
            baseListener(context, state);
          },
          builder: (context, state) {
            return baseBuilder(context, state, buildContent());
          },
        ),
      ),
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        const SizedBox(height: AppSize.s10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              const AllSearch(),
              const LeatestSearch(),
              const LeatestSearch(),
              PriceSearch(
                minPrice: _minValue,
                maxPrice: _maxValue,
              ),
              const CheapestSearch(),
            ],
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void _decreaseMinValue() {
              setState(() {
                _minValue = AppConstants.minRange;
                _updatePriceSearch();
              });
            }

            void _increaseMaxValue() {
              setState(() {
                _maxValue = AppConstants.maxRange;
                _updatePriceSearch();
              });
            }

            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p16, vertical: AppPadding.p30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: AppSize.s5,
                      width: AppSize.s35,
                      decoration: BoxDecoration(
                          color: ColorManager.grey,
                          borderRadius: BorderRadius.circular(AppPadding.p16)),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Text(
                    AppStrings.priceRange.tr(),
                    style: AppTextStyles.modalBottomSheetPriceTitleTextStyle(
                        context),
                  ),
                  const Divider(
                    color: ColorManager.grey,
                  ),
                  const SizedBox(height: AppSize.s20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${_minValue.toInt()} ${AppStrings.coin.tr()}',
                        style: AppTextStyles.modalBottomSheetPriceTextStyle(
                            context),
                      ),
                      Text('${_maxValue.toInt()}${AppStrings.coin.tr()}',
                          style: AppTextStyles.modalBottomSheetPriceTextStyle(
                              context)),
                    ],
                  ),
                  const SizedBox(height: AppSize.s30),
                  RangeSlider(
                    activeColor: ColorManager.cobaltRed,
                    inactiveColor: ColorManager.cobaltPink,
                    values: RangeValues(_minValue, _maxValue),
                    min: AppConstants.minRange,
                    max: AppConstants.maxRange,
                    onChanged: (RangeValues values) {
                      setState(() {
                        _minValue = values.start;
                        _maxValue = values.end;
                        _updatePriceSearch();
                      });
                    },
                  ),
                  const SizedBox(height: AppSize.s30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      modalBottomSheetBotton(
                        btName: AppStrings.minNum.tr(),
                        backGroundColor: Colors.transparent,
                        btNameColor: ColorManager.black,
                        onPressed: _decreaseMinValue,
                      ),
                      Container(
                        height: AppSize.s4,
                        width: AppSize.s35,
                        decoration: BoxDecoration(
                            color: ColorManager.grey,
                            borderRadius:
                                BorderRadius.circular(AppPadding.p16)),
                      ),
                      modalBottomSheetBotton(
                        btName: AppStrings.maxNum.tr(),
                        backGroundColor: Colors.transparent,
                        btNameColor: ColorManager.black,
                        onPressed: _increaseMaxValue,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s15,
                  ),
                  const Divider(
                    color: ColorManager.grey,
                  ),
                  const SizedBox(
                    height: AppSize.s15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      modalBottomSheetBotton(
                        btName: AppStrings.clear.tr(),
                        backGroundColor: Colors.transparent,
                        btNameColor: ColorManager.black,
                        onPressed: () {
                          setState(() {
                            _minValue = AppConstants.initialMinPrice;
                            _maxValue = AppConstants.initialMaxPrice;
                          });
                        },
                      ),
                      modalBottomSheetBotton(
                        btName: AppStrings.confirm.tr(),
                        backGroundColor: ColorManager.cobaltBlue,
                        btNameColor: ColorManager.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _updatePriceSearch() {
    setState(() {});
  }
}
