import 'package:country_picker/country_picker.dart';
import 'package:ecoms/model/blood_group_model.dart';
import 'package:ecoms/model/gender_model.dart';
import 'package:hive/hive.dart';
part 'customer_model.g.dart';

@HiveType(typeId: 0)
class Customer {
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

  @HiveField(5)
  GenderModel gender;

  @HiveField(6)
  BloodGroupModel bloodgroup;

  @HiveField(7)
  Country country;

  // Generative Constructor using Named Parameters.
  Customer({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.secondaryAddress,
    required this.gender,
    required this.bloodgroup,
    required this.country,
  });
}
