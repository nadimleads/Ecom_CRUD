import 'package:hive/hive.dart';
part 'customer_model.g.dart';

@HiveType(typeId: 0)
class Customer {
  // Generative Constructor using Named Parameters.
  Customer({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.secondaryAddress,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String email;

  @HiveField(3)
  String address;

  @HiveField(4)
  String secondaryAddress;
}
