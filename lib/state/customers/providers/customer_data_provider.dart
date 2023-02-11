import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/customers/model/customer_state.dart';
import 'package:dsd/state/customers/notifier/customer.dart';

import 'package:dsd/state/search/customer_search.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// final customerDataProvider = FutureProvider<List<Customer>>((ref) async {
//   final searchText = ref.watch(customerSerachProvider);
//   var customers = await ref.watch(customerProvider).fetchCustomersfromDB();

//   if (searchText.isNotEmpty) {
//     return customers
//         .where((element) => (element.customerName.contains(searchText) ||
//             element.customerId.contains(searchText)))
//         .toList();
//   } else {
//     return customers;
//   }
// });

final customerStateProvider =
    StateNotifierProvider<CustomerStateNotifier, CustomerState>(
        ((ref) => CustomerStateNotifier()));

final customersLengthProvider = Provider<int>(((ref) {
  final customerProvider = ref.watch(customerStateProvider);
  return customerProvider.totalRecords;
}));

final customersProvider = Provider<List<Customer>?>((ref) {
  final customerProvider = ref.watch(customerStateProvider);
  var customers = customerProvider.customers;

  final searchText = ref.watch(customerSerachProvider);
  print('$searchText from cdp');
  if (searchText.isNotEmpty) {
    return customers!
        .where((element) => (element.customerName.contains(searchText) ||
            element.customerId.contains(searchText)))
        .toList();
  } else {
    return customers;
  }
});
