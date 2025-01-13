import 'package:plants/core/enums.dart';
import 'package:plants/features/plants_details/data/dtos/plants_details_dto.dart';
import 'package:plants/features/plants_details/domain/entities/plants_details_response_entity.dart';

class PlantDetailsResponseDto {
  PlantDetailsDto? plantDetailsDto;
  ResponseStatus responseStatus;

  PlantDetailsResponseDto({
    required this.plantDetailsDto,
    required this.responseStatus,
  });

  toEntity() {
    return PlantDetailsResponse(
      plantDetails: plantDetailsDto?.toEntity(),
      responseStatus: responseStatus,
    );
  }
}
