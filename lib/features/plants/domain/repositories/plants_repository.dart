import 'package:plants/features/plants/domain/entities/plants_response_entity.dart';

abstract class PlantsRepository {
  Future<PlantResponse> getPlants(String search);
}
