import 'package:plants/core/enums.dart';
import 'package:plants/features/plants/data/dtos/plants_dto.dart';
import 'package:plants/features/plants/domain/entities/plants_response_entity.dart';

class PlantResponseDto {
  List<PlantDto> plantsDto = [];
  ResponseStatus responseStatus;

  PlantResponseDto({
    required this.plantsDto,
    required this.responseStatus,
  });

  PlantResponse toEntity() {
    return PlantResponse(
      plants: plantsDto.map((plantDto) => plantDto.toEntity()).toList(),
      responseStatus: responseStatus,
    );
  }
}
