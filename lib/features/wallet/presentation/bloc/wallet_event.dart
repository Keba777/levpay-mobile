import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object?> get props => [];
}

class WalletBalanceRequested extends WalletEvent {}

class WalletHistoryRequested extends WalletEvent {
  final int page;
  final int limit;

  const WalletHistoryRequested({this.page = 1, this.limit = 10});

  @override
  List<Object?> get props => [page, limit];
}

class WalletTopUpRequested extends WalletEvent {
  final double amount;

  const WalletTopUpRequested(this.amount);

  @override
  List<Object?> get props => [amount];
}

class WalletTransferRequested extends WalletEvent {
  final String toEmail;
  final double amount;
  final String? description;

  const WalletTransferRequested({
    required this.toEmail,
    required this.amount,
    this.description,
  });

  @override
  List<Object?> get props => [toEmail, amount, description];
}
