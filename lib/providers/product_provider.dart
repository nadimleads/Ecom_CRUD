import 'package:ecoms/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provides the list of products
final productProvider = Provider<List<Product>>((ref) {
  return dummyProducts;
});
