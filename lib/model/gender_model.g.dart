// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenderModelAdapter extends TypeAdapter<GenderModel> {
  @override
  final int typeId = 1;

  @override
  GenderModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GenderModel.male;
      case 1:
        return GenderModel.female;
      case 2:
        return GenderModel.other;
      default:
        return GenderModel.male;
    }
  }

  @override
  void write(BinaryWriter writer, GenderModel obj) {
    switch (obj) {
      case GenderModel.male:
        writer.writeByte(0);
        break;
      case GenderModel.female:
        writer.writeByte(1);
        break;
      case GenderModel.other:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
