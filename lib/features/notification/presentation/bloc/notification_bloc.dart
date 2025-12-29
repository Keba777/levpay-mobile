import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/notification_models.dart';
import '../../data/repositories/notification_repository.dart';

// --- Events ---
abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object?> get props => [];
}

class NotificationListRequested extends NotificationEvent {}

class NotificationMarkAsReadRequested extends NotificationEvent {
  final String id;
  const NotificationMarkAsReadRequested(this.id);
  @override
  List<Object?> get props => [id];
}

// --- Status enum ---
enum NotificationStatus { initial, loading, success, failure }

// --- State ---
class NotificationState extends Equatable {
  final List<NotificationItem> notifications;
  final int unreadCount;
  final NotificationStatus status;
  final String? error;

  const NotificationState({
    this.notifications = const [],
    this.unreadCount = 0,
    this.status = NotificationStatus.initial,
    this.error,
  });

  NotificationState copyWith({
    List<NotificationItem>? notifications,
    int? unreadCount,
    NotificationStatus? status,
    String? error,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [notifications, unreadCount, status, error];
}

// --- BLoC ---
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository repository;

  NotificationBloc({required this.repository})
    : super(const NotificationState()) {
    on<NotificationListRequested>(_onListRequested);
    on<NotificationMarkAsReadRequested>(_onMarkAsReadRequested);
  }

  Future<void> _onListRequested(
    NotificationListRequested event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(status: NotificationStatus.loading));
    try {
      final notifications = await repository.listNotifications();
      final unreadCount = await repository.getUnreadCount();
      emit(
        state.copyWith(
          status: NotificationStatus.success,
          notifications: notifications,
          unreadCount: unreadCount,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: NotificationStatus.failure, error: e.toString()),
      );
    }
  }

  Future<void> _onMarkAsReadRequested(
    NotificationMarkAsReadRequested event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await repository.markAsRead(event.id);
      final notifications = await repository.listNotifications();
      final unreadCount = await repository.getUnreadCount();
      emit(
        state.copyWith(
          status: NotificationStatus.success,
          notifications: notifications,
          unreadCount: unreadCount,
        ),
      );
    } catch (e) {
      // Optioally handle error
    }
  }
}
