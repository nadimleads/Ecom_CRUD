import 'package:ecoms/model/customer_model.dart';
import 'package:hive/hive.dart';

// class HiveService {
//   final Box<Customer> _customerBox = Hive.box<Customer>('customers');

//   // CREATE
//   Future<void> addCustomer(Customer customer) async {
//     await _customerBox.add(customer);
//   }

//   // READ
//   List<Customer> getCustomers() {
//     return _customerBox.values.toList();
//   }

//   // UPDATE
//   Future<void> updateCustomer(int index, Customer customer) async {
//     await _customerBox.putAt(index, customer);
//   }

//   // DELETE
//   Future<void> deleteCustomer(int index) async {
//     await _customerBox.deleteAt(index);
//   }
// }
