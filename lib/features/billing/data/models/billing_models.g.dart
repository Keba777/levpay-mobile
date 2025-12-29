// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceImpl _$$InvoiceImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      description: json['description'] as String,
      dueDate: json['due_date'] as String,
      paidAt: json['paid_at'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$InvoiceImplToJson(_$InvoiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'description': instance.description,
      'due_date': instance.dueDate,
      'paid_at': instance.paidAt,
      'created_at': instance.createdAt,
    };

_$BillingStatsImpl _$$BillingStatsImplFromJson(Map<String, dynamic> json) =>
    _$BillingStatsImpl(
      totalInvoiced: (json['total_invoiced'] as num).toDouble(),
      totalPaid: (json['total_paid'] as num).toDouble(),
      totalPending: (json['total_pending'] as num).toDouble(),
      invoiceCount: (json['invoice_count'] as num).toInt(),
    );

Map<String, dynamic> _$$BillingStatsImplToJson(_$BillingStatsImpl instance) =>
    <String, dynamic>{
      'total_invoiced': instance.totalInvoiced,
      'total_paid': instance.totalPaid,
      'total_pending': instance.totalPending,
      'invoice_count': instance.invoiceCount,
    };
