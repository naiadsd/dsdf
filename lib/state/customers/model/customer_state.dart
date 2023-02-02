import 'package:dsd/state/customers/model/customer.dart';
import 'package:flutter/material.dart';

@immutable
class CustomerState {
  final List<Customer>? customers;
  final int totalRecords;
  final DateTime lastfetchedOn;

  const CustomerState({
    required this.customers,
    required this.totalRecords,
    required this.lastfetchedOn,
  });

  CustomerState.unknown()
      : customers = null,
        totalRecords = 0,
        lastfetchedOn = DateTime.now();

  CustomerState loadState(List<Customer> inCustomers) => CustomerState(
        customers: inCustomers,
        totalRecords: inCustomers.length,
        lastfetchedOn: DateTime.now(),
      );
}
