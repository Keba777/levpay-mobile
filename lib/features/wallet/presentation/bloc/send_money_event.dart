import 'package:equatable/equatable.dart';
import '../../../user/data/models/user_models.dart';

abstract class SendMoneyEvent extends Equatable {
  const SendMoneyEvent();

  @override
  List<Object?> get props => [];
}

class SendMoneySearchRequested extends SendMoneyEvent {
  final String query;
  const SendMoneySearchRequested(this.query);

  @override
  List<Object?> get props => [query];
}

class SendMoneyRecipientSelected extends SendMoneyEvent {
  final PublicUser recipient;
  const SendMoneyRecipientSelected(this.recipient);

  @override
  List<Object?> get props => [recipient];
}

class SendMoneyAmountEntered extends SendMoneyEvent {
  final double amount;
  final String? description;
  const SendMoneyAmountEntered({required this.amount, this.description});

  @override
  List<Object?> get props => [amount, description];
}

class SendMoneyConfirmed extends SendMoneyEvent {}

class SendMoneyReset extends SendMoneyEvent {}
