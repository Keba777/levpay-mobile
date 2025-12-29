import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/billing_repository.dart';
import 'billing_bloc_parts.dart';

class BillingBloc extends Bloc<BillingEvent, BillingState> {
  final BillingRepository repository;

  BillingBloc({required this.repository}) : super(const BillingState()) {
    on<BillingLoadRequested>(_onLoadRequested);
    on<BillingPayInvoiceRequested>(_onPayRequested);
    on<BillingCancelInvoiceRequested>(_onCancelRequested);
  }

  Future<void> _onLoadRequested(
    BillingLoadRequested event,
    Emitter<BillingState> emit,
  ) async {
    emit(state.copyWith(status: BillingStatus.loading));
    try {
      final invoices = await repository.listInvoices();
      final stats = await repository.getStats();
      emit(
        state.copyWith(
          status: BillingStatus.success,
          invoices: invoices,
          stats: stats,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BillingStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onPayRequested(
    BillingPayInvoiceRequested event,
    Emitter<BillingState> emit,
  ) async {
    emit(state.copyWith(status: BillingStatus.loading));
    try {
      await repository.payInvoice(event.id);
      final invoices = await repository.listInvoices();
      final stats = await repository.getStats();
      emit(
        state.copyWith(
          status: BillingStatus.actionSuccess,
          invoices: invoices,
          stats: stats,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BillingStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onCancelRequested(
    BillingCancelInvoiceRequested event,
    Emitter<BillingState> emit,
  ) async {
    emit(state.copyWith(status: BillingStatus.loading));
    try {
      await repository.cancelInvoice(event.id);
      final invoices = await repository.listInvoices();
      final stats = await repository.getStats();
      emit(
        state.copyWith(
          status: BillingStatus.actionSuccess,
          invoices: invoices,
          stats: stats,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BillingStatus.failure, error: e.toString()));
    }
  }
}
