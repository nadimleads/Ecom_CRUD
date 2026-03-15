import 'package:ecoms/model/customer_model.dart';
import 'package:flutter/material.dart';

//bujhinai
class CustomerCard extends StatelessWidget {
  final Customer customer;
  final int index;

  const CustomerCard({super.key, required this.customer, required this.index});

  @override
  Widget build(BuildContext context) {
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
                Text(customer.phone),
                const SizedBox(height: 4),
                // email
                Text(customer.email),
                const SizedBox(height: 4),
                // Address
                Text(customer.address),
                const SizedBox(height: 4),
                // SecondaryAddress
                Text(customer.secondaryAddress),
              ],
            ),

            /// 3 dot menu
            PopupMenuButton<String>(
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(value: "edit", child: Text("Edit")),
                    const PopupMenuItem(value: "delete", child: Text("Delete")),
                  ],
              onSelected: (value) {
                if (value == "edit") {
                  // we will implement later
                }

                if (value == "delete") {
                  // we will implement later
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
