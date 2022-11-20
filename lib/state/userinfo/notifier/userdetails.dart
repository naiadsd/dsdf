import 'package:dsd/state/auth/backend/authenticator.dart';
import 'package:dsd/state/userinfo/backend/userdetailservice.dart';
import 'package:dsd/state/userinfo/model/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserDetailsStateNotifier extends StateNotifier<User> {
  final _userSerevice = const UserDetailService();
  final _authenticator = const Authenticator();

  UserDetailsStateNotifier() : super(User.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = User(
        lastName: null,
        uuid: _authenticator.userId,
        phoneNumber: null,
        id: null,
        email: null,
        role: null,
        firstName: null,
        route: null,
        userId: _authenticator.userId,
        note: null,
        totalOrders: null,
        valueAdded: null,
      );
    }
  }

  Future<void> fetchUserDetails(String uuid) async {
    final result = await _userSerevice.fetchUserDetails(uuid);
    state = User(
      lastName: result.lastName,
      uuid: uuid,
      phoneNumber: result.phoneNumber,
      id: result.id,
      email: result.email,
      role: result.role,
      firstName: result.firstName,
      route: result.route,
      userId: result.userId,
      note: result.note,
      totalOrders: result.totalOrders,
      valueAdded: result.valueAdded,
    );
  }
}
