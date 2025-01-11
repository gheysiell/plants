import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plants/features/plants/presentation/viewmodels/plants_viewmodel.dart';
import 'package:plants/features/plants_details/presentation/views/plants_details_view.dart';
import 'package:plants/shared/palette.dart';
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
  final TextEditingController controllerSearch = TextEditingController();
  final FocusNode focusSearch = FocusNode();
  final ScrollController controllerScroll = ScrollController();
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
        await plantsViewModel.getPlants('');
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
        titleSpacing: 0,
        backgroundColor: Palette.white,
        surfaceTintColor: Palette.white,
      ),
      backgroundColor: Palette.white,
      body: plantsViewModel.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await plantsViewModel.getPlants(controllerSearch.text);
              },
              child: !plantsViewModel.loading && plantsViewModel.plants.isEmpty
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: Functions.getHeightBody(context),
                        child: Column(
                          children: [
                            const Spacer(),
                            Container(
                              height: 150,
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/images/icon.png',
                              ),
                            ),
                            const Text(
                              'Plantas não encontradas',
                              style: TextStyle(
                                fontSize: 20,
                                color: Palette.gray,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: plantsViewModel.plants.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: SizedBox(
                            width: 70,
                            child: TextButton(
                              onPressed: () {
                                Functions.showNetworkImageFullScreen(context, plantsViewModel.plants[index].imageUrl);
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  )),
                              child: CachedNetworkImage(
                                imageUrl: plantsViewModel.plants[index].imageUrl,
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
                                    Icons.nature,
                                    size: 50,
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
                              // fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Text(
                            plantsViewModel.plants[index].category,
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
    );
  }
}
