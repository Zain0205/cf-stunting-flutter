import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/data/local/shared_prefs_storage_service.dart';

final storageServiceProvider = FutureProvider<SharedPreferencesService>((
  ref,
) async {
  final prefsService = SharedPreferencesService();
  await prefsService.init();
  return prefsService;
});

// Provider sync yang sudah initialized (untuk provider lain yang butuh sync)
final storageServiceSyncProvider = Provider<SharedPreferencesService>((ref) {
  final asyncValue = ref.watch(storageServiceProvider);
  return asyncValue.when(
    data: (value) => value,
    loading: () => throw Exception(
      'StorageService belum di-initialize. Pastikan storageServiceProvider sudah resolved.',
    ),
    error: (error, stackTrace) =>
        throw Exception('StorageService error: $error'),
  );
});
