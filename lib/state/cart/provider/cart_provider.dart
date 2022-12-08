import 'package:dsd/state/cart/models/cart.dart';
import 'package:dsd/state/cart/notifiers/cart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cartProvider = StateNotifierProvider<CartState, Cart>(
  (ref) => CartState(),
);

final totalCartValueProvider = Provider<double>(((ref) {
  final cartp = ref.watch(cartProvider);

  return cartp.totalPrice ?? 0.0;
}));

final totalCartItemsProvider = Provider<int>(((ref) {
  final cartp = ref.watch(cartProvider);

  return cartp.items?.length ?? 0;
}));
