import 'package:equatable/equatable.dart';
import '../../data/models/billing_models.dart';

abstract class BillingEvent extends Equatable {
  const BillingEvent();
  @override
  List<Object?> get props => [];
}

class BillingLoadRequested extends BillingEvent {}

class BillingPayInvoiceRequested extends BillingEvent {
  final String id;
  const BillingPayInvoiceRequested(this.id);
  @override
  List<Object?> get props => [id];
}

class BillingCancelInvoiceRequested extends BillingEvent {
  final String id;
  const BillingCancelInvoiceRequested(this.id);
  @override
  List<Object?> get props => [id];
}

// --- State ---

enum BillingStatus { initial, loading, success, failure, actionSuccess }

class BillingState extends Equatable {
  final List<Invoice> invoices;
  final BillingStats? stats;
  final BillingStatus status;
  final String? error;

  const BillingState({
    this.invoices = const [],
    this.stats,
    this.status = BillingStatus.initial,
    this.error,
  });

  BillingState copyWith({
    List<Invoice>? invoices,
    BillingStats? stats,
    BillingStatus? status,
    String? error,
  }) {
    return BillingState(
      invoices: invoices ?? this.invoices,
      stats: stats ?? this.stats,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [invoices, stats, status, error];
}
