import 'package:plants/features/plants/domain/entities/plants_categories_entity.dart';
import 'package:plants/utils/format_functions.dart';

class CategoryDto {
  String name;

  CategoryDto({
    required this.name,
  });

  factory CategoryDto.fromMap(Map<String, dynamic> map) {
    return CategoryDto(
      name: FormatFunctions.safeParseString(map['Category']),
    );
  }

  Category toEntity() {
    return Category(
      name: name,
    );
  }
}
