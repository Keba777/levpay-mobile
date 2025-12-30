import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/admin_repository.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository _adminRepository;

  AdminBloc(this._adminRepository) : super(AdminInitial()) {
    on<AdminDashboardRequested>(_onDashboardRequested);
    on<AdminUserListRequested>(_onUserListRequested);
  }

  Future<void> _onDashboardRequested(
    AdminDashboardRequested event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      final stats = await _adminRepository.getDashboardStats();
      emit(AdminDashboardLoaded(stats));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onUserListRequested(
    AdminUserListRequested event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      final data = await _adminRepository.listUsers(
        page: event.page,
        search: event.search,
      );
      emit(
        AdminUserListLoaded(
          users: data['records'] ?? [],
          total: data['total'] ?? 0,
          page: data['page'] ?? 1,
        ),
      );
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }
}
