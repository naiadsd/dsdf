import 'package:dsd/models/auth/auth_results.dart';

class User {
  final int? id;
  final String? email;
  final String? password;

  final String? dailyNote;
  final int? totalOrders;
  final double? valueAdded;
  final bool? isloading;
  final AuthResult? result;
  const User(
    this.id,
    this.email,
    this.password,
    this.dailyNote,
    this.totalOrders,
    this.valueAdded,
    this.isloading,
    this.result,
  );

  const User.unknown(
    this.email,
    this.password,
    this.dailyNote,
    this.totalOrders,
    this.valueAdded,
  )   : result = null,
        isloading = false,
        id = null;

  User copiedwithIsLoading(bool isload) => User(
        id,
        email,
        password,
        dailyNote,
        totalOrders,
        valueAdded,
        isload,
        result,
      );

  @override
  bool operator ==(covariant User other) =>
      identical(this, other) || id == other.id;

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(id, email);
}
