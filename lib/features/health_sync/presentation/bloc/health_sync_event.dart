part of 'health_sync_bloc.dart';

sealed class HealthSyncEvent extends Equatable {
  const HealthSyncEvent();

  @override
  List<Object> get props => [];
}

class SyncHealthDataRequested extends HealthSyncEvent{}






