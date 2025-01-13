import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plants/features/plants_details/presentation/viewmodels/plants_details_viewmodel.dart';
import 'package:plants/shared/palette.dart';
import 'package:plants/shared/styles.dart';
import 'package:plants/shared/widgets/not_found.dart';
import 'package:plants/utils/functions.dart';
import 'package:provider/provider.dart';

class PlantsDetailsView extends StatefulWidget {
  final String id;

  const PlantsDetailsView({
    super.key,
    required this.id,
  });

  @override
  State<PlantsDetailsView> createState() {
    return PlantsDetailsViewState();
  }
}

class PlantsDetailsViewState extends State<PlantsDetailsView> {
  late PlantsDetailsViewModel plantsDetailsViewModel;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      plantsDetailsViewModel = context.watch<PlantsDetailsViewModel>();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await plantsDetailsViewModel.getPlantDetails(widget.id);
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
          'Plant',
          style: TextStyles.textStyleTitleAppBar,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Palette.gray,
            size: 30,
          ),
          tooltip: 'Voltar',
        ),
        backgroundColor: Palette.white,
        surfaceTintColor: Palette.white,
      ),
      backgroundColor: Palette.white,
      body: plantsDetailsViewModel.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await plantsDetailsViewModel.getPlantDetails(widget.id);
              },
              child: !plantsDetailsViewModel.loading && plantsDetailsViewModel.plantDetails == null
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: NotFoundWidget(
                        title: 'Detalhes não encontrados',
                        height: Functions.getHeightBody(context) - kToolbarHeight,
                        paddingBottom: 0,
                      ),
                    )
                  : ListView.builder(
                      itemCount: plantsDetailsViewModel.titlesAndInfos.length + 1,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        int indexTitlesAndInfos = index - 1;

                        return index == 0
                            ? Container(
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 20,
                                ),
                                height: 220,
                                child: TextButton(
                                  onPressed: () {
                                    Functions.showNetworkImageFullScreen(
                                        context, plantsDetailsViewModel.plantDetails!.imageUrl);
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: plantsDetailsViewModel.plantDetails!.imageUrl,
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
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return const Icon(
                                        Icons.grass_rounded,
                                        size: 200,
                                        color: Palette.grayLight,
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: !Functions.isPair(indexTitlesAndInfos) ? Palette.white : Palette.cremy,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      child: Text(
                                        plantsDetailsViewModel.titlesAndInfos[indexTitlesAndInfos].title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Palette.gray,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        plantsDetailsViewModel.titlesAndInfos[indexTitlesAndInfos].info,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Palette.gray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
            ),
    );
  }
}
