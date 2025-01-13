import 'package:plants/core/enums.dart';
import 'package:plants/features/plants_details/domain/entities/plants_details_entity.dart';

class PlantDetailsResponse {
  PlantDetails? plantDetails;
  ResponseStatus responseStatus;

  PlantDetailsResponse({
    required this.plantDetails,
    required this.responseStatus,
  });
}
