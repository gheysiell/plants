import 'package:plants/features/plants/data/dtos/plants_dto.dart';
import 'package:plants/features/plants_details/domain/entities/plants_details_entity.dart';
import 'package:plants/utils/format_functions.dart';

class PlantDetailsDto extends PlantDto {
  String avaibility,
      watering,
      colorOfBlooms,
      description,
      pruning,
      temperatureMax,
      temperatureMin,
      growth,
      lightTolered,
      bloomingSeason;

  PlantDetailsDto({
    required super.id,
    required super.category,
    required super.climat,
    required super.family,
    required super.imageUrl,
    required super.name,
    required super.origin,
    required this.avaibility,
    required this.watering,
    required this.colorOfBlooms,
    required this.description,
    required this.pruning,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.growth,
    required this.lightTolered,
    required this.bloomingSeason,
  });

  @override
  factory PlantDetailsDto.fromMap(Map<String, dynamic> map) {
    return PlantDetailsDto(
      id: FormatFunctions.safeParseString(map['id']),
      category: FormatFunctions.safeParseString(map['Categories']),
      climat: FormatFunctions.safeParseString(map['Climat']),
      family: FormatFunctions.safeParseString(map['Family']),
      imageUrl: FormatFunctions.safeParseString(map['Img']),
      name: FormatFunctions.safeParseString(map['Common name (fr.)']),
      origin: FormatFunctions.safeParseString(map['Origin'][0]),
      avaibility: FormatFunctions.safeParseString(map['Avaibility']),
      watering: FormatFunctions.safeParseString(map['Watering']),
      colorOfBlooms: FormatFunctions.safeParseString(map['Color of blooms']),
      description: FormatFunctions.safeParseString(map['Description']),
      pruning: FormatFunctions.safeParseString(map['Pruning']),
      temperatureMax: FormatFunctions.safeParseString(map['Temperature max']['C']),
      temperatureMin: FormatFunctions.safeParseString(map['Temperature min']['C']),
      growth: FormatFunctions.safeParseString(map['Growth']),
      lightTolered: FormatFunctions.safeParseString(map['Light tolered']),
      bloomingSeason: FormatFunctions.safeParseString(map['Blooming season']),
    );
  }

  @override
  PlantDetails toEntity() {
    return PlantDetails(
      id: id,
      category: category,
      climat: climat,
      family: family,
      imageUrl: imageUrl,
      name: name,
      origin: origin,
      avaibility: avaibility,
      watering: watering,
      colorOfBlooms: colorOfBlooms,
      description: description,
      pruning: pruning,
      temperatureMax: temperatureMax,
      temperatureMin: temperatureMin,
      growth: growth,
      lightTolered: lightTolered,
      bloomingSeason: bloomingSeason,
    );
  }
}
