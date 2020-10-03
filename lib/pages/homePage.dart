import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/pages/pokeList.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';

class HomePage extends StatelessWidget {
  static String id = 'HomePage';
  PokeHub pokeData = new PokeHub();
  @override
  Widget build(BuildContext context) {
    pokeData.runPokeAPi();
    return Scaffold(
          body: Container(
          child: Center(
        child: Text('esperando datos'),
      )),
    );
  }
}
