import 'package:equatable/equatable.dart';

abstract class PaymentMethodEvent extends Equatable {
  const PaymentMethodEvent();

  @override
  List<Object?> get props => [];
}

class PaymentMethodListRequested extends PaymentMethodEvent {}

class PaymentMethodAddRequested extends PaymentMethodEvent {
  final String type;
  final Map<String, dynamic> details;
  final bool isDefault;

  const PaymentMethodAddRequested({
    required this.type,
    required this.details,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [type, details, isDefault];
}

class PaymentMethodRemoveRequested extends PaymentMethodEvent {
  final String id;

  const PaymentMethodRemoveRequested(this.id);

  @override
  List<Object?> get props => [id];
}

class PaymentMethodSetDefaultRequested extends PaymentMethodEvent {
  final String id;

  const PaymentMethodSetDefaultRequested(this.id);

  @override
  List<Object?> get props => [id];
}
