// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'billing_models.freezed.dart';
part 'billing_models.g.dart';

@freezed
class Invoice with _$Invoice {
  const factory Invoice({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required double amount,
    required String currency,
    required String status,
    required String description,
    @JsonKey(name: 'due_date') required String dueDate,
    @JsonKey(name: 'paid_at') String? paidAt,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _Invoice;

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
}

@freezed
class BillingStats with _$BillingStats {
  const factory BillingStats({
    @JsonKey(name: 'total_invoiced') required double totalInvoiced,
    @JsonKey(name: 'total_paid') required double totalPaid,
    @JsonKey(name: 'total_pending') required double totalPending,
    @JsonKey(name: 'invoice_count') required int invoiceCount,
  }) = _BillingStats;

  factory BillingStats.fromJson(Map<String, dynamic> json) =>
      _$BillingStatsFromJson(json);
}
