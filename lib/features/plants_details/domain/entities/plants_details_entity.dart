import 'package:plants/features/plants/domain/entities/plants_entity.dart';

class PlantDetails extends Plant {
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

  PlantDetails({
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
}
