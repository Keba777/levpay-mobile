import 'package:equatable/equatable.dart';
import '../../../user/data/models/user_models.dart';

enum SendMoneyStatus {
  initial,
  searching,
  recipientSelected,
  amountEntering,
  reviewing,
  processing,
  success,
  failure,
}

class SendMoneyState extends Equatable {
  final SendMoneyStatus status;
  final List<PublicUser> searchResults;
  final PublicUser? selectedRecipient;
  final double amount;
  final String? description;
  final String? error;

  const SendMoneyState({
    this.status = SendMoneyStatus.initial,
    this.searchResults = const [],
    this.selectedRecipient,
    this.amount = 0.0,
    this.description,
    this.error,
  });

  SendMoneyState copyWith({
    SendMoneyStatus? status,
    List<PublicUser>? searchResults,
    PublicUser? selectedRecipient,
    double? amount,
    String? description,
    String? error,
  }) {
    return SendMoneyState(
      status: status ?? this.status,
      searchResults: searchResults ?? this.searchResults,
      selectedRecipient: selectedRecipient ?? this.selectedRecipient,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    searchResults,
    selectedRecipient,
    amount,
    description,
    error,
  ];
}
