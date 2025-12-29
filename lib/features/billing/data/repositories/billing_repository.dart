import '../../../../core/network/dio_client.dart';
import '../models/billing_models.dart';

class BillingRepository {
  final DioClient _dioClient;

  BillingRepository(this._dioClient);

  Future<List<Invoice>> listInvoices() async {
    final response = await _dioClient.dio.get('/billing/invoices');
    return (response.data as List)
        .map((e) => Invoice.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Invoice> getInvoice(String id) async {
    final response = await _dioClient.dio.get('/billing/invoices/$id');
    return Invoice.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> payInvoice(String id) async {
    await _dioClient.dio.post('/billing/invoices/$id/pay');
  }

  Future<void> cancelInvoice(String id) async {
    await _dioClient.dio.put('/billing/invoices/$id/cancel');
  }

  Future<BillingStats> getStats() async {
    final response = await _dioClient.dio.get('/billing/stats');
    return BillingStats.fromJson(response.data as Map<String, dynamic>);
  }
}
