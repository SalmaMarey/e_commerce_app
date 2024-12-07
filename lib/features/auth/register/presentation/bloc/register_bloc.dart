import 'package:e_commerce_app/features/auth/register/domain/user_repo.dart';
import 'package:e_commerce_app/features/auth/register/presentation/bloc/register_event.dart';
import 'package:e_commerce_app/features/auth/register/presentation/bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<SaveUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        await userRepository.saveUser(event.user);
        emit(UserSuccess());
      } catch (e) {
        emit(UserFailure(e.toString()));
      }
    });
  }
}
