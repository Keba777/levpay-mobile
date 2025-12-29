// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletResponseImpl _$$WalletResponseImplFromJson(Map<String, dynamic> json) =>
    _$WalletResponseImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
      locked: json['locked'] as bool,
      lastUpdated: DateTime.parse(json['last_updated'] as String),
    );

Map<String, dynamic> _$$WalletResponseImplToJson(
        _$WalletResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'balance': instance.balance,
      'currency': instance.currency,
      'locked': instance.locked,
      'last_updated': instance.lastUpdated.toIso8601String(),
    };

_$BalanceResponseImpl _$$BalanceResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BalanceResponseImpl(
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$$BalanceResponseImplToJson(
        _$BalanceResponseImpl instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'currency': instance.currency,
    };

_$TransactionItemImpl _$$TransactionItemImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionItemImpl(
      id: json['id'] as String,
      fromUserId: json['from_user_id'] as String,
      toUserId: json['to_user_id'] as String?,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      description: json['description'] as String?,
      fee: (json['fee'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$TransactionItemImplToJson(
        _$TransactionItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from_user_id': instance.fromUserId,
      'to_user_id': instance.toUserId,
      'amount': instance.amount,
      'currency': instance.currency,
      'type': instance.type,
      'status': instance.status,
      'description': instance.description,
      'fee': instance.fee,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$WalletHistoryResponseImpl _$$WalletHistoryResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WalletHistoryResponseImpl(
      records: (json['records'] as List<dynamic>)
          .map((e) => TransactionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$$WalletHistoryResponseImplToJson(
        _$WalletHistoryResponseImpl instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
    };
