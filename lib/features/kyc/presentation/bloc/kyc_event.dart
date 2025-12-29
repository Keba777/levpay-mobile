import 'dart:io';
import 'package:equatable/equatable.dart';
import '../../data/models/kyc_models.dart';

abstract class KYCEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class KYCStatusRequested extends KYCEvent {}

class KYCDocumentUploadStarted extends KYCEvent {
  final String type;
  final File file;

  KYCDocumentUploadStarted({required this.type, required this.file});

  @override
  List<Object?> get props => [type, file];
}

class KYCReset extends KYCEvent {}
