import 'package:equatable/equatable.dart';
import '../../data/models/wallet_models.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletBalanceLoaded extends WalletState {
  final BalanceResponse balance;

  const WalletBalanceLoaded(this.balance);

  @override
  List<Object?> get props => [balance];
}

class WalletHistoryLoaded extends WalletState {
  final WalletHistoryResponse history;

  const WalletHistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

class WalletSuccess extends WalletState {
  final String message;
  final dynamic data;

  const WalletSuccess({required this.message, this.data});

  @override
  List<Object?> get props => [message, data];
}

class WalletFailure extends WalletState {
  final String error;

  const WalletFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Combined state for the main dashboard
class WalletDashboardLoaded extends WalletState {
  final BalanceResponse balance;
  final WalletHistoryResponse history;

  const WalletDashboardLoaded({required this.balance, required this.history});

  @override
  List<Object?> get props => [balance, history];
}
