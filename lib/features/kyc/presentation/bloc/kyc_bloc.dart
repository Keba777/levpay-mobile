import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/kyc_repository.dart';
import 'kyc_event.dart';
import 'kyc_state.dart';

class KYCBloc extends Bloc<KYCEvent, KYCState> {
  final KYCRepository kycRepository;

  KYCBloc({required this.kycRepository}) : super(const KYCState()) {
    on<KYCStatusRequested>(_onKYCStatusRequested);
    on<KYCDocumentUploadStarted>(_onKYCDocumentUploadStarted);
    on<KYCReset>(_onKYCReset);
  }

  Future<void> _onKYCStatusRequested(
    KYCStatusRequested event,
    Emitter<KYCState> emit,
  ) async {
    emit(state.copyWith(status: KYCStatus.loading));
    try {
      final res = await kycRepository.getStatus();
      emit(
        state.copyWith(
          status: KYCStatus.success,
          overallStatus: res.overallStatus,
          documents: res.documents,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: KYCStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onKYCDocumentUploadStarted(
    KYCDocumentUploadStarted event,
    Emitter<KYCState> emit,
  ) async {
    emit(state.copyWith(status: KYCStatus.uploading));
    try {
      await kycRepository.uploadDocument(event.type, event.file);
      // After upload, refresh status
      final res = await kycRepository.getStatus();
      emit(
        state.copyWith(
          status: KYCStatus.uploadSuccess,
          overallStatus: res.overallStatus,
          documents: res.documents,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: KYCStatus.uploadFailure, error: e.toString()),
      );
    }
  }

  void _onKYCReset(KYCReset event, Emitter<KYCState> emit) {
    emit(const KYCState());
  }
}
