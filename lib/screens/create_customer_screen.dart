import 'package:flutter/material.dart';

class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen({super.key});

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  //for form making
  final _formKey = GlobalKey<FormState>();
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
                    labelText: "Customer Name",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                // Phone Number
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                // Email
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emialController,

                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                // Address
                TextFormField(
                  maxLines: 2,
                  controller: _addressController,

                  decoration: InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(),
                  ),
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
                        //save to hive
                        final name = _nameController.text;
                        final phone = _phoneController.text;
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
