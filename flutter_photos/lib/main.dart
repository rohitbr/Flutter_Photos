import 'package:flutter/material.dart';
import 'package:flutter_photos/view_models/photos_view_model.dart';
import 'package:provider/provider.dart';
import 'widgets/my_home_page.dart';
import 'router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Photos app';
    const color = Colors.amber;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PhotoViewModel()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: appTitle,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
          theme: ThemeData.light(useMaterial3: true).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: color,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: color,
              brightness: Brightness.dark,
            ),
          ),
          themeMode: ThemeMode.system,
        ));
  }
}
