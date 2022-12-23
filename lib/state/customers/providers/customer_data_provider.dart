import 'package:dsd/db/db_provider.dart';
import 'package:dsd/state/customers/backend/customer_service.dart';
import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/customers/providers/customer.dart';
import 'package:dsd/state/items/backend/item_service.dart';
import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/state/promo/model/promo.dart';
import 'package:dsd/state/promo/service/promo_service.dart';
import 'package:dsd/state/routeday/provider/routeday.dart';
import 'package:dsd/state/search/customer_search.dart';
import 'package:dsd/state/userinfo/provider/route_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final customerDataProvider = FutureProvider<List<Customer>>((ref) async {
  final route = ref.watch(currentRouteProvider);
  final day = ref.watch(routeDayProvider);
  final searchText = ref.watch(customerSerachProvider);

  var customers =
      await ref.watch(customerProvider).fetchCustomersfromDB(route, day);
  if (searchText.isNotEmpty) {
    return customers
        .where((element) => (element.customerName.contains(searchText) ||
            element.customerId.contains(searchText)))
        .toList();
  } else {
    return customers;
  }
});

// final getPromosForCustomer = FutureProvider<List<Promo>>(((ref) async{
//   return await DBProvier.db.getPromosForCustomer(customerId)
// }));
