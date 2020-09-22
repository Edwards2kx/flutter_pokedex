import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/pages/homePage.dart';
import 'package:portfolio_pokedex/pages/pokeList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: PokeList.id,
      routes: {
        HomePage.id : (context) => HomePage(),
        PokeList.id : (context ) => PokeList()
      },
    );
  }
}


