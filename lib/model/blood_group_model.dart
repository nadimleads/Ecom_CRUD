import 'package:hive/hive.dart';

part 'blood_group_model.g.dart';

@HiveType(typeId: 2)
enum BloodGroupModel {
  @HiveField(0)
  A_POS,

  @HiveField(1)
  A_NEG,

  @HiveField(2)
  B_POS,

  @HiveField(3)
  B_NEG,

  @HiveField(4)
  AB_POS,

  @HiveField(5)
  AB_NEG,

  @HiveField(6)
  O_POS,

  @HiveField(7)
  O_NEG,
}
