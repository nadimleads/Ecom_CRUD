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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final customers = ref.watch(customerProvider);
    final filteredCustomers =
        customers.where((customer) {
          final query = _searchQuery.toLowerCase();
          return customer.name.toLowerCase().contains(query) ||
              (customer.email?.toLowerCase().contains(query) ?? false) ||
              (customer.phone?.contains(query) ?? false);
        }).toList();

    final isDark = ref.watch(themeProvider) == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Management',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/create-customer'),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'New Customer',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E7D32),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Add refresh logic in your provider if needed
          await Future.delayed(const Duration(milliseconds: 800));
        },
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: SearchBar(
                controller: _searchController,
                hintText: 'Search customers...',
                leading: const Icon(Icons.search),
                onChanged: (value) => setState(() => _searchQuery = value),
                elevation: const WidgetStatePropertyAll(1),
              ),
            ),

            // Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildStatCard(
                    'Total',
                    customers.length.toString(),
                    Icons.people,
                  ),
                  // const SizedBox(width: 12),
                  // _buildStatCard(
                  //   'Active',
                  //   '${(customers.length * 0.85).round()}',
                  //   Icons.verified,
                  // ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Customer List
            Expanded(
              child:
                  filteredCustomers.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredCustomers.length,
                        itemBuilder: (context, index) {
                          final customer = filteredCustomers[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CustomerCard(
                              customer: customer,
                              index: index,
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.green.shade700),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            'No Customers Found',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isEmpty
                ? 'Start by adding your first customer'
                : 'No matches for your search',
            style: TextStyle(color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (_searchQuery.isEmpty)
            ElevatedButton.icon(
              onPressed: () => context.go('/create-customer'),
              icon: const Icon(Icons.add),
              label: const Text('Add First Customer'),
            ),
        ],
      ),
    );
  }
}
