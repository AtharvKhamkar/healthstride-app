part of 'health_sync_bloc.dart';

sealed class HealthSyncState extends Equatable {
  const HealthSyncState();

  @override
  List<Object> get props => [];
}

final class HealthSyncInitial extends HealthSyncState {}

final class HealthSyncLoading extends HealthSyncState {}

final class HealthSyncSuccess extends HealthSyncState {}

final class HealthSyncFailure extends HealthSyncState {
  final String message;

  const HealthSyncFailure({required this.message});
}
