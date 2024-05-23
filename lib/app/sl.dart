import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_house/data/network/fireauth_factory.dart';
import 'package:temp_house/domain/usecase/share_post_usecase.dart';

import '../data/data_source/cache_data_source.dart';
import '../data/data_source/local_data_source.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/data_source/runtime_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/app_prefs.dart';
import '../data/network/assets_loader.dart';
import '../data/network/dio_factory.dart';
import '../data/network/firestorage_factory.dart';
import '../data/network/firestore_factory.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/add_payment_card_usecase.dart';
import '../domain/usecase/add_to_favorites_usecase.dart';
import '../domain/usecase/change_account_info_usecase.dart';
import '../domain/usecase/get_all_favorites_usecase.dart';
import '../domain/usecase/get_all_homes_usecase.dart';
import '../domain/usecase/get_current_user_usecase.dart';
import '../domain/usecase/login_usecase.dart';
import '../domain/usecase/register_usecase.dart';
import '../domain/usecase/remove_from_favorites_usecase.dart';
import '../domain/usecase/report_home_usecase.dart';
import 'date_ntp.dart';

final sl = GetIt.instance;

Future<void> initAppModule() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<DateNTP>(() => DateNTPImpl());
  sl.registerLazySingleton<AppPrefs>(() => AppPrefsImpl(sharedPreferences));

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnection()));

  // sl.registerLazySingleton<GSheetFactory>(() => GSheetFactoryImpl());

  sl.registerLazySingleton<AssetsLoader>(() => AssetsLoaderImpl());

  var dio = await DioFactory().getDio();
  sl.registerLazySingleton<Dio>(() => dio);

  var firestore = await FirestoreFactoryImpl().create();
  sl.registerLazySingleton<FirebaseFirestore>(() => firestore);

  var fireAuth = await FireAuthFactoryImpl().create();
  sl.registerLazySingleton<FirebaseAuth>(() => fireAuth);

  var fireStorage = await FireStorageFactoryImpl().create();
  sl.registerLazySingleton<FirebaseStorage>(() => fireStorage);

  sl.registerLazySingleton<AppServiceClient>(() => AppServiceClientImpl(sl()));
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(sl(), sl(), sl()));
  sl.registerLazySingleton<RuntimeDataSource>(() => RuntimeDataSourceImpl());
  sl.registerLazySingleton<CacheDataSource>(
    () => CacheDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(sl()));

  sl.registerLazySingleton<Repository>(() => RepositoryImpl(sl(), sl(), sl()));
}

void initGetCurrentUserUseCase() {
  if (GetIt.instance.isRegistered<GetCurrentUserUseCase>() == false) {
    sl.registerFactory<GetCurrentUserUseCase>(
        () => GetCurrentUserUseCase(sl()));
  }
}

void initRegisterUseCase() {
  if (GetIt.instance.isRegistered<RegisterUseCase>() == false) {
    sl.registerFactory<RegisterUseCase>(() => RegisterUseCase(sl()));
  }
}

void initLoginUseCase() {
  if (GetIt.instance.isRegistered<LoginUseCase>() == false) {
    sl.registerFactory<LoginUseCase>(() => LoginUseCase(sl()));
  }
}

void initSharePostUseCase() {
  if (GetIt.instance.isRegistered<SharePostUseCase>() == false) {
    sl.registerFactory<SharePostUseCase>(() => SharePostUseCase(sl()));
  }
}

void initGetAllHomesUseCase() {
  if (GetIt.instance.isRegistered<GetAllHomesUseCase>() == false) {
    sl.registerFactory<GetAllHomesUseCase>(() => GetAllHomesUseCase(sl()));
  }
}

void initAddToFavoritesUseCase() {
  if (GetIt.instance.isRegistered<AddToFavoritesUseCase>() == false) {
    sl.registerFactory<AddToFavoritesUseCase>(
        () => AddToFavoritesUseCase(sl()));
  }
}

void initRemoveFromFavoritesUseCase() {
  if (GetIt.instance.isRegistered<RemoveFromFavoritesUseCase>() == false) {
    sl.registerFactory<RemoveFromFavoritesUseCase>(
        () => RemoveFromFavoritesUseCase(sl()));
  }
}

void initGetAllFavoritesUseCase() {
  if (GetIt.instance.isRegistered<GetAllFavoritesUseCase>() == false) {
    sl.registerFactory<GetAllFavoritesUseCase>(
        () => GetAllFavoritesUseCase(sl()));
  }
}

void initReportHomeUseCase() {
  if (GetIt.instance.isRegistered<ReportHomeUseCase>() == false) {
    sl.registerFactory<ReportHomeUseCase>(() => ReportHomeUseCase(sl()));
  }
}

void initChangeAccountInfoUseCase() {
  if (GetIt.instance.isRegistered<ChangeAccountInfoUseCase>() == false) {
    sl.registerFactory<ChangeAccountInfoUseCase>(
        () => ChangeAccountInfoUseCase(sl()));
  }
}

void initAddPaymentCardUseCase() {
  if (GetIt.instance.isRegistered<AddPaymentCardUseCase>() == false) {
    sl.registerFactory<AddPaymentCardUseCase>(
        () => AddPaymentCardUseCase(sl()));
  }
}
