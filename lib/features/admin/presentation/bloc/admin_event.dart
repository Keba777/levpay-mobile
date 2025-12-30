part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class AdminDashboardRequested extends AdminEvent {}

class AdminUserListRequested extends AdminEvent {
  final int page;
  final String search;

  const AdminUserListRequested({this.page = 1, this.search = ''});

  @override
  List<Object> get props => [page, search];
}
