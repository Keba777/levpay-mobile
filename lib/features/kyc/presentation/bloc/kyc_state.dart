import 'package:equatable/equatable.dart';
import '../../data/models/kyc_models.dart';

enum KYCStatus {
  initial,
  loading,
  success,
  failure,
  uploading,
  uploadSuccess,
  uploadFailure,
}

class KYCState extends Equatable {
  final KYCStatus status;
  final String? overallStatus;
  final List<KYCDocument> documents;
  final String? error;

  const KYCState({
    this.status = KYCStatus.initial,
    this.overallStatus,
    this.documents = const [],
    this.error,
  });

  KYCState copyWith({
    KYCStatus? status,
    String? overallStatus,
    List<KYCDocument>? documents,
    String? error,
  }) {
    return KYCState(
      status: status ?? this.status,
      overallStatus: overallStatus ?? this.overallStatus,
      documents: documents ?? this.documents,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, overallStatus, documents, error];
}
