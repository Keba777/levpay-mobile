import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/user_repository.dart';
import '../../../auth/data/models/auth_models.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({required this.userRepository}) : super(const ProfileState()) {
    on<ProfileDataRequested>(_onProfileDataRequested);
    on<ProfileUpdateRequested>(_onProfileUpdateRequested);
    on<SettingsUpdateRequested>(_onSettingsUpdateRequested);
  }

  Future<void> _onProfileDataRequested(
    ProfileDataRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final userRes = await userRepository.getMe();
      final settingsRes = await userRepository.getSettings();

      final user = User.fromJson(userRes);
      final preferences = settingsRes['preferences'] != null
          ? json.decode(settingsRes['preferences'])
          : <String, dynamic>{};

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          user: user,
          settings: preferences,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onProfileUpdateRequested(
    ProfileUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.updating));
    try {
      final res = await userRepository.updateProfile(
        firstName: event.firstName,
        lastName: event.lastName,
        username: event.username,
        phone: event.phone,
        avatarPath: event.avatar?.path,
      );

      final updatedUser = User.fromJson(res);
      emit(
        state.copyWith(status: ProfileStatus.updateSuccess, user: updatedUser),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.updateFailure,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSettingsUpdateRequested(
    SettingsUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.updating));
    try {
      final res = await userRepository.updateSettings(event.preferences);
      final preferences = res['preferences'] != null
          ? json.decode(res['preferences'])
          : <String, dynamic>{};

      emit(
        state.copyWith(
          status: ProfileStatus.updateSuccess,
          settings: preferences,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.updateFailure,
          error: e.toString(),
        ),
      );
    }
  }
}
