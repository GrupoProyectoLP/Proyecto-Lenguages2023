import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_style_app/src/pages/home.dart';
import 'package:tmdb_style_app/src/providers/appProvider.dart';
import 'package:tmdb_style_app/src/widgets/email_input.dart';
import 'package:tmdb_style_app/src/widgets/passwordField.dart';

class login extends StatelessWidget{
  login({Key? key}) : super(key: key);

  final usernameController = TextEditingController(text: 'jimmie_k');
  final passwordController = TextEditingController(text: 'klein*#%*');

  AppProvider get service => GetIt.I<AppProvider>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
          Color.fromARGB(230, 1, 180, 228),
          Color.fromARGB(225, 1, 137, 174),
          Color.fromARGB(250, 124, 178, 139),
          Color.fromARGB(230, 144, 206, 161),
        ]),
      ),
      child: Padding(padding: const EdgeInsets.only(top: 100.0, left:22),
      child: Text('Inicio de Sesión',style: TextStyle(
        fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold
      ),),),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 35),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EmailInput(controller: usernameController),

                        const SizedBox(height: 25,),
                        
                        PasswordField(controller: passwordController, obscure: true,),

                        const SizedBox(height: 20,),
                        Row(
                  children: [
                    Checkbox(
                      activeColor: Color.fromARGB(225, 1, 137, 174), 
                      value: true, onChanged: (value) {}),
                    const Text('Recuerdame'),
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Olvidé mi contraseña', style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15, color: Color.fromARGB(250, 124, 178, 139),
                            ),))
                  ],
                              ),
                        const SizedBox(height: 70,),
                        GestureDetector(
                          onTap: () async{
                          if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                            label: 'Aceptar',
                            onPressed: () {},
                          ),
                          showCloseIcon: true,
                          duration: const Duration(seconds: 5),
                          content: const Text('Correo y contraseña obligatorios', style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold,),),
                        ),
                      );
                  }

                      final getToken = await service.loginProv(
                        usernameController.text,
                        passwordController.text,
                      );
                      if(getToken !=null && getToken['token'] != null){
                        //solicitud exitosa
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Inicio de sesión exitoso', style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold,),),
                            backgroundColor: Color.fromARGB(230, 144, 206, 161),
                        ));
                        Future.delayed(
                          const Duration(seconds: 2),
                          () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home()),),
                        );
                      }else  {
                        //Error en la solicitud
                          ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(
                          showCloseIcon: true,
                          duration: const Duration(seconds: 2),
                            content: Text('Credenciales no válidas', style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold,),),
                            backgroundColor: Color.fromARGB(255, 230, 109, 109),
                        ),
                      );
                    }
                         },   //onTap
                          child: Container(
                            height: 55,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(230, 1, 180, 228),
                                Color.fromARGB(225, 1, 137, 174),
                                Color.fromARGB(250, 124, 178, 139),
                                Color.fromARGB(230, 144, 206, 161),
                              ])
                            ),
                            child: Center(child: Text('Iniciar sesión', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white
                            ),),),
                          ),
                        ),
                        const SizedBox(height: 130,),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('¿Eres nuevo en TMDB?', style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey
                              ),),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Crea una cuenta', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color.fromARGB(255, 13, 37, 63)
                              ),),
                              ),
                            ],
                          ),
                        )
                      ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}