import 'package:plants/features/plants/domain/entities/plants_response_entity.dart';
import 'package:plants/features/plants/domain/repositories/plants_repository.dart';

class PlantsUseCase {
  PlantsRepository plantsRepository;

  PlantsUseCase({
    required this.plantsRepository,
  });

  Future<PlantResponse> getPlants(String search) async {
    return await plantsRepository.getPlants(search);
  }
}
