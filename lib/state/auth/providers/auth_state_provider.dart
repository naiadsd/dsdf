import 'package:dsd/state/auth/models/authstate.dart';
import 'package:dsd/state/auth/notifier/auth_state_notifer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(),
);
