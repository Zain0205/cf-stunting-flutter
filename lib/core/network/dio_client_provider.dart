import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/core/data/local/shared_prefs_storage_service_provider.dart';
import 'dio_client.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  try {
    final storageService = ref.watch(storageServiceSyncProvider);
    return DioClient(storageService: storageService);
  } catch (e) {
    // Fallback: create DioClient dengan storage service yang baru
    // Ini akan terjadi kalau storageServiceSyncProvider throw exception
    throw Exception(
      'DioClient tidak bisa dibuat karena StorageService belum ready: $e',
    );
  }
});
