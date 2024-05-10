import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';
import 'app/app.dart';
import 'app/sl.dart';
import 'domain/models/domain.dart';
import 'firebase_options.dart';
import 'main_test.dart';
import 'presentation/base/bloc_observer.dart';
import 'presentation/resources/langauge_manager.dart';

late final WidgetsBinding engine;

void main() async {

  engine = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await (await SharedPreferences.getInstance()).clear();

  await initAppModule();

  //TODO: remove on release
  //Created by youssef samy
  // if (kDebugMode) {
  //   test();
  // }

 // DataIntent.pushUser(
  //   User(
  //     uid: "895ffe04-c9f3-41f1-b6e7-ebf085305636"
  //     ,
  //     email: 'abdalla1@gmail.com',
  //     name: 'Abdalla',
  //   ),
  // );

    DataIntent.pushUser(
      User(
        uid: '61094440-d2e0-4a4b-8103-3404a5036b2a',
        email: 'xsarg22@gmail.com',
        name: 'Ahmed',
      ),
    );

   // DataIntent.pushUser(
   //   User(
   //     uid: 'PQcEzxNiz6yPMkdZKo6C',
   //     email: "salma@gmail.com",
   //     name: 'Salma ',
   //   ),
   // );

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
