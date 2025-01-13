import 'package:plants/features/plants_details/domain/entities/plants_details_response_entity.dart';
import 'package:plants/features/plants_details/domain/repositories/plants_details_repository.dart';

class PlantsDetailsUseCase {
  PlantsDetailsRepository plantsDetailsRepository;

  PlantsDetailsUseCase({
    required this.plantsDetailsRepository,
  });

  Future<PlantDetailsResponse> getPlantDetails(String id) async {
    return await plantsDetailsRepository.getPlantDetails(id);
  }
}
