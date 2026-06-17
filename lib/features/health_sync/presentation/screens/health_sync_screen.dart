import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstride/core/constants/app_colors.dart';
import 'package:healthstride/features/health_sync/presentation/bloc/health_sync_bloc.dart';

class HealthSyncScreen extends StatefulWidget {
  const HealthSyncScreen({super.key});

  @override
  State<HealthSyncScreen> createState() => _HealthSyncScreenState();
}

class _HealthSyncScreenState extends State<HealthSyncScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Health Sync Screen')),
      body: BlocConsumer<HealthSyncBloc, HealthSyncState>(
        listener: (context, state) {
          if (state is HealthSyncSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Sync Successful')));
          }

          if (state is HealthSyncFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.orChipText),
                  child: TextButton(
                    onPressed: state is HealthSyncLoading
                        ? null
                        : () {
                            context.read<HealthSyncBloc>().add(
                              SyncHealthDataRequested(),
                            );
                          },
                    child: state is HealthSyncLoading
                        ? const CircularProgressIndicator.adaptive()
                        : Text(
                            'Sync Data',
                            style: TextStyle(color: AppColors.googleButtonText),
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
