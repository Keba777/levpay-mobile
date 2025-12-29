import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/payment_method_repository.dart';
import 'payment_method_event.dart';
import 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  final PaymentMethodRepository repository;

  PaymentMethodBloc({required this.repository})
    : super(const PaymentMethodState()) {
    on<PaymentMethodListRequested>(_onListRequested);
    on<PaymentMethodAddRequested>(_onAddRequested);
    on<PaymentMethodRemoveRequested>(_onRemoveRequested);
    on<PaymentMethodSetDefaultRequested>(_onSetDefaultRequested);
  }

  Future<void> _onListRequested(
    PaymentMethodListRequested event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(state.copyWith(status: PaymentMethodStatus.loading));
    try {
      final methods = await repository.listPaymentMethods();
      emit(
        state.copyWith(status: PaymentMethodStatus.success, methods: methods),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentMethodStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAddRequested(
    PaymentMethodAddRequested event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(state.copyWith(status: PaymentMethodStatus.loading));
    try {
      await repository.addPaymentMethod(
        type: event.type,
        details: event.details,
        isDefault: event.isDefault,
      );
      final methods = await repository.listPaymentMethods();
      emit(
        state.copyWith(
          status: PaymentMethodStatus.actionSuccess,
          methods: methods,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentMethodStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRemoveRequested(
    PaymentMethodRemoveRequested event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(state.copyWith(status: PaymentMethodStatus.loading));
    try {
      await repository.removePaymentMethod(event.id);
      final methods = await repository.listPaymentMethods();
      emit(
        state.copyWith(
          status: PaymentMethodStatus.actionSuccess,
          methods: methods,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentMethodStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSetDefaultRequested(
    PaymentMethodSetDefaultRequested event,
    Emitter<PaymentMethodState> emit,
  ) async {
    emit(state.copyWith(status: PaymentMethodStatus.loading));
    try {
      await repository.setDefaultPaymentMethod(event.id);
      final methods = await repository.listPaymentMethods();
      emit(
        state.copyWith(
          status: PaymentMethodStatus.actionSuccess,
          methods: methods,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentMethodStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
