import 'package:ecoms/model/customer_model.dart';
import 'package:ecoms/services/hive_service.dart';

class CustomerRepo {
  final HiveService _hiveservice;

  CustomerRepo(this._hiveservice);

  Future<void> addCustomr(Customer custc) async {
    await _hiveservice.addCustomer(custc);
  }

  Future<List<Customer>> getCustomer() {
    return _hiveservice.getCustomer();
  }

  Future<void> updateCustomer(int index, Customer customerUpdate) {
    return _hiveservice.updateCustomer(index, customerUpdate);
  }

  Future<void> deleteCustomer(int index) {
    return _hiveservice.deleteCustomer(index);
  }
}
