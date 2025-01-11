import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plants/core/navigation_service.dart';
import 'package:plants/core/providers.dart';
import 'package:plants/core/theme_data.dart';
import 'package:plants/features/plants/presentation/views/plants_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const Plants());
}

class Plants extends StatelessWidget {
  const Plants({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Plants',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        theme: buildTheme(),
        home: const PlantsView(),
      ),
    );
  }
}
