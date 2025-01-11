import 'package:flutter/material.dart';
import 'package:plants/core/enums.dart';
import 'package:plants/features/plants/domain/entities/plants_entity.dart';
import 'package:plants/features/plants/domain/entities/plants_response_entity.dart';
import 'package:plants/features/plants/domain/usecases/plants_usecase.dart';
import 'package:plants/utils/functions.dart';

class PlantsViewModel extends ChangeNotifier {
  List<Plant> plants = [];
  bool loading = false;
  bool searching = false;
  PlantsUseCase plantsUseCase;

  PlantsViewModel({
    required this.plantsUseCase,
  });

  void setPlants(List<Plant> value) {
    plants = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setSearching(bool value) {
    searching = value;
    notifyListeners();
  }

  Future<void> getPlants(String search) async {
    setSearching(search.isNotEmpty);

    setLoading(true);

    PlantResponse plantResponse = await plantsUseCase.getPlants(search);

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
}
