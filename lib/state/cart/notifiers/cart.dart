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

  createCart(int customerId, String driverId) {
    state = state.createCart(customerId, driverId);
  }

  addItem(CartItem item) {
    print(item.toString());
    state = state.addNewItem(item);
  }

  removeItem(int id) {
    state = state.removeItem(id);
  }

  changeitemQuantity(int id, int quantity) {
    state = state.addItemQuantity(id, quantity);
  }

  double getTotal() {
    double result = 0.0;
    if (state.items != null && state.items!.isNotEmpty) {
      state.items?.forEach((element) {
        result = result + element.totalPrice;
      });
      return result;
    } else {
      return result;
    }
  }

  getItemQuantity(int id) {
    List<CartItem> citems = state.items ?? [];
    if (citems.isNotEmpty) {
      return citems
          .firstWhere(
            (element) => element.itemId == id,
          )
          .quantity;
    } else {
      return 0.0;
    }
  }
}
