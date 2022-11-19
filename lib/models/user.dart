import 'package:dsd/state/auth/models/auth_results.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class User {
  final String? id;
  final String? email;
  final String? password;
  final String? dailyNote;
  final int? totalOrders;
  final double? valueAdded;
  final AuthResult? result;

  const User({
    required this.id,
    required this.email,
    required this.password,
    required this.dailyNote,
    required this.totalOrders,
    required this.valueAdded,
    required this.result,
  });

  @override
  bool operator ==(covariant User other) =>
      identical(this, other) || id == other.id;

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(id, email);
}
