import 'package:flutter/material.dart';
import 'package:plants/core/enums.dart';
import 'package:plants/core/models/title_and_info.dart';
import 'package:plants/features/plants_details/domain/entities/plants_details_entity.dart';
import 'package:plants/features/plants_details/domain/entities/plants_details_response_entity.dart';
import 'package:plants/features/plants_details/domain/usecases/plants_details_usecase.dart';
import 'package:plants/utils/functions.dart';

class PlantsDetailsViewModel extends ChangeNotifier {
  PlantDetails? plantDetails;
  List<TitleAndInfo> titlesAndInfos = [];
  bool loading = false;
  PlantsDetailsUseCase plantsDetailsUseCase;

  PlantsDetailsViewModel({
    required this.plantsDetailsUseCase,
  });

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setPlantDetails(PlantDetails? value) {
    plantDetails = value;
    notifyListeners();
  }

  void setTitlesAndInfos(List<TitleAndInfo> value) {
    titlesAndInfos = value;
    notifyListeners();
  }

  Future<void> getPlantDetails(String id) async {
    setLoading(true);

    PlantDetailsResponse plantDetailsResponse = await plantsDetailsUseCase.getPlantDetails(id);

    setLoading(false);

    setPlantDetails(plantDetailsResponse.plantDetails);

    setTitlesAndInfos(plantDetailsResponse.plantDetails != null ? generateTitlesAndInfos() : []);

    if (plantDetailsResponse.responseStatus != ResponseStatus.success) {
      Functions.showMessageResponseStatus(
        plantDetailsResponse.responseStatus,
        'buscar',
        'os',
        'detalhes da planta',
      );
    }
  }

  List<TitleAndInfo> generateTitlesAndInfos() {
    return [
      TitleAndInfo(
        title: 'Nome',
        info: plantDetails!.name,
      ),
      TitleAndInfo(
        title: 'Familia',
        info: plantDetails!.family,
      ),
      TitleAndInfo(
        title: 'Categoria',
        info: plantDetails!.category,
      ),
      TitleAndInfo(
        title: 'Clima',
        info: plantDetails!.climat,
      ),
      TitleAndInfo(
        title: 'Origem',
        info: plantDetails!.origin,
      ),
      TitleAndInfo(
        title: 'Disponibilidade',
        info: plantDetails!.avaibility,
      ),
      TitleAndInfo(
        title: 'Rega',
        info: plantDetails!.watering,
      ),
      TitleAndInfo(
        title: 'Cor das flores',
        info: plantDetails!.colorOfBlooms,
      ),
      TitleAndInfo(
        title: 'Descrição',
        info: plantDetails!.description,
      ),
      TitleAndInfo(
        title: 'Poda',
        info: plantDetails!.pruning,
      ),
      TitleAndInfo(
        title: 'Temperatura Máxima',
        info: '${plantDetails!.temperatureMax} C°',
      ),
      TitleAndInfo(
        title: 'Temperatura Mínima',
        info: '${plantDetails!.temperatureMin} C°',
      ),
      TitleAndInfo(
        title: 'Crescimento',
        info: plantDetails!.growth,
      ),
      TitleAndInfo(
        title: 'Luz tolerada',
        info: plantDetails!.lightTolered,
      ),
      TitleAndInfo(
        title: 'Estação de floração',
        info: plantDetails!.bloomingSeason,
      ),
    ];
  }
}
