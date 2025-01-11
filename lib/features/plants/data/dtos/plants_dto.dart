import 'package:plants/features/plants/domain/entities/plants_entity.dart';
import 'package:plants/utils/format_functions.dart';

class PlantDto {
  String id, name, category, climat, imageUrl, family, origin;

  PlantDto({
    required this.id,
    required this.name,
    required this.category,
    required this.climat,
    required this.imageUrl,
    required this.family,
    required this.origin,
  });

  factory PlantDto.fromMap(Map<String, dynamic> map) {
    return PlantDto(
      id: FormatFunctions.safeParseString(map['id']),
      name: FormatFunctions.safeParseString(map['Common name (fr.)']),
      category: FormatFunctions.safeParseString(map['Categories']),
      climat: FormatFunctions.safeParseString(map['Climat']),
      imageUrl: FormatFunctions.safeParseString(map['Img']),
      family: FormatFunctions.safeParseString(map['Family']),
      origin: FormatFunctions.safeParseString(map['origin']),
    );
  }

  Plant toEntity() {
    return Plant(
      id: id,
      name: name,
      category: category,
      climat: climat,
      imageUrl: imageUrl,
      family: family,
      origin: origin,
    );
  }
}
