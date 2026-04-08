import 'package:ecoms/model/customer_model.dart';
import 'package:ecoms/model/gender_model.dart';
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
  //Putting this Inside This private Class
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emialController;
  late final TextEditingController _addressController;
  late final TextEditingController _secondaryaddressController;
  late GenderModel _selectedGender;

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
    _selectedGender = widget.customer.gender;
  }

  bool _autovalidation = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Customer"),

      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode:
              _autovalidation
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
          child: Column(
            children: [
              /// Customer Name
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child:
                //name part
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
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
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                maxLength: 11,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone_outlined),
                  filled: true,
                  labelText: "Phone Number(BD)",
                  hintText: '01xxxxxxxxx',
                  counterText: '',
                  prefixText: "+88",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
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
                    r'^01[2-9]\d{8}$',
                  ).hasMatch(value.trim());

                  if (!isValid) {
                    return "Enter a valid Bangladeshi number";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Email
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emialController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  filled: true,
                  labelText: "Email",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email address is required";
                  }

                  // Trim whitespace
                  value = value.trim();

                  // Strong email validation using RegExp
                  final emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );

                  if (!emailRegex.hasMatch(value)) {
                    return "Please enter a valid email address";
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
                  prefixIcon: Icon(Icons.location_on_outlined),

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
                  prefixIcon: Icon(Icons.add_location_outlined),

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
              Text("Gender", style: TextStyle(fontWeight: FontWeight.bold)),

              RadioListTile<GenderModel>(
                title: const Text("Male"),
                value: GenderModel.male,
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),

              RadioListTile<GenderModel>(
                title: const Text("Female"),
                value: GenderModel.female,
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),

              RadioListTile<GenderModel>(
                title: const Text("Other"),
                value: GenderModel.other,
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
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
                    setState(() {
                      _autovalidation = true;
                    });

                    if (_formKey.currentState!.validate()) {
                      final updatedCustomer = Customer(
                        name: _nameController.text,
                        phone: "+88${_phoneController.text}",
                        email: _emialController.text,
                        address: _addressController.text,
                        secondaryAddress: _secondaryaddressController.text,
                        gender: _selectedGender,
                      );

                      ref
                          .read(customerProvider.notifier)
                          .updateCustomer(widget.index, updatedCustomer);

                      if (context.mounted) {
                        return context.pop();
                      }
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
