import 'package:flutter/material.dart';

class CreateCustomerScreen extends StatelessWidget {
  const CreateCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Customer'), centerTitle: true),
      backgroundColor: const Color.fromARGB(255, 249, 255, 169),
      body: Column(
        children: [
          //Customer Data Input (for Create)
          const Expanded(
            child: Center(
              child: Text(
                'There is no Customer Available',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
