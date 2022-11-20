import 'package:dsd/state/userinfo/model/user.dart';
import 'package:dsd/state/userinfo/notifier/userdetails.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userDetailsProvider =
    StateNotifierProvider<UserDetailsStateNotifier, User>(
  (ref) => UserDetailsStateNotifier(),
);
