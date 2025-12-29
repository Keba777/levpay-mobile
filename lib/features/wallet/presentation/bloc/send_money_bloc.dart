import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/wallet_repository.dart';
import '../../../user/data/repositories/user_repository.dart';
import 'send_money_event.dart';
import 'send_money_state.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  final WalletRepository _walletRepository;
  final UserRepository _userRepository;

  SendMoneyBloc({
    required WalletRepository walletRepository,
    required UserRepository userRepository,
  }) : _walletRepository = walletRepository,
       _userRepository = userRepository,
       super(const SendMoneyState()) {
    on<SendMoneySearchRequested>(_onSearchRequested);
    on<SendMoneyRecipientSelected>(_onRecipientSelected);
    on<SendMoneyAmountEntered>(_onAmountEntered);
    on<SendMoneyConfirmed>(_onConfirmed);
    on<SendMoneyReset>(_onReset);
  }

  Future<void> _onSearchRequested(
    SendMoneySearchRequested event,
    Emitter<SendMoneyState> emit,
  ) async {
    if (event.query.length < 3) {
      emit(state.copyWith(searchResults: [], status: SendMoneyStatus.initial));
      return;
    }

    emit(state.copyWith(status: SendMoneyStatus.searching));
    try {
      final response = await _userRepository.searchUsers(event.query);
      emit(
        state.copyWith(
          status: SendMoneyStatus.initial,
          searchResults: response.records,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: SendMoneyStatus.failure, error: e.toString()),
      );
    }
  }

  void _onRecipientSelected(
    SendMoneyRecipientSelected event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(
      state.copyWith(
        selectedRecipient: event.recipient,
        status: SendMoneyStatus.recipientSelected,
      ),
    );
  }

  void _onAmountEntered(
    SendMoneyAmountEntered event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(
      state.copyWith(
        amount: event.amount,
        description: event.description,
        status: SendMoneyStatus.reviewing,
      ),
    );
  }

  Future<void> _onConfirmed(
    SendMoneyConfirmed event,
    Emitter<SendMoneyState> emit,
  ) async {
    if (state.selectedRecipient == null || state.amount <= 0) return;

    emit(state.copyWith(status: SendMoneyStatus.processing));
    try {
      await _walletRepository.transfer(
        toEmail: state.selectedRecipient!.email,
        amount: state.amount,
        description: state.description,
      );
      emit(state.copyWith(status: SendMoneyStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: SendMoneyStatus.failure, error: e.toString()),
      );
    }
  }

  void _onReset(SendMoneyReset event, Emitter<SendMoneyState> emit) {
    emit(const SendMoneyState());
  }
}
