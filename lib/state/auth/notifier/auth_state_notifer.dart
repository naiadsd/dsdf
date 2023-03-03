import 'package:dsd/state/auth/backend/authenticator.dart';
import 'package:dsd/state/auth/models/auth_results.dart';
import 'package:dsd/state/auth/models/authstate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logout() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<AuthResult> loginWithEmailPassword(
      String email, String password) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithEmailPassword(email, password);
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      state = AuthState(
        result: result,
        isLoading: false,
        userId: _authenticator.userId,
      );
      return AuthResult.success;
    }
    return AuthResult.failure;
  }

  Future<String?> loginWithEmailPasswordNew(
      String email, String password) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithEmailPassword(email, password);
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      return userId;
    }
    return null;
  }

  Future<bool> setLoginState(String userId) async {
    state =
        AuthState(result: AuthResult.success, isLoading: false, userId: userId);
    return true;
  }

  Future<AuthResult> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      state = AuthState(
        result: result,
        isLoading: false,
        userId: _authenticator.userId,
      );
      return AuthResult.success;
    }

    return AuthResult.failure;
  }
}
