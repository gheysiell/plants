import 'package:plants/core/enums.dart';
import 'package:plants/features/plants/domain/entities/plants_entity.dart';

class PlantResponse {
  List<Plant> plants = [];
  ResponseStatus responseStatus;

  PlantResponse({
    required this.plants,
    required this.responseStatus,
  });
}
