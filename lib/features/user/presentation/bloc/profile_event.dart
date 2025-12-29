import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileDataRequested extends ProfileEvent {}

class ProfileUpdateRequested extends ProfileEvent {
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? phone;
  final File? avatar;

  ProfileUpdateRequested({
    this.firstName,
    this.lastName,
    this.username,
    this.phone,
    this.avatar,
  });

  @override
  List<Object?> get props => [firstName, lastName, username, phone, avatar];
}

class SettingsUpdateRequested extends ProfileEvent {
  final Map<String, dynamic> preferences;

  SettingsUpdateRequested(this.preferences);

  @override
  List<Object?> get props => [preferences];
}
