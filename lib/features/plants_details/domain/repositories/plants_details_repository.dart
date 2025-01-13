import 'package:plants/features/plants_details/domain/entities/plants_details_response_entity.dart';

abstract class PlantsDetailsRepository {
  Future<PlantDetailsResponse> getPlantDetails(String id);
}
