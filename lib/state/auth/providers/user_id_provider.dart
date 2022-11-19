import 'package:dsd/state/auth/providers/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userIdProvider = Provider<String>((ref) {
  final authProvider = ref.watch(authStateProvider);

  return authProvider.userId ?? '';
});
