import 'package:flutter/material.dart';

class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen({super.key});

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  //for form making
  final _formKey = GlobalKey<FormState>();
  //controllers for storing input
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emialController = TextEditingController();
  final _addressController = TextEditingController();
  final _secondaryaddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Customer'), centerTitle: true),
      backgroundColor: const Color.fromARGB(255, 249, 255, 169),

      // form body here
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Customer Name
                TextFormField(
                  enableSuggestions: true,
                  controller: _nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Customer Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Phone Number(BD)",
                    hintText: '01xxxxxxxxx',
                    prefixText: "+88",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Phone number is required";
                    }
                    if (!value.startsWith("01")) {}
                    if (value.trim().length != 11) {
                      return "The number must be 11 digits";
                    }
                    //
                    final bool isValidBangladeshiNumber = RegExp(
                      r'^01[3-9]\d{8}$',
                    ).hasMatch(value.trim());

                    if (!isValidBangladeshiNumber) {
                      return "Please enter a valid 11 Digit Bangladeshi number!";
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
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter an Email Address";
                    }
                    if (!value.contains('@')) {
                      return "Enter a valid Email";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Address
                TextFormField(
                  maxLines: 3,
                  controller: _addressController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
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
                  controller: _secondaryaddressController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Secondary Address (Optional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Secondary Address is required(if none, place the same address)";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 25),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('Form Valid');

                        //save to hive
                        final name = _nameController.text;
                        final phone = "+88${_phoneController.text}";
                        final email = _emialController.text;
                        final address = _addressController.text;
                        final secondaryAddress =
                            _secondaryaddressController.text;

                        print(name);
                        print(phone);
                        print(email);
                        print(address);
                        print(secondaryAddress);
                      }
                    },
                    child: const Text(
                      "Save Customer",
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
    _emialController.dispose();
    _addressController.dispose();
    _secondaryaddressController.dispose();
    super.dispose();
  }
}
