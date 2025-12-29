// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyc_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KYCDocument _$KYCDocumentFromJson(Map<String, dynamic> json) {
  return _KYCDocument.fromJson(json);
}

/// @nodoc
mixin _$KYCDocument {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_path')
  String get filePath => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'uploaded_at')
  DateTime get uploadedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KYCDocumentCopyWith<KYCDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KYCDocumentCopyWith<$Res> {
  factory $KYCDocumentCopyWith(
          KYCDocument value, $Res Function(KYCDocument) then) =
      _$KYCDocumentCopyWithImpl<$Res, KYCDocument>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String type,
      @JsonKey(name: 'file_path') String filePath,
      String status,
      String? notes,
      @JsonKey(name: 'uploaded_at') DateTime uploadedAt});
}

/// @nodoc
class _$KYCDocumentCopyWithImpl<$Res, $Val extends KYCDocument>
    implements $KYCDocumentCopyWith<$Res> {
  _$KYCDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? filePath = null,
    Object? status = null,
    Object? notes = freezed,
    Object? uploadedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedAt: null == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KYCDocumentImplCopyWith<$Res>
    implements $KYCDocumentCopyWith<$Res> {
  factory _$$KYCDocumentImplCopyWith(
          _$KYCDocumentImpl value, $Res Function(_$KYCDocumentImpl) then) =
      __$$KYCDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String type,
      @JsonKey(name: 'file_path') String filePath,
      String status,
      String? notes,
      @JsonKey(name: 'uploaded_at') DateTime uploadedAt});
}

/// @nodoc
class __$$KYCDocumentImplCopyWithImpl<$Res>
    extends _$KYCDocumentCopyWithImpl<$Res, _$KYCDocumentImpl>
    implements _$$KYCDocumentImplCopyWith<$Res> {
  __$$KYCDocumentImplCopyWithImpl(
      _$KYCDocumentImpl _value, $Res Function(_$KYCDocumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? filePath = null,
    Object? status = null,
    Object? notes = freezed,
    Object? uploadedAt = null,
  }) {
    return _then(_$KYCDocumentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedAt: null == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KYCDocumentImpl implements _KYCDocument {
  const _$KYCDocumentImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      required this.type,
      @JsonKey(name: 'file_path') required this.filePath,
      required this.status,
      this.notes,
      @JsonKey(name: 'uploaded_at') required this.uploadedAt});

  factory _$KYCDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$KYCDocumentImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String type;
  @override
  @JsonKey(name: 'file_path')
  final String filePath;
  @override
  final String status;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'uploaded_at')
  final DateTime uploadedAt;

  @override
  String toString() {
    return 'KYCDocument(id: $id, userId: $userId, type: $type, filePath: $filePath, status: $status, notes: $notes, uploadedAt: $uploadedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KYCDocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, type, filePath, status, notes, uploadedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KYCDocumentImplCopyWith<_$KYCDocumentImpl> get copyWith =>
      __$$KYCDocumentImplCopyWithImpl<_$KYCDocumentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KYCDocumentImplToJson(
      this,
    );
  }
}

abstract class _KYCDocument implements KYCDocument {
  const factory _KYCDocument(
          {required final String id,
          @JsonKey(name: 'user_id') required final String userId,
          required final String type,
          @JsonKey(name: 'file_path') required final String filePath,
          required final String status,
          final String? notes,
          @JsonKey(name: 'uploaded_at') required final DateTime uploadedAt}) =
      _$KYCDocumentImpl;

  factory _KYCDocument.fromJson(Map<String, dynamic> json) =
      _$KYCDocumentImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get type;
  @override
  @JsonKey(name: 'file_path')
  String get filePath;
  @override
  String get status;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'uploaded_at')
  DateTime get uploadedAt;
  @override
  @JsonKey(ignore: true)
  _$$KYCDocumentImplCopyWith<_$KYCDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KYCStatusResponse _$KYCStatusResponseFromJson(Map<String, dynamic> json) {
  return _KYCStatusResponse.fromJson(json);
}

