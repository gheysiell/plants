import 'package:plants/features/plants/domain/entities/plants_categories_response_entity.dart';
import 'package:plants/features/plants/domain/entities/plants_response_entity.dart';
import 'package:plants/features/plants/domain/repositories/plants_repository.dart';

class PlantsUseCase {
  PlantsRepository plantsRepository;

  PlantsUseCase({
    required this.plantsRepository,
  });

  Future<PlantResponse> getPlants(String category) async {
    return await plantsRepository.getPlants(category);
  }

  Future<CategoryResponse> getCategories() async {
    return await plantsRepository.getCategories();
  }
}
