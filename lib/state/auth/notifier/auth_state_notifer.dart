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

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    // print(result.toString());
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      //write logic to create if we want to create or store new user information.

      //await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }
}
