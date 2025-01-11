import 'package:plants/core/enums.dart';
import 'package:plants/features/plants/data/dtos/plants_categories_dto.dart';
import 'package:plants/features/plants/domain/entities/plants_categories_response_entity.dart';

class CategoryResponseDto {
  List<CategoryDto> categoriesDto;
  ResponseStatus responseStatus;

  CategoryResponseDto({
    required this.categoriesDto,
    required this.responseStatus,
  });

  CategoryResponse toEntity() {
    return CategoryResponse(
      categories: categoriesDto.map((categoryDto) => categoryDto.toEntity()).toList(),
      responseStatus: responseStatus,
    );
  }
}
