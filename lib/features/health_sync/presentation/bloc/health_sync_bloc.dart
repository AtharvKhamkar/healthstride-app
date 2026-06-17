import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstride/features/health_sync/domain/health_sync_repository_interface.dart';

part 'health_sync_event.dart';
part 'health_sync_state.dart';

class HealthSyncBloc extends Bloc<HealthSyncEvent, HealthSyncState> {
  final HealthSyncRepositoryInterface _healthSyncRepository;

  HealthSyncBloc({required HealthSyncRepositoryInterface healthSyncRepository})
    : _healthSyncRepository = healthSyncRepository,
      super(HealthSyncInitial()) {
    on<SyncHealthDataRequested>(_onSyncHealthDataRequested);
  }

  Future<void> _onSyncHealthDataRequested(
    SyncHealthDataRequested event,
    Emitter<HealthSyncState> emit,
  ) async {
    emit(HealthSyncLoading());

    final result = await _healthSyncRepository.syncHealthData();

    result.fold(
      (failure) {
        emit(HealthSyncFailure(message: failure.message));
      },

      (_) {
        emit(HealthSyncSuccess());
      },
    );
  }
}
