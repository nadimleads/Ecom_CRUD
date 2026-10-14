import 'package:ecoms/model/customer_model.dart';
import 'package:ecoms/model/gender_model.dart';
import 'package:ecoms/providers/customer_provider.dart';
import 'package:ecoms/utils/blood_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_customer_dialog.dart';

class CustomerCard extends ConsumerWidget {
  final Customer customer;
  final int index;

  const CustomerCard({super.key, required this.customer, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Optional: Show full details on tap
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.green.shade100,
                child: Text(
                  customer.name.isNotEmpty
                      ? customer.name[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Customer Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + Blood Group
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            customer.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            formatBloodGroup(customer.bloodgroup),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Phone
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          "Pnone: ${customer.phone}",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Email
                    Row(
                      children: [
                        const Icon(Icons.email, size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "Email: ${customer.email}",

                            style: const TextStyle(fontSize: 15),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    //Gender
                    Row(
                      children: [
                        Icon(
                          customer.gender == GenderModel.male
                              ? Icons.male
                              : customer.gender == GenderModel.female
                              ? Icons.female
                              : Icons.person_rounded,
                          size: 17,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Gender: ${customer.gender.name}",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Address
                    Text(
                      "Adderss: ${customer.address}",
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    //Secondery Address
                    const SizedBox(height: 4),
                    Text(
                      "Secondery Address: ${customer.secondaryAddress}",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              // Menu Button
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                itemBuilder:
                    (context) => [
                      const PopupMenuItem(
                        value: "edit",
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 8),
                            Text("Edit"),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: "delete",
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 20, color: Colors.red),
                            SizedBox(width: 8),
                            Text("Delete", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                onSelected: (value) {
                  if (value == "edit") {
                    showDialog(
                      context: context,
                      builder:
                          (_) => EditCustomerDialog(
                            customer: customer,
                            index: index,
                          ),
                    );
                  } else if (value == "delete") {
                    showDialog(
                      context: context,
                      builder:
                          (ctx) => AlertDialog(
                            title: const Text('Delete Customer'),
                            content: Text(
                              'Are you sure you want to delete "${customer.name}"?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(customerProvider.notifier)
                                      .deleteCustomer(index);
                                  Navigator.pop(ctx);
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
