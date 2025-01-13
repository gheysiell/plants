import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:plants/core/constants.dart';
import 'package:plants/core/enums.dart';
import 'package:plants/features/plants_details/data/dtos/plants_details_dto.dart';
import 'package:plants/features/plants_details/data/dtos/plants_details_response_dto.dart';

abstract class PlantsDetailsDataSourceRemoteHttp {
  Future<PlantDetailsResponseDto> getPlantDetails(String id);
}

class PlantsDetailsDataSourceRemoteHttpImpl implements PlantsDetailsDataSourceRemoteHttp {
  @override
  Future<PlantDetailsResponseDto> getPlantDetails(String id) async {
    final PlantDetailsResponseDto plantDetailsResponseDto = PlantDetailsResponseDto(
      plantDetailsDto: null,
      responseStatus: ResponseStatus.success,
    );
    final Uri uri = Uri.parse('${Constants.baseUrl}7645/plant+by+id?ID=$id');
    final Map<String, String> header = {
      'Authorization': 'Bearer ${Constants.apiKey}',
    };

    try {
      final response = await http.get(uri, headers: header).timeout(Constants.durationTimeoutRemoteHttp);

      if (response.statusCode != 200) {
        log('${Constants.badRequestMessage} PlantsDetailsDataSourceRemoteHttpImpl.getPlantDetails',
            error: 'statusCode: ${response.statusCode} | response: ${response.body}');
        throw Exception();
      }

      Map<String, dynamic> plantResponse = json.decode(response.body);

      plantDetailsResponseDto.plantDetailsDto = PlantDetailsDto.fromMap(plantResponse);
    } on TimeoutException {
      log('${Constants.timeoutExceptionMessage} PlantsDetailsDataSourceRemoteHttpImpl.getPlantDetails');
      plantDetailsResponseDto.responseStatus = ResponseStatus.timeout;
    } catch (e) {
      log('${Constants.genericExceptionMessage} PlantsDetailsDataSourceRemoteHttpImpl.getPlantDetails', error: e);
      plantDetailsResponseDto.responseStatus = ResponseStatus.error;
    }

    return plantDetailsResponseDto;
  }
}
