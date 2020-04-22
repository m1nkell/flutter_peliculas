import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/peliculas_detalle.dart';
 
void main() => runApp(
  MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nuevas peliculas',
      //color: Colors.pink,//Theme.of(context).appBarTheme.color,
      initialRoute: '/',
      routes: {
        '/'         : ( BuildContext context ) => HomePage(),
        'detalles'  : ( BuildContext context ) => PeliculaDetalle(),
      },
    );
  }
}