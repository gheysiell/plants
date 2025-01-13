import 'package:plants/features/plants/data/datasources/remote/plants_datasource_remote_http.dart';
import 'package:plants/features/plants/data/repositories/plants_repository_impl.dart';
import 'package:plants/features/plants/domain/usecases/plants_usecase.dart';
import 'package:plants/features/plants/presentation/viewmodels/plants_viewmodel.dart';
import 'package:plants/features/plants_details/data/datasources/plants_details_datasource_remote_http.dart';
import 'package:plants/features/plants_details/data/repositories/plants_details_repository_impl.dart';
import 'package:plants/features/plants_details/domain/usecases/plants_details_usecase.dart';
import 'package:plants/features/plants_details/presentation/viewmodels/plants_details_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  Provider(
    create: (context) => PlantsDataSourceRemoteHttpImpl(),
  ),
  Provider(
    create: (context) => PlantsRepositoryImpl(
      plantsDataSourceRemoteHttp: context.read<PlantsDataSourceRemoteHttpImpl>(),
    ),
  ),
  Provider(
    create: (context) => PlantsUseCase(
      plantsRepository: context.read<PlantsRepositoryImpl>(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => PlantsViewModel(
      plantsUseCase: context.read<PlantsUseCase>(),
    ),
  ),
  Provider(
    create: (context) => PlantsDetailsDataSourceRemoteHttpImpl(),
  ),
  Provider(
    create: (context) => PlantsDetailsRepositoryImpl(
      plantsDetailsDataSourceRemoteHttp: context.read<PlantsDetailsDataSourceRemoteHttpImpl>(),
    ),
  ),
  Provider(
    create: (context) => PlantsDetailsUseCase(
      plantsDetailsRepository: context.read<PlantsDetailsRepositoryImpl>(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => PlantsDetailsViewModel(
      plantsDetailsUseCase: context.read<PlantsDetailsUseCase>(),
    ),
  ),
];
