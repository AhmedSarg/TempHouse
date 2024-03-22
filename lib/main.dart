import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'app/app.dart';
import 'app/sl.dart';
import 'main_test.dart';
import 'presentation/base/bloc_observer.dart';
import 'presentation/resources/langauge_manager.dart';

late final WidgetsBinding engine;

void main() async {
  engine = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  // await (await SharedPreferences.getInstance()).clear();

  await initAppModule();

  //TODO: remove on release
  //Created by youssef samy
  // if (kDebugMode) {
  //   test();
  // }

  runApp(
    EasyLocalization(
      supportedLocales: AppLanguages.locals,
      path: AppLanguages.translationsPath,
      fallbackLocale: AppLanguages.fallBackLocal,
      //todo save start local in storage
      startLocale: AppLanguages.startLocal,
      useOnlyLangCode: true,
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}