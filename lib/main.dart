import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/pages/homePage.dart';
import 'package:portfolio_pokedex/pages/pokeList.dart';

void main() {
  runApp(MyApp());
}
//para scafold oxFFF2F2F2
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0.0,
          color: Colors.transparent,
          textTheme: TextTheme(
            subtitle2: TextStyle(color: Colors.black),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: TextStyle(color: Colors.green),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          //indicator: BoxDecoration(color: Colors.yellow),
          
          
        )
      ),
      initialRoute: HomePage.id,
      //initialRoute: PokeList.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        PokeList.id: (context) => PokeList()
      },
    );
  }
}
