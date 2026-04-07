import 'package:ecoms/providers/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ecoms/model/customer_model.dart';

class CreateCustomerScreen extends ConsumerStatefulWidget {
  const CreateCustomerScreen({super.key});

  @override
  ConsumerState<CreateCustomerScreen> createState() =>
      _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends ConsumerState<CreateCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController(); // Fixed spelling
  final _addressController = TextEditingController();
  final _secondaryAddressController = TextEditingController(); // Better name

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _secaddressFocus = FocusNode();

  // This is the key for real-time validation
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Customer'), centerTitle: true),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode:
                _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Customer Name
                TextFormField(
                  controller: _nameController,
                  focusNode: _nameFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => _phoneFocus.requestFocus(),
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Customer Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Customer's name is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Phone Number
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  focusNode: _phoneFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                  maxLength: 11,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Phone Number (BD)",
                    hintText: '01xxxxxxxxx',
                    counterText: '',
                    prefixText: "+88 ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(Icons.phone_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Phone number is required";
                    }

                    final cleanValue = value.trim();

                    if (!cleanValue.startsWith("01")) {
                      return 'BD mobile number must start with 01';
                    }

                    if (cleanValue.length != 11) {
                      return "Phone number must be 11 digits";
                    }

                    final bool isValid = RegExp(
                      r'^01[2-9]\d{8}$',
                    ).hasMatch(cleanValue);

                    if (!isValid) {
                      return "Enter a valid Bangladeshi number";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Email (Strong Validation)
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  focusNode: _emailFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => _addressFocus.requestFocus(),
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email address is required";
                    }

                    final email = value.trim();

                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );

                    if (!emailRegex.hasMatch(email)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Address
                TextFormField(
                  maxLines: 3,
                  controller: _addressController,
                  focusNode: _addressFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => _secaddressFocus.requestFocus(),
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(Icons.location_on_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Address is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Secondary Address
                TextFormField(
                  maxLines: 2,
                  controller: _secondaryAddressController,
                  focusNode: _secaddressFocus,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Secondary Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(Icons.add_location_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Secondary address is required (use same address if none)";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      // Enable auto validation when user clicks Save
                      setState(() => _autoValidate = true);

                      if (_formKey.currentState!.validate()) {
                        final newCustomer = Customer(
                          name: _nameController.text.trim(),
                          phone: "+88${_phoneController.text.trim()}",
                          email: _emailController.text.trim(),
                          address: _addressController.text.trim(),
                          secondaryAddress:
                              _secondaryAddressController.text.trim(),
                        );

                        ref
                            .read(customerProvider.notifier)
                            .addCustomer(newCustomer);
                        context.pop();
                      }
                    },
                    child: const Text(
                      "Save Customer",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _secondaryAddressController.dispose();

    _nameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _addressFocus.dispose();
    _secaddressFocus.dispose();

    super.dispose();
  }
}
