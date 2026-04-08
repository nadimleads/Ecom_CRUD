import 'package:hive/hive.dart';

part 'gender_model.g.dart';

@HiveType(typeId: 1)
enum GenderModel {
  @HiveField(0)
  male,
  @HiveField(1)
  female,
  @HiveField(2)
  other,
}
