import 'package:dsd/state/models/auth_results.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class User {
  final String? id;
  final String? email;
  final String? password;
  final String? dailyNote;
  final int? totalOrders;
  final double? valueAdded;
  final bool? isloading;
  final AuthResult? result;

  const User({
    required this.id,
    this.email,
    this.password,
    this.dailyNote,
    this.totalOrders,
    this.valueAdded,
    this.isloading,
    this.result,
  });

  const User.unknown()
      : result = null,
        isloading = false,
        id = null;

  User copiedwithIsLoading(bool isload) => User(
        id: id,
        email: email,
        password: password,
        dailyNote: dailyNote,
        totalOrders: totalOrders,
        valueAdded: valueAdded,
        isloading: isload,
        result: result,
      );

  @override
  bool operator ==(covariant User other) =>
      identical(this, other) || id == other.id;

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(id, email);
}
