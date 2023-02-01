import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/customers/providers/customer.dart';

import 'package:dsd/state/search/customer_search.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final customerDataProvider = FutureProvider<List<Customer>>((ref) async {
  final searchText = ref.watch(customerSerachProvider);
  print('trying to get customers from db');
  var customers = await ref.watch(customerProvider).fetchCustomersfromDB();
  print('got customers from db');
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
