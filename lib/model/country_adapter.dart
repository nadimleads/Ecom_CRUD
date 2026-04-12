import 'package:country_picker/country_picker.dart';
import 'package:hive/hive.dart';

class CountryAdapter extends TypeAdapter<Country> {
  @override
  final int typeId = 2; // Use a unique typeId (different from 0 and 1)

  @override
  Country read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }

    return Country(
      phoneCode: fields[0] as String,
      countryCode: fields[1] as String,
      e164Sc: fields[2] as int,
      geographic: fields[3] as bool,
      level: fields[4] as int,
      name: fields[5] as String,
      displayName: fields[6] as String,
      displayNameNoCountryCode: fields[7] as String,
      e164Key: fields[8] as String,
      example: '',
    );
  }

  @override
  void write(BinaryWriter writer, Country obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.phoneCode)
      ..writeByte(1)
      ..write(obj.countryCode)
      ..writeByte(2)
      ..write(obj.e164Sc)
      ..writeByte(3)
      ..write(obj.geographic)
      ..writeByte(4)
      ..write(obj.level)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.displayName)
      ..writeByte(7)
      ..write(obj.displayNameNoCountryCode)
      ..writeByte(8)
      ..write(obj.e164Key);
  }
}
