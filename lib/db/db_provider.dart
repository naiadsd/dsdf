import 'dart:convert';
import 'dart:io';

import 'package:dsd/db/customer/customer_db_constants.dart';
import 'package:dsd/db/item/item_db_contants.dart';
import 'package:dsd/db/promo/promo_constants.dart';
import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/state/promo/model/promo.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvier {
  static Database? _database;

  Future<Database> get database async => _database ??= await initDB();

  static final DBProvier db = DBProvier._();

  DBProvier._();

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'dsd.db');

    return await openDatabase(path, version: 1, onOpen: ((db) async {
      await createPromoTable(db);
      await createCustomersTable(db);
      await createItemsTable(db);
    }));
  }
/*Promos logic start*/

  createPromo(Promo promo) async {
    final db = await database;

    final res = await db.insert(promoTable, promo.toJson());
    return res;
  }

  Future<List<Promo>> getAllPromos() async {
    final db = await database;

    final res = await db.rawQuery("select * from $promoTable");

    List<Promo> list =
        res.isNotEmpty ? res.map((e) => Promo.fromJson(e)).toList() : [];

    return list;
  }

  dropPromotable() async {
    final db = await database;
    db.execute('DROP TABLE IF EXISTS $promoTable');
  }

  storeAllPromos(List<Promo> promos) async {
    await deleteAllPromos();
    for (var element in promos) {
      await createPromo(element);
    }
  }

  Future<int> deleteAllPromos() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM $promoTable');

    return res;
  }

/*promos logic ends*/

/*customers logic Start*/
  createCustomer(Customer customer) async {
    final db = await database;

    final res = await db.insert(customerTable, customer.toJson());

    return res;
  }

  Future<List<Promo>> getPromosForCustomer(String customerId) async {
    String table = promoTable;
    final db = await database;
    String cutomerPrefix = customerId.substring(0, 4);
    List<dynamic> whereArguments = [cutomerPrefix];

    String whereString = '$customerPrefix = ?';
    final res =
        await db.query(table, where: whereString, whereArgs: whereArguments);
    List<Promo> promos = res.map((e) => Promo.fromJson(e)).toList();
    return promos;
  }

  Future<List<Customer>> searchCustomer(String search) async {
    final db = await database;
    final res = await db.rawQuery(
        "select * from $customerTable where $customerName like '%$search%' OR $customerId like '%$search%'  OR $shipToAddressLineOne like '%$search%'");

    List<Customer> list =
        res.isNotEmpty ? res.map((e) => Customer.fromJson(e)).toList() : [];

    return list;
  }

  storeAllCustomers(List<Customer> customers) async {
    await deleteAllCustomers();
    for (var element in customers) {
      await createCustomer(element);
    }
  }

  Future<int> deleteAllCustomers() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM $customerTable');

    return res;
  }

  Future<Customer> getCustomerById(String custoemrId) async {
    final db = await database;
    String whereString = '$customerId = ?';
    String table = customerTable;
    List<dynamic> whereArguments = [custoemrId];
    final res =
        await db.query(table, where: whereString, whereArgs: whereArguments);

    List<Customer> customers =
        res.isNotEmpty ? res.map((e) => Customer.fromJsonDB(e)).toList() : [];
    Customer c = customers[0];
    return c;
  }
/*customers logic End*/

