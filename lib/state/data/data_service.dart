import 'package:dsd/db/db_provider.dart';
import 'package:dsd/state/customers/backend/customer_service.dart';
import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/items/backend/item_service.dart';
import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/state/promo/model/promo.dart';
import 'package:dsd/state/promo/service/promo_service.dart';

Future<bool> fetchStoreDailyData(int route, int day) async {
  try {
    List<Promo> promos = await const PromoService().fetchPromos();

    List<Promo> promosToday = promos.where((e) {
      return e.startDate.isBefore(DateTime.now()) &&
          DateTime.now().isBefore(e.endDate);
    }).toList();

    List<Customer> customers = await fetchCustomersForSave(route, day);

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
        e.isPromoAvailable = hasPromo;
      }
    }
    await DBProvier.db.storeAllCustomers(customers);
    List<Item> items = await fetchItemsSave();
    await DBProvier.db.storeAllItems(items);

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
