import 'package:ecoms/model/customer_model.dart';
import 'package:hive/hive.dart';

class HiveService {
  // Open the "customers" box that stores Customer objects and _customerBox is the DB table
  final Box<Customer> _customerBox = Hive.box<Customer>('customers');

  //Create Method
  Future<void> addCustomer(Customer custcrt) async {
    await _customerBox.add(custcrt);
  }

  //Read Method
  Future<List<Customer>> getCustomer() async {
    return _customerBox.values.toList();
  }

  //update Method
  Future<void> updateCustomer(int index, Customer custupdt) async {
    await _customerBox.putAt(index, custupdt); //map style (ID value pair)
  }

  //deletee Method
  Future<void> deleteCustomer(int index) async {
    await _customerBox.deleteAt(index);
  }
}
