import 'package:plants/core/enums.dart';
import 'package:plants/features/plants_details/data/datasources/plants_details_datasource_remote_http.dart';
import 'package:plants/features/plants_details/data/dtos/plants_details_response_dto.dart';
import 'package:plants/features/plants_details/domain/entities/plants_details_response_entity.dart';
import 'package:plants/features/plants_details/domain/repositories/plants_details_repository.dart';
import 'package:plants/utils/functions.dart';

class PlantsDetailsRepositoryImpl implements PlantsDetailsRepository {
  PlantsDetailsDataSourceRemoteHttp plantsDetailsDataSourceRemoteHttp;

  PlantsDetailsRepositoryImpl({
    required this.plantsDetailsDataSourceRemoteHttp,
  });

  @override
  Future<PlantDetailsResponse> getPlantDetails(String id) async {
    if (!await Functions.checkConn()) {
      return PlantDetailsResponse(
        plantDetails: null,
        responseStatus: ResponseStatus.noConnection,
      );
    }

    PlantDetailsResponseDto plantDetailsResponseDto = await plantsDetailsDataSourceRemoteHttp.getPlantDetails(id);

    return plantDetailsResponseDto.toEntity();
  }
}
