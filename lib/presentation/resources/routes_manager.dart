import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/app/sl.dart';
import 'package:temp_house/presentation/homes_map_screen/view/homes_map_view.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/all_nearby_home.dart';
import 'package:temp_house/presentation/main_layout/pages/home_screen/view/all_popular_home.dart';
import 'package:temp_house/presentation/main_layout/pages/profile_screen/view/pages/view/personal_info_page_view.dart';
import 'package:temp_house/presentation/main_layout/view/main_layout_view.dart';
import 'package:temp_house/presentation/search_screen/view/search_screen.dart';

import '../chat_screen/view/chat_view.dart';
import '../chats_screen/view/chats_view.dart';
import '../login_screen/view/login_view.dart';
import '../main_layout/pages/notifications_screen/view/notifications_view.dart';
import '../main_layout/pages/profile_screen/view/about_screen.dart';
import '../main_layout/pages/profile_screen/view/need_help_screen.dart';
import '../main_layout/pages/profile_screen/view/payment_screen.dart';
import '../map_screen/view/map_screen.dart';
import '../map_screen/view/map_screen_share.dart';
import '../onboarding_screen/view/onboarding_view.dart';
import '../payment_details/view/payment_details_view.dart';
import '../register_screen/view/register_view.dart';
import '../selection_screen/selection_view.dart';
import '../share_post_screen/view/share_post_screen.dart';
import '../splash_screen/view/splash_view.dart';
import 'strings_manager.dart';

class Routes {
  Routes._();

  static const String splashRoute = "/splash";
  static const String onboardingRoute = "/onboarding";
  static const String selectionRoute = "/selection";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String notificationsRoute = "/notifications";
  static const String mainLayoutRoute = "/mainLayout";
  static const String homeDetailsRoute = "/homeDetails";
  static const String chatsRoute = "/chats";
  static const String chatRoute = "/chat";
  static const String publishHomePostRoute = "/PublishHomePost";
  static const String allPopularHomesRoute = "/allPopularHome";
  static const String allNearByHomesRoute = "/allNearByHomesHome";
  static const String searchScreenRoute = "/searchScreen";
  static const String aboutScreenRoute = "/aboutScreen";
  static const String needHelpScreenRoute = "/needHelpScreen";
  static const String googleMapScreenRoute = "/googleMapScreen";
  static const String paymentScreenRoute = "/paymentScreen";
  static const String paymentScreenDetailsRoute = "/paymentScreenDetails";
  static const String personalInfoRoute = "/personalInfo";
  static const String addUsersRoute = "/addUsers";
  static const String googleMapScreenShareRoute = "/googleMapScreenShare";
  static const String homesMapRoute = "/homesMap";
}

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        initGetCurrentUserUseCase();
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.selectionRoute:
        return MaterialPageRoute(builder: (_) => const SelectionScreen());
      case Routes.loginRoute:
        initLoginUseCase();
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.registerRoute:
        initRegisterUseCase();
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.mainLayoutRoute:
        initAddToFavoritesUseCase();
        initRemoveFromFavoritesUseCase();
        initGetAllFavoritesUseCase();
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());
      case Routes.chatsRoute:
        return MaterialPageRoute(builder: (_) => ChatsScreen());
      case Routes.notificationsRoute:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case Routes.chatRoute:
        return MaterialPageRoute(
          builder: (_) => const ChatScreen(
            receiveEmail: '',
            receiveID: '',
            chatID: '',
          ),
        );
      case Routes.publishHomePostRoute:
        initSharePostUseCase();
        return MaterialPageRoute(builder: (_) => const SharePostScreen());
      case Routes.allPopularHomesRoute:
        return MaterialPageRoute(builder: (_) => const AllPopularHome());
      case Routes.allNearByHomesRoute:
        return MaterialPageRoute(builder: (_) => const AllNearByHome());
      case Routes.searchScreenRoute:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case Routes.aboutScreenRoute:
        return MaterialPageRoute(builder: (_) => AboutScreen());
      case Routes.needHelpScreenRoute:
        return MaterialPageRoute(builder: (_) => NeedHelpScreen());
      case Routes.googleMapScreenRoute:
        return MaterialPageRoute(builder: (_) => const GoogleMapScreen());
      case Routes.googleMapScreenShareRoute:
        return MaterialPageRoute(builder: (_) => const GoogleMapScreenShare());
      case Routes.paymentScreenRoute:
        return MaterialPageRoute(builder: (_) => const PaymentScreen());
      case Routes.paymentScreenDetailsRoute:
        initAddPaymentCardUseCase();
        return MaterialPageRoute(builder: (_) => const PaymentScreenDetails());
      case Routes.personalInfoRoute:
        initChangeAccountInfoUseCase();
        return MaterialPageRoute(builder: (_) => const PersonalInfoPage());
      case Routes.homesMapRoute:
        initGetAllHomesUseCase();
        initReportHomeUseCase();
        return MaterialPageRoute(builder: (_) => const HomesMapScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.noRouteFound.tr()),
        ),
        body: Center(child: Text(AppStrings.noRouteFound.tr())),
      ),
    );
  }
}
