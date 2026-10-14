import 'package:ecoms/model/blood_group_model.dart';

//helper Function
String formatBloodGroup(BloodGroupModel bg) {
  switch (bg) {
    case BloodGroupModel.A_POS:
      return "A+";
    case BloodGroupModel.A_NEG:
      return "A-";
    case BloodGroupModel.B_POS:
      return "B+";
    case BloodGroupModel.B_NEG:
      return "B-";
    case BloodGroupModel.AB_POS:
      return "AB+";
    case BloodGroupModel.AB_NEG:
      return "AB-";
    case BloodGroupModel.O_POS:
      return "O+";
    case BloodGroupModel.O_NEG:
      return "O-";
  }
}
