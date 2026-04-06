import 'package:ecoms/model/customer_model.dart';
import 'package:ecoms/providers/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_customer_dialog.dart';

//full clear na
class CustomerCard extends ConsumerWidget {
  final Customer customer;
  final int index;

  const CustomerCard({super.key, required this.customer, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Customer info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name
                Text(
                  customer.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // phone
                Text("phone: ${customer.phone}"),
                const SizedBox(height: 4),
                // email
                Text("Email: ${customer.email}"),
                const SizedBox(height: 4),
                // Address
                Text("Address: ${customer.address}"),
                const SizedBox(height: 4),
                // SecondaryAddress
                Text("Secondary Address: ${customer.secondaryAddress}"),
              ],
            ),

            // 3 dot menu (Edit/Delete er jonno)
            PopupMenuButton<String>(
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(value: "edit", child: Text("Edit")),
                    const PopupMenuItem(value: "delete", child: Text("Delete")),
                  ],
              onSelected: (value) {
                if (value == "edit") {
                  showDialog(
                    context: context,

                    //ekhane context e (__) keno use holo ar tahole ki notun tree contex create holo?
                    builder:
                        (__) => EditCustomerDialog(
                          customer: customer,
                          index: index,
                        ),
                  );
                }

                if (value == "delete") {
                  showDialog(
                    context: context,
                    builder:
                        (ctx) => AlertDialog(
                          title: const Text('Delete Customer!'),
                          content: Text(
                            'Do You Wnat to Delete this \'${customer.name}\' named Customer?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Cancle'),
                            ),
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(customerProvider.notifier)
                                    .deleteCustomer(index);
                                Navigator.pop(ctx);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                  );
                  //
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
