import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:plants/core/constants.dart';
import 'package:plants/core/enums.dart';
import 'package:plants/features/plants/data/dtos/plants_categories_dto.dart';
import 'package:plants/features/plants/data/dtos/plants_categories_response_dto.dart';
import 'package:plants/features/plants/data/dtos/plants_dto.dart';
import 'package:plants/features/plants/data/dtos/plants_response_dto.dart';

abstract class PlantsDataSourceRemoteHttp {
  Future<PlantResponseDto> getPlants(String category);
  Future<CategoryResponseDto> getCategories();
}

class PlantsDataSourceRemoteHttpImpl implements PlantsDataSourceRemoteHttp {
  @override
  Future<PlantResponseDto> getPlants(String category) async {
    final PlantResponseDto plantResponseDto = PlantResponseDto(
      plantsDto: [],
      responseStatus: ResponseStatus.success,
    );
    final Map<String, String> header = {
      'Authorization': 'Bearer ${Constants.apiKey}',
    };
    final Uri uri = Uri.parse('${Constants.baseUrl}7644/plant+information+by+category?category=$category');

    try {
      final response = await http.get(uri, headers: header).timeout(Constants.durationTimeoutRemoteHttp);

      if (response.statusCode != 200) {
        log('${Constants.badRequestMessage} PlantsDataSourceRemoteHttpImpl.gtePlants',
            error: 'statusCode: ${response.statusCode} | response: ${response.body}');
        throw Exception();
      }

      List responsePlants = json.decode(response.body);

      plantResponseDto.plantsDto = responsePlants.map((plant) => PlantDto.fromMap(plant)).toList();
    } on TimeoutException {
      log('${Constants.timeoutExceptionMessage} PlantsDataSourceRemoteHttpImpl.getPlants');
      plantResponseDto.responseStatus = ResponseStatus.timeout;
    } catch (e) {
      log('${Constants.genericExceptionMessage} PlantsDataSourceRemoteHttpImpl.getPlants');
      plantResponseDto.responseStatus = ResponseStatus.error;
    }

    return plantResponseDto;
  }

  @override
  Future<CategoryResponseDto> getCategories() async {
    final CategoryResponseDto categoryResponseDto = CategoryResponseDto(
      categoriesDto: [],
      responseStatus: ResponseStatus.success,
    );
    final Uri uri = Uri.parse('${Constants.baseUrl}7643/all+categories');
    final Map<String, String> header = {
      'Authorization': 'Bearer ${Constants.apiKey}',
    };

    try {
      final response = await http.get(uri, headers: header).timeout(Constants.durationTimeoutRemoteHttp);

      if (response.statusCode != 200) {
        log('${Constants.badRequestMessage} PlantsDataSourceRemoteHttpImpl.getCategories',
            error: 'statusCode: ${response.statusCode} | response: ${response.body}');
        throw Exception();
      }

      List categories = json.decode(response.body);

      categoryResponseDto.categoriesDto = categories.map((category) => CategoryDto.fromMap(category)).toList();
    } on TimeoutException {
      log('${Constants.timeoutExceptionMessage} PlantsDataSourceRemoteHttpImpl.getCategories');
      categoryResponseDto.responseStatus = ResponseStatus.timeout;
    } catch (e) {
      log('${Constants.genericExceptionMessage} PlantsDataSourceRemoteHttpImpl.getCategories', error: e);
      categoryResponseDto.responseStatus = ResponseStatus.error;
    }

    return categoryResponseDto;
  }
}