/* Item logic*/

  createItem(Item item) async {
    final db = await database;
    final res = await db.insert(itemsTable, item.toJson());

    return res;
  }

  Future<List<Customer>> getAllCustomers() async {
    final db = await database;
    final res = await db.rawQuery("select * from $customerTable");

    List<Customer> list =
        res.isNotEmpty ? res.map((e) => Customer.fromJsonDB((e))).toList() : [];

    return list;
  }

  storeAllItems(List<Item> items) async {
    await deleteAllItems();
    for (var element in items) {
      await createItem(element);
    }
  }

  Future<List<Item>> getAllItems() async {
    final db = await database;
    final res = await db.rawQuery(
        "select * from $itemsTable where ($itemId not like '%%%%996' and $itemId not like '%%%%997' and $itemId not like '%%%%998' and $itemId not like '%%%%999' )");
    List<Item> items =
        res.isNotEmpty ? res.map((e) => Item.fromJsonDB(e)).toList() : [];

    return items;
  }

  Future<List<Item>> searchItems(String search) async {
    final db = await database;

    final res = await db.rawQuery(
        "select * from $itemsTable where $description like '%$search%' OR $name like '%$search%' OR $itemId like '%$search%' ");

    List<Item> items =
        res.isNotEmpty ? res.map((e) => Item.fromJson(e)).toList() : [];

    return items;
  }

  Future<int> deleteAllItems() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM $itemsTable');

    return res;
  }

  Future<Item> getItemById(String itemId) async {
    print('item id is');
    print(itemId);
    final db = await database;
    String whereString = 'itemId = ?';
    String table = itemsTable;
    List<dynamic> whereArguments = [itemId];
    final res =
        await db.query(table, where: whereString, whereArgs: whereArguments);

    List<Item> items =
        res.isNotEmpty ? res.map((e) => Item.fromJsonDB(e)).toList() : [];
    Item c = items[0];
    return c;
  }

  Future<void> clearData() async {
    print('clearing data');
    await deleteAllCustomers();
    await deleteAllPromos();
    await deleteAllCustomers();

    print('cleared');
  }

/*Items logic End */

/* Creating tables */

  Future<void> createPromoTable(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS $promoTable ('
        'id INTEGER PRIMARY KEY,'
        '$itemPrefix TEXT,'
        '$customerPrefix TEXT,'
        '$startDate TEXT,'
        '$endDate TEXT,'
        '$promoId TEXT,'
        '$price NUMERIC'
        ')');
  }

  Future<void> createCustomersTable(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS $customerTable ('
        'id INTEGER PRIMARY KEY,'
        '$billToAddressLineOne TEXT,'
        '$accountNo TEXT,'
        '$shipToAddressLineOne TEXT,'
        '$prepaidTerms TEXT,'
        '$shipToAddressLineTwo TEXT,'
        '$serviceSequence TEXT,'
        '$isInactive BOOLEAN,'
        '$billFirstName TEXT,'
        '$billLastName TEXT,'
        '$shipToCity TEXT,'
        '$shipToSate TEXT,'
        '$billToAddressLineTwo TEXT,'
        '$routeCode TEXT,'
        '$billToZip TEXT,'
        '$discountDays TEXT,'
        '$serviceDays TEXT,'
        '$billToCity TEXT,'
        '$serviceFrequency TEXT,'
        '$creditLimit TEXT,'
        '$customerId TEXT,'
        '$phone TEXT,'
        '$codTerms TEXT,'
        '$salesAccount TEXT,'
        '$billToState TEXT,'
        '$pricingLevel TEXT,'
        '$discountPercentage TEXT,'
        '$customerName TEXT,'
        '$shipToZip TEXT,'
        '$useStandardTerms TEXT,'
        '$dueDays TEXT,'
        '$soldhere TEXT,'
        '$isPromoAvailable BOOLEAN'
        ')');
  }

  Future<void> createItemsTable(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS $itemsTable ('
        'id INTEGER PRIMARY KEY,'
        '$itemId TEXT,'
        '$isItemInActive BOOLEAN,'
        '$salePriceSeven NUMERIC,'
        '$salePriceTwo NUMERIC,'
        '$salePrice NUMERIC,'
        '$glCOGSSalaryAccount TEXT,'
        '$upcsku TEXT,'
        '$weight TEXT,'
        '$glInventoryAccount TEXT,'
        '$salePriceFour NUMERIC,'
        '$description TEXT,'
        '$name TEXT,'
        '$salePriceThree NUMERIC,'
        '$salePriceEight NUMERIC,'
        '$descriptionForSales NUMERIC,'
        '$orderSeq INTEGER,'
        '$salePriceFive NUMERIC,'
        '$salePriceNine NUMERIC,'
        '$salePriceTen NUMERIC,'
        '$salePriceSix NUMERIC,'
        '$reOrderQuantity TEXT'
        ')');
  }
}
