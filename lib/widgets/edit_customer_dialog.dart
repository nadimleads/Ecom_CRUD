import 'package:ecoms/model/customer_model.dart';
import 'package:ecoms/providers/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditCustomerDialog extends ConsumerStatefulWidget {
  final Customer customer;
  final int index;

  const EditCustomerDialog({
    super.key,
    required this.customer,
    required this.index,
  });

  @override
  ConsumerState<EditCustomerDialog> createState() => _EditCustomerDialogState();
}

class _EditCustomerDialogState extends ConsumerState<EditCustomerDialog> {
  //putting this Inside This private Class
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emialController;
  late TextEditingController _addressController;
  late TextEditingController _secondaryaddressController;

  //prefilled thakar jonno initState use kora holo
  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.customer.name);
    _phoneController = TextEditingController(
      text: widget.customer.phone.replaceFirst("+88", ""),
    );
    _emialController = TextEditingController(text: widget.customer.email);
    _addressController = TextEditingController(text: widget.customer.address);
    _secondaryaddressController = TextEditingController(
      text: widget.customer.secondaryAddress,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Customer"),

      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// Customer Name
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Customer Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Customer name is required";
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              /// Phone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  hintText: "01xxxxxxxxx",
                  prefixText: "+88 ",
                  counterText: "",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Phone number is required";
                  }

                  if (!value.startsWith("01")) {
                    return 'BD mobile Number Must Start with 01';
                  }

                  if (value.length != 11) {
                    return "Phone number must be 11 digits";
                  }

                  final bool isValid = RegExp(
                    r'^01[3-9]\d{8}$',
                  ).hasMatch(value.trim());

                  if (!isValid) {
                    return "Enter a valid Bangladeshi number";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              /// Email
              TextFormField(
                controller: _emialController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }

                  if (!value.contains("@")) {
                    return "Enter a valid email";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              /// Address
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Address is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              /// Secondary Address
              TextFormField(
                controller: _secondaryaddressController,
                decoration: const InputDecoration(
                  labelText: "Secondary Address",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Secondary address required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              /// Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final updatedCustomer = Customer(
                        name: _nameController.text,
                        phone: "+88${_phoneController.text}",
                        email: _emialController.text,
                        address: _addressController.text,
                        secondaryAddress: _secondaryaddressController.text,
                      );

                      ref
                          .read(customerProvider.notifier)
                          .updateCustomer(widget.index, updatedCustomer);
                      context.pop();
                    }
                  },
                  child: const Text(
                    "Update Customer",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emialController.dispose();
    _addressController.dispose();
    _secondaryaddressController.dispose();
    super.dispose();
  }
}
