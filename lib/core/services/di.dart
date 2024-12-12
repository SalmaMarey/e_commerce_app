import 'package:e_commerce_app/features/auth/register/data/remote/user_data_source.dart';
import 'package:e_commerce_app/features/auth/register/domain/usecases/register_use_case.dart';
import 'package:e_commerce_app/features/auth/register/domain/user_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/auth/register/data/remote/user_data_source_impl.dart';
import 'package:e_commerce_app/features/auth/register/data/user_repo_impl.dart';

import 'package:e_commerce_app/features/auth/register/presentation/bloc/register_bloc.dart';

final di = GetIt.instance;

void setupServiceLocator(){
  // External dependencies
  di.registerLazySingleton(() => FirebaseFirestore.instance);

  // Data source
  di.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(di<FirebaseFirestore>()));

  // Repository
  di.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(di<UserDataSource>()));

  // Use case
  di.registerLazySingleton(() => RegisterUseCase(di<UserRepository>()));

  // Bloc
  di.registerFactory(() => UserBloc(di<RegisterUseCase>()));
}
