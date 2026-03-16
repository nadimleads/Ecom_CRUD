// import 'package:ecoms/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ecoms/providers/customer_provider.dart';
import 'package:ecoms/widgets/customer_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext contextOfHome) {
    final customers = ref.watch(customerProvider);

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: const Text(
            'Customer Management Ecom',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
                backgroundColor: const Color.fromARGB(255, 41, 77, 42),
                foregroundColor: Colors.white,
              ),
            ),
          ),

          //customer list er jonno (for Read/get operation)
          Expanded(
            child:
                customers.isEmpty
                    ? const Center(
                      child: Text(
                        'There is no Customer Available',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                    : ListView.builder(
                      itemCount: customers.length,
                      itemBuilder: (
                        contextOfHome,
                        index,
                      ) //bujhinai ei itembuilder er part ta
                      {
                        final customer = customers[index];
                        return CustomerCard(
                          customer: customer,
                          index: index,
                        ); //(clear na)
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
