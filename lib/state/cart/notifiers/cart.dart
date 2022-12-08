import 'package:dsd/state/auth/backend/authenticator.dart';
import 'package:dsd/state/cart/models/cart.dart';
import 'package:dsd/state/cart/models/cart_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartState extends StateNotifier<Cart> {
  //get stored cart from local database
  Future _init() async {}
  final _authenticator = const Authenticator();
  CartState() : super(Cart.initial()) {
    //
    if (_authenticator.isAlreadyLoggedIn) {}
    {}
  }

  initiateCart(int customerId) {
    state = state.copiedWithCustomer(customerId);
  }

  addItem(CartItem item) {
    state = state.addNewItem(item);
  }

  addnewItem(int id, int quantity, double price) {
    state = state.addItemQuantity(id, quantity, price);
  }
}
