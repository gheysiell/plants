import 'package:flutter/material.dart';
import 'package:plants/core/enums.dart';
import 'package:plants/features/plants/domain/entities/plants_categories_entity.dart';
import 'package:plants/features/plants/domain/entities/plants_categories_response_entity.dart';
import 'package:plants/features/plants/domain/entities/plants_entity.dart';
import 'package:plants/features/plants/domain/entities/plants_response_entity.dart';
import 'package:plants/features/plants/domain/usecases/plants_usecase.dart';
import 'package:plants/utils/functions.dart';

class PlantsViewModel extends ChangeNotifier {
  List<Plant> plants = [];
  List<Category> categories = [];
  bool loading = false;
  bool loadingCategories = false;
  int indexCategorySelected = 0;
  PlantsUseCase plantsUseCase;

  PlantsViewModel({
    required this.plantsUseCase,
  });

  void setPlants(List<Plant> value) {
    plants = value;
    notifyListeners();
  }

  void setCategories(List<Category> value) {
    categories = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setLoadingCategories(bool value) {
    loadingCategories = value;
    notifyListeners();
  }

  void setIndexCategorySelected(int index) {
    indexCategorySelected = index;
    notifyListeners();
  }

  Future<void> getPlants() async {
    String category = categories.isNotEmpty ? categories[indexCategorySelected].name : 'Dracaena';

    setLoading(true);

    PlantResponse plantResponse = await plantsUseCase.getPlants(category);

    setLoading(false);

    setPlants(plantResponse.plants);

    if (plantResponse.responseStatus != ResponseStatus.success) {
      Functions.showMessageResponseStatus(
        plantResponse.responseStatus,
        'buscar',
        'as',
        'plantas',
      );
    }
  }

  Future<void> getCategories() async {
    setLoadingCategories(true);

    CategoryResponse categoryResponse = await plantsUseCase.getCategories();

    setLoadingCategories(false);

    setCategories(categoryResponse.categories);

    if (categoryResponse.responseStatus != ResponseStatus.success) {
      Functions.showMessageResponseStatus(
        categoryResponse.responseStatus,
        'buscar',
        'as',
        'categorias',
      );
    }
  }
}
