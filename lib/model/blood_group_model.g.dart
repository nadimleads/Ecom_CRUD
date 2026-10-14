// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_group_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodGroupModelAdapter extends TypeAdapter<BloodGroupModel> {
  @override
  final int typeId = 2;

  @override
  BloodGroupModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BloodGroupModel.A_POS;
      case 1:
        return BloodGroupModel.A_NEG;
      case 2:
        return BloodGroupModel.B_POS;
      case 3:
        return BloodGroupModel.B_NEG;
      case 4:
        return BloodGroupModel.AB_POS;
      case 5:
        return BloodGroupModel.AB_NEG;
      case 6:
        return BloodGroupModel.O_POS;
      case 7:
        return BloodGroupModel.O_NEG;
      default:
        return BloodGroupModel.A_POS;
    }
  }

  @override
  void write(BinaryWriter writer, BloodGroupModel obj) {
    switch (obj) {
      case BloodGroupModel.A_POS:
        writer.writeByte(0);
        break;
      case BloodGroupModel.A_NEG:
        writer.writeByte(1);
        break;
      case BloodGroupModel.B_POS:
        writer.writeByte(2);
        break;
      case BloodGroupModel.B_NEG:
        writer.writeByte(3);
        break;
      case BloodGroupModel.AB_POS:
        writer.writeByte(4);
        break;
      case BloodGroupModel.AB_NEG:
        writer.writeByte(5);
        break;
      case BloodGroupModel.O_POS:
        writer.writeByte(6);
        break;
      case BloodGroupModel.O_NEG:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodGroupModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
