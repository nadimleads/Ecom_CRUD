// import 'package:ecoms/model/customer_model.dart';
import 'package:ecoms/providers/auth_provider.dart';
import 'package:ecoms/providers/customer_provider.dart';
import 'package:ecoms/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'widgets/customer_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
            padding: const EdgeInsets.only(right: 05),
            child: IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: Icon(
                ref.watch(themeProvider) == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
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
                        context,
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
