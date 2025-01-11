import 'package:plants/features/plants/domain/entities/plants_categories_response_entity.dart';
import 'package:plants/features/plants/domain/entities/plants_response_entity.dart';

abstract class PlantsRepository {
  Future<PlantResponse> getPlants(String category);
  Future<CategoryResponse> getCategories();
}
