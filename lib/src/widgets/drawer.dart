import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_style_app/src/providers/appProvider.dart';
import 'package:tmdb_style_app/src/routes/routes.dart';

class DrawerElements extends StatelessWidget{
  DrawerElements({Key? key}) : super(key: key);

  AppProvider get service => GetIt.I<AppProvider>();

  @override
  Widget build(BuildContext context){
    return Drawer(
      backgroundColor: Color.fromARGB(225, 1, 137, 174),
      child: ListView(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                backgroundColor:  Color.fromARGB(230, 1, 180, 228),
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              SizedBox(height: 30),
              ListTile(
                leading: const Icon(Icons.logout_outlined, color: Colors.white,),
                title: const Text('Cerrar Sesión', style: TextStyle( color: Colors.white,),),
                onTap: () {
                  Navigator.pop(context);
                  logoutMessage(context);
                },
              ),
            ],
          ),
    );
  }

  logoutMessage(BuildContext context) async {
    final navigator = Navigator.of(context);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar Sesión'),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                navigator.pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                navigator.pop();
                navigator.pushNamedAndRemoveUntil(
                    Routes.loginPage.name, (route) => false);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}