import 'package:plants/core/enums.dart';
import 'package:plants/features/plants/domain/entities/plants_categories_entity.dart';

class CategoryResponse {
  List<Category> categories;
  ResponseStatus responseStatus;

  CategoryResponse({
    required this.categories,
    required this.responseStatus,
  });
}
