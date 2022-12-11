import 'dart:io';

import 'package:dsd/db/customer/customer_db_constants.dart';
import 'package:dsd/db/item/item_db_contants.dart';
import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/items/models/item.dart';
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
      await createCustomersTable(db);
      await createItemsTable(db);
    }));
  }

  createCustomer(Customer customer) async {
    final db = await database;

    final res = await db.insert(customerTable, customer.toJson());

    return res;
  }

  createItem(Item item) async {
    final db = await database;
    final res = await db.insert(itemsTable, item.toJson());

    return res;
  }

  Future<List<Customer>> getAllCustomers() async {
    final db = await database;
    final res = await db.rawQuery("select * from $customerTable");

    List<Customer> list =
        res.isNotEmpty ? res.map((e) => Customer.fromJson(e)).toList() : [];

    return list;
  }

  Future<Item> getItemById(int id) async {
    final db = await database;
    final res =
        await db.rawQuery('select * from $itemsTable where $itemId=$id');

    List<Item> items =
        res.isNotEmpty ? res.map((e) => Item.fromJson(e)).toList() : [];
    Item c = items[0];
    return c;
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
    for (var element in customers) {
      await createCustomer(element);
    }
  }

  Future<List<Item>> getAllItems() async {
    final db = await database;
    final res = await db.rawQuery('select * from $itemsTable');
    List<Item> items =
        res.isNotEmpty ? res.map((e) => Item.fromJson(e)).toList() : [];

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

  Future<int> deleteAllCustomers() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM $customerTable');

    return res;
  }
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
