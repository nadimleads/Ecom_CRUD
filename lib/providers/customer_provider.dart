import 'package:ecoms/model/customer_model.dart';
import 'package:ecoms/repositories/customer_repo.dart';
import 'package:ecoms/services/hive_service.dart';
import 'package:flutter_riverpod/legacy.dart';

class CustomerNotifier extends StateNotifier<List<Customer>> {
  final CustomerRepo repo;

  CustomerNotifier(this.repo) : super([]) {
    loadCustomer();
  }

  Future<void> loadCustomer() async {
    state = await repo.getCustomer(); //connection with repo
  }

  void addCustomer(Customer custadd) async {
    await repo.addCustomr(custadd); //connection with repo
    await loadCustomer();
  }

  void updateCustomer(int indexx, Customer customerUpRiv) async {
    await repo.updateCustomer(indexx, customerUpRiv); //connection with repo
    await loadCustomer();
  }

  void deleteCustomer(int indx) async {
    await repo.deleteCustomer(indx); //connection with repo
    await loadCustomer();
  }
}

final customerProvider =
    StateNotifierProvider<CustomerNotifier, List<Customer>>((ref) {
      final hive = HiveService(); // ← created here
      final repository = CustomerRepo(hive); // ← depends on hive

      return CustomerNotifier(repository); // ← depends on repo
    });
