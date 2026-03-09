import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Management Ecom'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 249, 255, 169),
      body: Column(
        children: [
          //Add Customer button
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton.icon(
              onPressed: () {
                //Navigate add customer screen
              },
              icon: const Icon(Icons.add),
              label: const Text('Create New Customer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 136, 194, 138),
                foregroundColor: Colors.white,
              ),
            ),
          ),

          //customer list er jonno (for Read)
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
