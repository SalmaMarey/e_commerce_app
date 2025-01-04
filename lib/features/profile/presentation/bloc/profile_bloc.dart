import 'package:e_commerce_app/features/profile/domain/use_cases/change_password_use_case.dart';
import 'package:e_commerce_app/features/profile/domain/use_cases/fetch_profile.dart';
import 'package:e_commerce_app/features/profile/domain/use_cases/update_profile.dart';
import 'package:e_commerce_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:e_commerce_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchProfileUseCase fetchUserProfile;
  final UpdateProfileUseCase updateUserProfile;
  final ChangePasswordUseCase changePasswordUseCase;

  ProfileBloc(
    this.fetchUserProfile,
    this.updateUserProfile,
    this.changePasswordUseCase,
  ) : super(ProfileInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = await fetchUserProfile(event.uid);
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError('Failed to fetch profile'));
      }
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        await updateUserProfile(event.user.id, event.user);
        emit(ProfileLoaded(event.user));
      } catch (e) {
        emit(ProfileError('Failed to update profile'));
      }
    });

    on<ChangePassword>((event, emit) async {
      emit(ProfileLoading());
      try {
        await changePasswordUseCase(event.currentPassword, event.newPassword);
        emit(PasswordChangeSuccess("Password updated successfully"));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
