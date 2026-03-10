import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: const Text('Customer Management Ecom'),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
              icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
              iconSize: 20,
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 249, 255, 169),
      body: Column(
        children: [
          //Add Customer button
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton.icon(
              onPressed: () {
                context.push('/create-customer');
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
