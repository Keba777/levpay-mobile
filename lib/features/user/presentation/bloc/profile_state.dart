import 'package:equatable/equatable.dart';
import '../../../auth/data/models/auth_models.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  failure,
  updating,
  updateSuccess,
  updateFailure,
}

class ProfileState extends Equatable {
  final ProfileStatus status;
  final User? user;
  final Map<String, dynamic> settings;
  final String? error;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
    this.settings = const {},
    this.error,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    User? user,
    Map<String, dynamic>? settings,
    String? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      settings: settings ?? this.settings,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, user, settings, error];
}
