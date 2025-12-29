// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_models.freezed.dart';
part 'wallet_models.g.dart';

@freezed
class WalletResponse with _$WalletResponse {
  const factory WalletResponse({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required double balance,
    required String currency,
    required bool locked,
    @JsonKey(name: 'last_updated') required DateTime lastUpdated,
  }) = _WalletResponse;

  factory WalletResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletResponseFromJson(json);
}

@freezed
class BalanceResponse with _$BalanceResponse {
  const factory BalanceResponse({
    required double balance,
    required String currency,
  }) = _BalanceResponse;

  factory BalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseFromJson(json);
}

@freezed
class TransactionItem with _$TransactionItem {
  const factory TransactionItem({
    required String id,
    @JsonKey(name: 'from_user_id') required String fromUserId,
    @JsonKey(name: 'to_user_id') String? toUserId,
    required double amount,
    required String currency,
    required String type,
    required String status,
    String? description,
    required double fee,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _TransactionItem;

  factory TransactionItem.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemFromJson(json);
}

@freezed
class WalletHistoryResponse with _$WalletHistoryResponse {
  const factory WalletHistoryResponse({
    required List<TransactionItem> records,
    required int total,
    required int page,
    required int limit,
  }) = _WalletHistoryResponse;

  factory WalletHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletHistoryResponseFromJson(json);
}
