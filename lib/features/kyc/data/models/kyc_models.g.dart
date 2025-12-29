// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KYCDocumentImpl _$$KYCDocumentImplFromJson(Map<String, dynamic> json) =>
    _$KYCDocumentImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: json['type'] as String,
      filePath: json['file_path'] as String,
      status: json['status'] as String,
      notes: json['notes'] as String?,
      uploadedAt: DateTime.parse(json['uploaded_at'] as String),
    );

Map<String, dynamic> _$$KYCDocumentImplToJson(_$KYCDocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'type': instance.type,
      'file_path': instance.filePath,
      'status': instance.status,
      'notes': instance.notes,
      'uploaded_at': instance.uploadedAt.toIso8601String(),
    };

_$KYCStatusResponseImpl _$$KYCStatusResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$KYCStatusResponseImpl(
      overallStatus: json['overall_status'] as String,
      documents: (json['documents'] as List<dynamic>)
          .map((e) => KYCDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$KYCStatusResponseImplToJson(
        _$KYCStatusResponseImpl instance) =>
    <String, dynamic>{
      'overall_status': instance.overallStatus,
      'documents': instance.documents,
    };
