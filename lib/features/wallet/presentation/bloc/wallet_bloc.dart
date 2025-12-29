import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/wallet_repository.dart';
import 'wallet_event.dart';
import 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository _walletRepository;

  WalletBloc(this._walletRepository) : super(WalletInitial()) {
    on<WalletBalanceRequested>(_onBalanceRequested);
    on<WalletHistoryRequested>(_onHistoryRequested);
    on<WalletTopUpRequested>(_onTopUpRequested);
    on<WalletTransferRequested>(_onTransferRequested);
  }

  Future<void> _onBalanceRequested(
    WalletBalanceRequested event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletLoading());
    try {
      final balance = await _walletRepository.getBalance();
      final history = await _walletRepository.getHistory(page: 1, limit: 10);
      emit(WalletDashboardLoaded(balance: balance, history: history));
    } catch (e) {
      emit(WalletFailure(e.toString()));
    }
  }

  Future<void> _onHistoryRequested(
    WalletHistoryRequested event,
    Emitter<WalletState> emit,
  ) async {
    try {
      final history = await _walletRepository.getHistory(
        page: event.page,
        limit: event.limit,
      );
      emit(WalletHistoryLoaded(history));
    } catch (e) {
      emit(WalletFailure(e.toString()));
    }
  }

  Future<void> _onTopUpRequested(
    WalletTopUpRequested event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletLoading());
    try {
      await _walletRepository.topUp(amount: event.amount);
      emit(const WalletSuccess(message: 'Top up successful!'));
      add(WalletBalanceRequested()); // Refresh balance after success
    } catch (e) {
      emit(WalletFailure(e.toString()));
    }
  }

  Future<void> _onTransferRequested(
    WalletTransferRequested event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletLoading());
    try {
      await _walletRepository.transfer(
        toEmail: event.toEmail,
        amount: event.amount,
        description: event.description,
      );
      emit(const WalletSuccess(message: 'Transfer successful!'));
      add(WalletBalanceRequested()); // Refresh balance after success
    } catch (e) {
      emit(WalletFailure(e.toString()));
    }
  }
}
