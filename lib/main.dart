import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_style_app/src/providers/appProvider.dart';
import 'package:tmdb_style_app/src/routes/routes.dart';

//global ServiceLocator
void setupLocator(){
  GetIt.I.registerLazySingleton(() => AppProvider());
}

void main() {
  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        ),
      initialRoute: Routes.welcomePage.name,
      routes: MyRoutes.routes,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('La ruta ${settings.name} no existe')),
          ),
        );
      },
    );
  }
}
