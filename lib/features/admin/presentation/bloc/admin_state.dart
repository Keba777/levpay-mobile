part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminDashboardLoaded extends AdminState {
  final Map<String, dynamic> stats;

  const AdminDashboardLoaded(this.stats);

  @override
  List<Object> get props => [stats];
}

class AdminUserListLoaded extends AdminState {
  final List<dynamic> users;
  final int total;
  final int page;

  const AdminUserListLoaded({
    required this.users,
    required this.total,
    required this.page,
  });

  @override
  List<Object> get props => [users, total, page];
}

class AdminError extends AdminState {
  final String message;

  const AdminError(this.message);

  @override
  List<Object> get props => [message];
}
