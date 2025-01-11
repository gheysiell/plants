import 'package:plants/core/enums.dart';
import 'package:plants/features/plants/data/datasources/remote/plants_datasource_remote_http.dart';
import 'package:plants/features/plants/data/dtos/plants_response_dto.dart';
import 'package:plants/features/plants/domain/entities/plants_response_entity.dart';
import 'package:plants/features/plants/domain/repositories/plants_repository.dart';
import 'package:plants/utils/functions.dart';

class PlantsRepositoryImpl implements PlantsRepository {
  PlantsDataSourceRemoteHttp plantsDataSourceRemoteHttp;

  PlantsRepositoryImpl({
    required this.plantsDataSourceRemoteHttp,
  });

  @override
  Future<PlantResponse> getPlants(String search) async {
    if (!await Functions.checkConn()) {
      return PlantResponse(
        plants: [],
        responseStatus: ResponseStatus.noConnection,
      );
    }

    PlantResponseDto plantResponseDto = await plantsDataSourceRemoteHttp.getPlants(search);

    return plantResponseDto.toEntity();
  }
}
