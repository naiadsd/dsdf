import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/customers/providers/customer.dart';
import 'package:dsd/state/routeday/provider/routeday.dart';
import 'package:dsd/state/search/customer_search.dart';
import 'package:dsd/state/userinfo/provider/route_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final customerDataProvider = FutureProvider<List<Customer>>((ref) async {
  final route = ref.watch(currentRouteProvider);
  final day = ref.watch(routeDayProvider);
  final searchText = ref.watch(customerSerachProvider);
  print('$day$route');
  var customers =
      await ref.watch(customerProvider).fetchCustomersfromDB(route, day);
  print(customers.length);
  if (searchText.isNotEmpty) {
    return customers
        .where((element) => (element.customerName.contains(searchText)))
        .toList();
  } else {
    return customers;
  }
});
