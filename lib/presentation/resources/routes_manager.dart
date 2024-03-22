import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../chat_screen/view/chat_view.dart';
import '../chats_screen/view/chats_view.dart';
import '../login_screen/view/login_view.dart';
import '../main_layout/pages/notifications_screen/view/notifications_view.dart';
import '../main_layout/view/main_layout_view.dart';
import '../onboarding_screen/view/onboarding_view.dart';
import '../register_screen/view/register_view.dart';
import '../selection_screen/selection_view.dart';
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
  static const String chatsRoute = "/chats";
  static const String chatRoute = "/chat";
}

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.selectionRoute:
        return MaterialPageRoute(builder: (_) => const SelectionScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.mainLayoutRoute:
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());
      case Routes.chatsRoute:
        return MaterialPageRoute(builder: (_) => const ChatsScreen());
      case Routes.notificationsRoute:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case Routes.chatRoute:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
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
