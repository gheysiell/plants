import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plants/features/plants/domain/entities/plants_categories_entity.dart';
import 'package:plants/features/plants/domain/entities/plants_entity.dart';
import 'package:plants/features/plants/presentation/viewmodels/plants_viewmodel.dart';
import 'package:plants/features/plants_details/presentation/views/plants_details_view.dart';
import 'package:plants/shared/palette.dart';
import 'package:plants/shared/widgets/not_found.dart';
import 'package:plants/utils/functions.dart';
import 'package:provider/provider.dart';

class PlantsView extends StatefulWidget {
  const PlantsView({super.key});

  @override
  State<PlantsView> createState() {
    return PlantsViewState();
  }
}

class PlantsViewState extends State<PlantsView> {
  late PlantsViewModel plantsViewModel;
  final double heightCategory = 70;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      plantsViewModel = context.watch<PlantsViewModel>();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        plantsViewModel.getCategories();
        plantsViewModel.getPlants();
      });

      initialized = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plants',
          style: TextStyle(
            fontSize: 22,
            color: Palette.gray,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Container(
          alignment: Alignment.center,
          height: 60,
          child: Image.asset(
            'assets/images/icon.png',
          ),
        ),
        leadingWidth: 70,
        titleSpacing: 2,
        backgroundColor: Palette.white,
        surfaceTintColor: Palette.white,
      ),
      backgroundColor: Palette.white,
      body: Column(
        children: [
          Container(
            height: heightCategory,
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: Palette.white,
            child: plantsViewModel.loadingCategories
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : !plantsViewModel.loadingCategories && plantsViewModel.categories.isEmpty
                    ? Center(
                        child: IconButton(
                          icon: const Icon(
                            Icons.refresh_rounded,
                            color: Palette.primary,
                            size: 30,
                          ),
                          onPressed: () async {
                            await plantsViewModel.getCategories();
                          },
                        ),
                      )
                    : ListView.builder(
                        itemCount: plantsViewModel.categories.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          Category category = plantsViewModel.categories[index];

                          return Container(
                            margin: const EdgeInsets.only(
                              right: 8,
                            ),
                            child: TextButton(
                              onPressed: () async {
                                plantsViewModel.setIndexCategorySelected(index);
                                await plantsViewModel.getPlants();
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: plantsViewModel.indexCategorySelected == index
                                    ? Palette.primary
                                    : Palette.secondary,
                              ),
                              child: Text(
                                category.name,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: plantsViewModel.indexCategorySelected == index
                                      ? Palette.white
                                      : Palette.grayIntermediary,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
          Expanded(
            child: plantsViewModel.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await plantsViewModel.getPlants();
                    },
                    child: !plantsViewModel.loading && plantsViewModel.plants.isEmpty
                        ? SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: NotFoundWidget(
                              title: 'Plantas não encontradas',
                              height: Functions.getHeightBody(context) - heightCategory,
                              paddingBottom: 50,
                            ),
                          )
                        : Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: ListView.builder(
                                  itemCount: plantsViewModel.plants.length,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  itemBuilder: (BuildContext context, int index) {
                                    Plant plant = plantsViewModel.plants[index];

                                    return ListTile(
                                      leading: SizedBox(
                                        width: 60,
                                        child: TextButton(
                                          onPressed: () {
                                            Functions.showNetworkImageFullScreen(context, plant.imageUrl);
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: plant.imageUrl,
                                            imageBuilder: (context, imageProvider) {
                                              return ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image(
                                                  image: imageProvider,
                                                ),
                                              );
                                            },
                                            placeholder: (context, url) {
                                              return const Center(
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 3,
                                                ),
                                              );
                                            },
                                            errorWidget: (context, url, error) {
                                              return const Icon(
                                                Icons.grass_rounded,
                                                size: 60,
                                                color: Palette.grayLight,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        plantsViewModel.plants[index].name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Palette.gray,
                                        ),
                                      ),
                                      subtitle: Text(
                                        plantsViewModel.plants[index].climat,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Palette.grayMedium,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PlantsDetailsView(
                                              id: plantsViewModel.plants[index].id,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Palette.white,
                                        Palette.white.withOpacity(0.9),
                                        Palette.white.withOpacity(0.8),
                                        Palette.white.withOpacity(0.7),
                                        Palette.white.withOpacity(0.5),
                                        Palette.white.withOpacity(0.3),
                                        Palette.white.withOpacity(0.1),
                                        Palette.white.withOpacity(0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
