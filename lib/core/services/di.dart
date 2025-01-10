import 'package:dio/dio.dart';
import 'package:e_commerce_app/features/auth/log_in/data/login_repo_impl.dart';
import 'package:e_commerce_app/features/auth/log_in/data/remote/login_data_source.dart';
import 'package:e_commerce_app/features/auth/log_in/data/remote/login_data_source_impl.dart';
import 'package:e_commerce_app/features/auth/log_in/domain/login_repo.dart';
import 'package:e_commerce_app/features/auth/log_in/domain/usecases/login_use_case.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/controller/login_bloc.dart';
import 'package:e_commerce_app/features/auth/register/data/remote/register_data_source.dart';
import 'package:e_commerce_app/features/auth/register/domain/usecases/register_use_case.dart';
import 'package:e_commerce_app/features/auth/register/domain/register_repo.dart';
import 'package:e_commerce_app/features/auth/register/presentation/controller/register_bloc.dart';
import 'package:e_commerce_app/features/home/data/home_repo_impl.dart';
import 'package:e_commerce_app/features/home/data/remote/home_data_source.dart';
import 'package:e_commerce_app/features/home/data/remote/home_data_source_impl.dart';
import 'package:e_commerce_app/features/home/domain/home_repo.dart';
import 'package:e_commerce_app/features/home/domain/usecases/categories_usecase.dart';
import 'package:e_commerce_app/features/home/domain/usecases/get_product_by_category_use_case.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_bloc.dart';
import 'package:e_commerce_app/features/profile/data/local/profile_local_data_source.dart';
import 'package:e_commerce_app/features/profile/data/profile_repository_impl.dart';
import 'package:e_commerce_app/features/profile/data/remote/profile_remote_data_source.dart';
import 'package:e_commerce_app/features/profile/data/remote/profile_remote_data_source_impl.dart';
import 'package:e_commerce_app/features/profile/domain/profile_repository.dart';
import 'package:e_commerce_app/features/profile/domain/use_cases/change_password_use_case.dart';
import 'package:e_commerce_app/features/profile/domain/use_cases/fetch_profile.dart';
import 'package:e_commerce_app/features/profile/domain/use_cases/update_profile.dart';
import 'package:e_commerce_app/features/profile/presentation/controller/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/auth/register/data/remote/register_data_source_impl.dart';
import 'package:e_commerce_app/features/auth/register/data/register_repo_impl.dart';
import 'package:hive_flutter/hive_flutter.dart';

final di = GetIt.instance;

void setupServiceLocator() {
  // Hive
  di.registerLazySingleton(() => Hive);
  // Firebase services
  di.registerLazySingleton(() => FirebaseFirestore.instance);
  di.registerLazySingleton(() => FirebaseAuth.instance);

  //register
  di.registerLazySingleton<RegisterDataSource>(
      () => RegisterDataSourceImpl(di<FirebaseFirestore>()));
  di.registerLazySingleton<RegisterRepository>(() =>
      RegisterRepositoryImpl(di<RegisterDataSource>(), di<FirebaseAuth>()));
  di.registerLazySingleton(() => RegisterUseCase(di<RegisterRepository>()));
  di.registerFactory(() => RegisterBloc(di<RegisterUseCase>()));

  //login
  di.registerLazySingleton<LoginDataSource>(
    () => LoginDataSourceImpl(
      firebaseAuth: di(),
      firestore: di(),
    ),
  );
  di.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(loginDataSource: di()),
  );
  di.registerLazySingleton(() => LoginUseCase(loginRepository: di()));
  di.registerFactory(() => LoginBloc(
        loginUseCase: di(),
        firestore: di(),
      ));
  //profile
  di.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(di(), di()),
  );

  // Local Data Source
  di.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSource(),
  );

  // Repository
  di.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
        di.get<ProfileRemoteDataSource>(), di.get<ProfileLocalDataSource>()),
  );

  // Use Cases
  di.registerLazySingleton<FetchProfileUseCase>(
    () => FetchProfileUseCase(di.get<ProfileRepository>()),
  );

  di.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(di.get<ProfileRepository>()),
  );

  // BLoC
  di.registerLazySingleton(() => ChangePasswordUseCase(di()));

  // BLoC
  di.registerFactory(() => ProfileBloc(di(), di(), di()));

  //home
// BLoC
  di.registerFactory(() =>
      HomeBloc(di<GetCategoriesUseCase>(), di<GetProductsByCategoryUseCase>()));

// UseCase
  di.registerLazySingleton(() => GetCategoriesUseCase(di()));
  di.registerLazySingleton(() => GetProductsByCategoryUseCase(di()));

// Repository
  di.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(di()));

// DataSource
  di.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl(di()));

// External
  di.registerLazySingleton(() => Dio());
}
