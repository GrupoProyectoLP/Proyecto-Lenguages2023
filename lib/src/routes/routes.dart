import 'package:flutter/material.dart';
import 'package:tmdb_style_app/src/pages/home.dart';
import 'package:tmdb_style_app/src/pages/login.dart';
import 'package:tmdb_style_app/src/pages/welcome.dart';

enum Routes {welcomePage, loginPage, homePage, detailsPage}

class MyRoutes {
  static final routes = {
    Routes.welcomePage.name: (BuildContext context) => Welcome(),
    Routes.loginPage.name: (BuildContext context) => login(),
    Routes.homePage.name: (BuildContext context) => Home(),
  };
}