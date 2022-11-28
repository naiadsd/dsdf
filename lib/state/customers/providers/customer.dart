import 'package:dsd/state/customers/backend/customer_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final customerProvider = Provider(((ref) => const CustomerService()));
