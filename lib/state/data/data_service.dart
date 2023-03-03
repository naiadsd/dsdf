import 'package:dsd/db/db_provider.dart';
import 'package:dsd/state/customers/backend/customer_service.dart';
import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/customers/model/customer_state.dart';
import 'package:dsd/state/customers/providers/customer_data_provider.dart';
import 'package:dsd/state/items/backend/item_service.dart';
import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/state/promo/model/promo.dart';
import 'package:dsd/state/promo/service/promo_service.dart';
import 'package:dsd/state/userinfo/backend/userdetailservice.dart';
import 'package:dsd/state/userinfo/model/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> fetchAndStoreCustomers(int route, int day, int week) async {
  try {
    List<Promo> promos = await const PromoService().fetchPromos();

    List<Promo> promosToday = promos.where((e) {
      return e.startDate.isBefore(DateTime.now()) &&
          DateTime.now().isBefore(e.endDate);
    }).toList();

    List<Customer> customers =
        await fetchCustomersForRouteAndDayAndWeek(route, day, week);
    print('${promosToday.length} promo fetched ');
    if (promosToday.isEmpty) {
    } else {
      await DBProvier.db.storeAllPromos(promosToday);
      for (var e in customers) {
        String customerId = e.customerId;
        //AND-03-SF
        String cutomerPrefix = customerId.substring(0, 4);

        bool hasPromo = promosToday.any((element) {
          return (element.customerPrefix == cutomerPrefix);
        });
        if (hasPromo) {
          print(e.customerId);
        }
        e.isPromoAvailable = hasPromo;
      }
    }
    await DBProvier.db.storeAllCustomers(customers);

    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> fetchAndStoreItems() async {
  try {
    List<Item> items = await fetchItemsSave();
    await DBProvier.db.storeAllItems(items);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> initialCusomerRefresh(int route, WidgetRef ref) async {
  late SharedPreferences pref;
  try {
    List<Promo> promos = await const PromoService().fetchPromos();

    List<Promo> promosToday = promos.where((e) {
      return e.startDate.isBefore(DateTime.now()) &&
          DateTime.now().isBefore(e.endDate);
    }).toList();

    int day = 0;
    int week = 0;

    pref = await SharedPreferences.getInstance();

    var routeDay = pref.getInt('routeday');

    if (routeDay != null) {
      day = routeDay;
    }
    var wee = pref.getInt('weekroute');
    if (wee != null) {
      week = wee;
    }

    List<Customer> customers =
        await fetchCustomersForRouteAndDayAndWeek(route, day, week);
    print('line form data_serve');
    print(customers.length);
    if (promosToday.isEmpty) {
    } else {
      await DBProvier.db.storeAllPromos(promosToday);
      for (var e in customers) {
        String customerId = e.customerId;
        //AND-03-SF
        String cutomerPrefix = customerId.substring(0, 4);

        bool hasPromo = promosToday.any((element) {
          return (element.customerPrefix == cutomerPrefix);
        });
        if (hasPromo) {}
        e.isPromoAvailable = hasPromo;
      }
    }
    await DBProvier.db.deleteAllCustomers();
    await DBProvier.db.deleteAllItems();
    await DBProvier.db.deleteAllPromos();
    //print('deleted local data');
    await DBProvier.db.storeAllCustomers(customers);
    ref.refresh(customerStateProvider.notifier).fetchFromDB();
    // print('stored all customers');
    // print(ref);
    // ref.read(customerStateProvider.notifier).state = CustomerState(
    //     customers: customers,
    //     totalRecords: customers.length,
    //     lastfetchedOn: DateTime.now());
    print('got customer Provider');
    //await customerDataProvider.fetchFromDB();
    return true;
  } catch (e) {
    return false;
  }
}

Future<User> fetchUserDetails(String uuid) async {
  final result = await const UserDetailService().fetchUserDetails(uuid);

  return User(
    lastName: result.lastName,
    uuid: uuid,
    phoneNumber: result.phoneNumber,
    id: result.id,
    email: result.email,
    role: result.role,
    firstName: result.firstName,
    route: result.route,
    userId: result.userId,
    note: result.note,
    totalOrders: result.totalOrders,
    valueAdded: result.valueAdded,
  );
}

Future<bool> initialRefresh(int route) async {
  late SharedPreferences pref;
  try {
    List<Promo> promos = await const PromoService().fetchPromos();

    List<Promo> promosToday = promos.where((e) {
      return e.startDate.isBefore(DateTime.now()) &&
          DateTime.now().isBefore(e.endDate);
    }).toList();

    int day = 0;
    int week = 0;

    pref = await SharedPreferences.getInstance();

    var routeDay = pref.getInt('routeday');

    if (routeDay != null) {
      day = routeDay;
    }
    var wee = pref.getInt('weekroute');
    if (wee != null) {
      week = wee;
    }

    List<Customer> customers =
        await fetchCustomersForRouteAndDayAndWeek(route, day, week);
    print('line form data_serve');
    print(customers.length);
    if (promosToday.isEmpty) {
    } else {
      await DBProvier.db.storeAllPromos(promosToday);
      for (var e in customers) {
        String customerId = e.customerId;
        //AND-03-SF
        String cutomerPrefix = customerId.substring(0, 4);

        bool hasPromo = promosToday.any((element) {
          return (element.customerPrefix == cutomerPrefix);
        });
        if (hasPromo) {}
        e.isPromoAvailable = hasPromo;
      }
    }
    await DBProvier.db.deleteAllCustomers();
    await DBProvier.db.deleteAllItems();
    await DBProvier.db.deleteAllPromos();
    //print('deleted local data');
    await DBProvier.db.storeAllCustomers(customers);
    //ref.refresh(customerStateProvider.notifier).fetchFromDB();
    // print('stored all customers');
    // print(ref);
    // ref.read(customerStateProvider.notifier).state = CustomerState(
    //     customers: customers,
    //     totalRecords: customers.length,
    //     lastfetchedOn: DateTime.now());
    print('got customer Provider');
    //await customerDataProvider.fetchFromDB();
    return true;
  } catch (e) {
    return false;
  }
}
