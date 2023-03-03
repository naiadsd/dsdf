import 'package:dsd/state/customers/backend/customer_service.dart';
import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/customers/model/customer_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerDataNotifier extends StateNotifier<CustomerService> {
  CustomerDataNotifier(super.state);
}

class CustomerStateNotifier extends StateNotifier<CustomerState> {
  CustomerStateNotifier() : super(CustomerState.unknown()) {
    fetchFromDB();
    // state = CustomerState(
    //     customers: null, totalRecords: 0, lastfetchedOn: DateTime.now());
  }

  Future<bool> fetchFromDB() async {
    try {
      List<Customer> customersInDB = await fetchCustomersfromDB();
      state = state.loadState(customersInDB);
      print('fetching from db for initial db');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
