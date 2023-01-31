import 'package:dsd/state/auth/backend/authenticator.dart';
import 'package:dsd/state/cart/models/cart.dart';
import 'package:dsd/state/cart/models/cart_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartState extends StateNotifier<Cart> {
  final _authenticator = const Authenticator();

  CartState() : super(Cart.initial()) {
    if (_authenticator.isAlreadyLoggedIn) {}
    {}
  }

  initiateCart(String customerId) {
    state = state.copiedWithCustomer(customerId);
  }

  createCart(
    String customerId,
    String driverId,
    String custoemrId,
    String driverName,
  ) {
    state = state.createCart(customerId, driverId, custoemrId, driverId);
  }

  addItem(CartItem item) {
    state = state.addNewItem(item);
  }

  removeItem(String itemId) {
    state = state.removeItem(itemId);
  }

  changeitemQuantity(String itemId, int quantity) {
    state = state.addItemQuantity(itemId, quantity);
  }

  setDetails(String invoiceNumber, String customerName, int orderQuantity,
      String drivername) {
    state.orderId = invoiceNumber;
    state.customerName = customerName;
    state.orderQty = orderQuantity;
    state.driverName = drivername;
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

  getItemQuantity(String id) {
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
