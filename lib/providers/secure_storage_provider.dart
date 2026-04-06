//bridge of storage with Riverpod to manage
import 'package:ecoms/services/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final secureStorageProvider = Provider((ref) {
  return SecureStorageService();
});
