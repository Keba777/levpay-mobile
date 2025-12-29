// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'billing_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return _Invoice.fromJson(json);
}

/// @nodoc
mixin _$Invoice {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'due_date')
  String get dueDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_at')
  String? get paidAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoiceCopyWith<Invoice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceCopyWith<$Res> {
  factory $InvoiceCopyWith(Invoice value, $Res Function(Invoice) then) =
      _$InvoiceCopyWithImpl<$Res, Invoice>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      double amount,
      String currency,
      String status,
      String description,
      @JsonKey(name: 'due_date') String dueDate,
      @JsonKey(name: 'paid_at') String? paidAt,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class _$InvoiceCopyWithImpl<$Res, $Val extends Invoice>
    implements $InvoiceCopyWith<$Res> {
  _$InvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? description = null,
    Object? dueDate = null,
    Object? paidAt = freezed,
    Object? createdAt = null,
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
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceImplCopyWith<$Res> implements $InvoiceCopyWith<$Res> {
  factory _$$InvoiceImplCopyWith(
          _$InvoiceImpl value, $Res Function(_$InvoiceImpl) then) =
      __$$InvoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      double amount,
      String currency,
      String status,
      String description,
      @JsonKey(name: 'due_date') String dueDate,
      @JsonKey(name: 'paid_at') String? paidAt,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class __$$InvoiceImplCopyWithImpl<$Res>
    extends _$InvoiceCopyWithImpl<$Res, _$InvoiceImpl>
    implements _$$InvoiceImplCopyWith<$Res> {
  __$$InvoiceImplCopyWithImpl(
      _$InvoiceImpl _value, $Res Function(_$InvoiceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? description = null,
    Object? dueDate = null,
    Object? paidAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$InvoiceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceImpl implements _Invoice {
  const _$InvoiceImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      required this.amount,
      required this.currency,
      required this.status,
      required this.description,
      @JsonKey(name: 'due_date') required this.dueDate,
      @JsonKey(name: 'paid_at') this.paidAt,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$InvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final String status;
  @override
  final String description;
  @override
  @JsonKey(name: 'due_date')
  final String dueDate;
  @override
  @JsonKey(name: 'paid_at')
  final String? paidAt;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'Invoice(id: $id, userId: $userId, amount: $amount, currency: $currency, status: $status, description: $description, dueDate: $dueDate, paidAt: $paidAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, amount, currency,
      status, description, dueDate, paidAt, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      __$$InvoiceImplCopyWithImpl<_$InvoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceImplToJson(
      this,
    );
  }
}

abstract class _Invoice implements Invoice {
  const factory _Invoice(
          {required final String id,
          @JsonKey(name: 'user_id') required final String userId,
          required final double amount,
          required final String currency,
          required final String status,
          required final String description,
          @JsonKey(name: 'due_date') required final String dueDate,
          @JsonKey(name: 'paid_at') final String? paidAt,
          @JsonKey(name: 'created_at') required final String createdAt}) =
      _$InvoiceImpl;

  factory _Invoice.fromJson(Map<String, dynamic> json) = _$InvoiceImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  double get amount;
  @override
  String get currency;
  @override
  String get status;
  @override
  String get description;
  @override
  @JsonKey(name: 'due_date')
  String get dueDate;
  @override
  @JsonKey(name: 'paid_at')
  String? get paidAt;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillingStats _$BillingStatsFromJson(Map<String, dynamic> json) {
  return _BillingStats.fromJson(json);
}

/// @nodoc
mixin _$BillingStats {
  @JsonKey(name: 'total_invoiced')
  double get totalInvoiced => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_paid')
  double get totalPaid => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pending')
  double get totalPending => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_count')
  int get invoiceCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BillingStatsCopyWith<BillingStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillingStatsCopyWith<$Res> {
  factory $BillingStatsCopyWith(
          BillingStats value, $Res Function(BillingStats) then) =
      _$BillingStatsCopyWithImpl<$Res, BillingStats>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_invoiced') double totalInvoiced,
      @JsonKey(name: 'total_paid') double totalPaid,
      @JsonKey(name: 'total_pending') double totalPending,
      @JsonKey(name: 'invoice_count') int invoiceCount});
}

/// @nodoc
class _$BillingStatsCopyWithImpl<$Res, $Val extends BillingStats>
    implements $BillingStatsCopyWith<$Res> {
  _$BillingStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalInvoiced = null,
    Object? totalPaid = null,
    Object? totalPending = null,
    Object? invoiceCount = null,
  }) {
    return _then(_value.copyWith(
      totalInvoiced: null == totalInvoiced
          ? _value.totalInvoiced
          : totalInvoiced // ignore: cast_nullable_to_non_nullable
              as double,
      totalPaid: null == totalPaid
          ? _value.totalPaid
          : totalPaid // ignore: cast_nullable_to_non_nullable
              as double,
      totalPending: null == totalPending
          ? _value.totalPending
          : totalPending // ignore: cast_nullable_to_non_nullable
              as double,
      invoiceCount: null == invoiceCount
          ? _value.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BillingStatsImplCopyWith<$Res>
    implements $BillingStatsCopyWith<$Res> {
  factory _$$BillingStatsImplCopyWith(
          _$BillingStatsImpl value, $Res Function(_$BillingStatsImpl) then) =
      __$$BillingStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_invoiced') double totalInvoiced,
      @JsonKey(name: 'total_paid') double totalPaid,
      @JsonKey(name: 'total_pending') double totalPending,
      @JsonKey(name: 'invoice_count') int invoiceCount});
}

/// @nodoc
class __$$BillingStatsImplCopyWithImpl<$Res>
    extends _$BillingStatsCopyWithImpl<$Res, _$BillingStatsImpl>
    implements _$$BillingStatsImplCopyWith<$Res> {
  __$$BillingStatsImplCopyWithImpl(
      _$BillingStatsImpl _value, $Res Function(_$BillingStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalInvoiced = null,
    Object? totalPaid = null,
    Object? totalPending = null,
    Object? invoiceCount = null,
  }) {
    return _then(_$BillingStatsImpl(
      totalInvoiced: null == totalInvoiced
          ? _value.totalInvoiced
          : totalInvoiced // ignore: cast_nullable_to_non_nullable
              as double,
      totalPaid: null == totalPaid
          ? _value.totalPaid
          : totalPaid // ignore: cast_nullable_to_non_nullable
              as double,
      totalPending: null == totalPending
          ? _value.totalPending
          : totalPending // ignore: cast_nullable_to_non_nullable
              as double,
      invoiceCount: null == invoiceCount
          ? _value.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BillingStatsImpl implements _BillingStats {
  const _$BillingStatsImpl(
      {@JsonKey(name: 'total_invoiced') required this.totalInvoiced,
      @JsonKey(name: 'total_paid') required this.totalPaid,
      @JsonKey(name: 'total_pending') required this.totalPending,
      @JsonKey(name: 'invoice_count') required this.invoiceCount});

  factory _$BillingStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillingStatsImplFromJson(json);

  @override
  @JsonKey(name: 'total_invoiced')
  final double totalInvoiced;
  @override
  @JsonKey(name: 'total_paid')
  final double totalPaid;
  @override
  @JsonKey(name: 'total_pending')
  final double totalPending;
  @override
  @JsonKey(name: 'invoice_count')
  final int invoiceCount;

  @override
  String toString() {
    return 'BillingStats(totalInvoiced: $totalInvoiced, totalPaid: $totalPaid, totalPending: $totalPending, invoiceCount: $invoiceCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillingStatsImpl &&
            (identical(other.totalInvoiced, totalInvoiced) ||
                other.totalInvoiced == totalInvoiced) &&
            (identical(other.totalPaid, totalPaid) ||
                other.totalPaid == totalPaid) &&
            (identical(other.totalPending, totalPending) ||
                other.totalPending == totalPending) &&
            (identical(other.invoiceCount, invoiceCount) ||
                other.invoiceCount == invoiceCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalInvoiced, totalPaid, totalPending, invoiceCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BillingStatsImplCopyWith<_$BillingStatsImpl> get copyWith =>
      __$$BillingStatsImplCopyWithImpl<_$BillingStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillingStatsImplToJson(
      this,
    );
  }
}

abstract class _BillingStats implements BillingStats {
  const factory _BillingStats(
          {@JsonKey(name: 'total_invoiced') required final double totalInvoiced,
          @JsonKey(name: 'total_paid') required final double totalPaid,
          @JsonKey(name: 'total_pending') required final double totalPending,
          @JsonKey(name: 'invoice_count') required final int invoiceCount}) =
      _$BillingStatsImpl;

  factory _BillingStats.fromJson(Map<String, dynamic> json) =
      _$BillingStatsImpl.fromJson;

  @override
  @JsonKey(name: 'total_invoiced')
  double get totalInvoiced;
  @override
  @JsonKey(name: 'total_paid')
  double get totalPaid;
  @override
  @JsonKey(name: 'total_pending')
  double get totalPending;
  @override
  @JsonKey(name: 'invoice_count')
  int get invoiceCount;
  @override
  @JsonKey(ignore: true)
  _$$BillingStatsImplCopyWith<_$BillingStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
