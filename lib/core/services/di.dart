import 'package:e_commerce_app/features/auth/log_in/data/login_repo_impl.dart';
import 'package:e_commerce_app/features/auth/log_in/data/remote/login_data-source.dart';
import 'package:e_commerce_app/features/auth/log_in/data/remote/login_data_source_impl.dart';
import 'package:e_commerce_app/features/auth/log_in/domain/login_repo.dart';
import 'package:e_commerce_app/features/auth/log_in/domain/usecases/login_use_case.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/bloc/login_bloc.dart';
import 'package:e_commerce_app/features/auth/register/data/remote/register_data_source.dart';
import 'package:e_commerce_app/features/auth/register/domain/usecases/register_use_case.dart';
import 'package:e_commerce_app/features/auth/register/domain/register_repo.dart';
import 'package:e_commerce_app/features/auth/register/presentation/bloc/register_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/auth/register/data/remote/register_data_source_impl.dart';
import 'package:e_commerce_app/features/auth/register/data/register_repo_impl.dart';

final di = GetIt.instance;

void setupServiceLocator(){

   // Firebase services
   di.registerLazySingleton(() => FirebaseFirestore.instance); 
   di.registerLazySingleton(() => FirebaseAuth.instance);


 //register
   di.registerLazySingleton<RegisterDataSource>(
      () => RegisterDataSourceImpl(di<FirebaseFirestore>()));
  di.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImpl(di<RegisterDataSource>(), di<FirebaseAuth>()));
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
  di.registerFactory(() => LoginBloc(loginUseCase: di(), firebaseAuth: di()));




}
