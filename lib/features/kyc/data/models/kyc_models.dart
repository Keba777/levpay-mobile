// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyc_models.freezed.dart';
part 'kyc_models.g.dart';

@freezed
class KYCDocument with _$KYCDocument {
  const factory KYCDocument({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String type,
    @JsonKey(name: 'file_path') required String filePath,
    required String status,
    String? notes,
    @JsonKey(name: 'uploaded_at') required DateTime uploadedAt,
  }) = _KYCDocument;

  factory KYCDocument.fromJson(Map<String, dynamic> json) =>
      _$KYCDocumentFromJson(json);
}

@freezed
class KYCStatusResponse with _$KYCStatusResponse {
  const factory KYCStatusResponse({
    @JsonKey(name: 'overall_status') required String overallStatus,
    required List<KYCDocument> documents,
  }) = _KYCStatusResponse;

  factory KYCStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$KYCStatusResponseFromJson(json);
}
