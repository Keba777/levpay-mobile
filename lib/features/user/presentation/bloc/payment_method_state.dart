import 'package:equatable/equatable.dart';
import '../../data/models/payment_method_models.dart';

enum PaymentMethodStatus { initial, loading, success, failure, actionSuccess }

class PaymentMethodState extends Equatable {
  final List<PaymentMethod> methods;
  final PaymentMethodStatus status;
  final String? error;

  const PaymentMethodState({
    this.methods = const [],
    this.status = PaymentMethodStatus.initial,
    this.error,
  });

  PaymentMethodState copyWith({
    List<PaymentMethod>? methods,
    PaymentMethodStatus? status,
    String? error,
  }) {
    return PaymentMethodState(
      methods: methods ?? this.methods,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [methods, status, error];
}