/// @nodoc
mixin _$KYCStatusResponse {
  @JsonKey(name: 'overall_status')
  String get overallStatus => throw _privateConstructorUsedError;
  List<KYCDocument> get documents => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KYCStatusResponseCopyWith<KYCStatusResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KYCStatusResponseCopyWith<$Res> {
  factory $KYCStatusResponseCopyWith(
          KYCStatusResponse value, $Res Function(KYCStatusResponse) then) =
      _$KYCStatusResponseCopyWithImpl<$Res, KYCStatusResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'overall_status') String overallStatus,
      List<KYCDocument> documents});
}

/// @nodoc
class _$KYCStatusResponseCopyWithImpl<$Res, $Val extends KYCStatusResponse>
    implements $KYCStatusResponseCopyWith<$Res> {
  _$KYCStatusResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallStatus = null,
    Object? documents = null,
  }) {
    return _then(_value.copyWith(
      overallStatus: null == overallStatus
          ? _value.overallStatus
          : overallStatus // ignore: cast_nullable_to_non_nullable
              as String,
      documents: null == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<KYCDocument>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KYCStatusResponseImplCopyWith<$Res>
    implements $KYCStatusResponseCopyWith<$Res> {
  factory _$$KYCStatusResponseImplCopyWith(_$KYCStatusResponseImpl value,
          $Res Function(_$KYCStatusResponseImpl) then) =
      __$$KYCStatusResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'overall_status') String overallStatus,
      List<KYCDocument> documents});
}

/// @nodoc
class __$$KYCStatusResponseImplCopyWithImpl<$Res>
    extends _$KYCStatusResponseCopyWithImpl<$Res, _$KYCStatusResponseImpl>
    implements _$$KYCStatusResponseImplCopyWith<$Res> {
  __$$KYCStatusResponseImplCopyWithImpl(_$KYCStatusResponseImpl _value,
      $Res Function(_$KYCStatusResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallStatus = null,
    Object? documents = null,
  }) {
    return _then(_$KYCStatusResponseImpl(
      overallStatus: null == overallStatus
          ? _value.overallStatus
          : overallStatus // ignore: cast_nullable_to_non_nullable
              as String,
      documents: null == documents
          ? _value._documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<KYCDocument>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KYCStatusResponseImpl implements _KYCStatusResponse {
  const _$KYCStatusResponseImpl(
      {@JsonKey(name: 'overall_status') required this.overallStatus,
      required final List<KYCDocument> documents})
      : _documents = documents;

  factory _$KYCStatusResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$KYCStatusResponseImplFromJson(json);

  @override
  @JsonKey(name: 'overall_status')
  final String overallStatus;
  final List<KYCDocument> _documents;
  @override
  List<KYCDocument> get documents {
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documents);
  }

  @override
  String toString() {
    return 'KYCStatusResponse(overallStatus: $overallStatus, documents: $documents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KYCStatusResponseImpl &&
            (identical(other.overallStatus, overallStatus) ||
                other.overallStatus == overallStatus) &&
            const DeepCollectionEquality()
                .equals(other._documents, _documents));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, overallStatus,
      const DeepCollectionEquality().hash(_documents));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KYCStatusResponseImplCopyWith<_$KYCStatusResponseImpl> get copyWith =>
      __$$KYCStatusResponseImplCopyWithImpl<_$KYCStatusResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KYCStatusResponseImplToJson(
      this,
    );
  }
}

abstract class _KYCStatusResponse implements KYCStatusResponse {
  const factory _KYCStatusResponse(
      {@JsonKey(name: 'overall_status') required final String overallStatus,
      required final List<KYCDocument> documents}) = _$KYCStatusResponseImpl;

  factory _KYCStatusResponse.fromJson(Map<String, dynamic> json) =
      _$KYCStatusResponseImpl.fromJson;

  @override
  @JsonKey(name: 'overall_status')
  String get overallStatus;
  @override
  List<KYCDocument> get documents;
  @override
  @JsonKey(ignore: true)
  _$$KYCStatusResponseImplCopyWith<_$KYCStatusResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
