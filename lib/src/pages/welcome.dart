import 'package:flutter/material.dart';
import 'package:tmdb_style_app/src/routes/routes.dart';

class Welcome extends StatelessWidget{
  const Welcome({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
      //    Color.fromARGB(255, 13, 37, 63),
          Color.fromARGB(230, 1, 180, 228),
          Color.fromARGB(225, 1, 137, 174),
          Color.fromARGB(250, 124, 178, 139),
          Color.fromARGB(230, 144, 206, 161),
        ]),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 180.0),
            child: Image(image: AssetImage('assets/images/welcomeLogo.png'),width: 300, height: 200, filterQuality: FilterQuality.high)
            ),
          SizedBox(height: 80),
          Text('Bienvenido',style: TextStyle(fontSize: 30, color: Colors.white),),
          SizedBox(height: 30),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);

                Navigator.pushNamed(
                  context,
                  Routes.loginPage.name,
                );
            },
            child: Container(
              height: 53,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white), 
              ),
              child: const Center(child: Text('Iniciar sesión', style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold, color: Colors.white),),),
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: (){
              
            },
            child: Container(
              height: 53,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: const Center(child: Text('Registrarse', style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold, color: Colors.black),)),
            ),
          ),
        ],
      ),
      ),
    );
  }
}