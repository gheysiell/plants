import 'package:flutter/material.dart';
import 'package:plants/shared/palette.dart';
import 'package:plants/shared/styles.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
      body: Container(),
    );
  }
}
