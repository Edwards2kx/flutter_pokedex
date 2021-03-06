import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';

class StatsTabPage extends StatelessWidget {
  final Pokemon pokemon;
  StatsTabPage(this.pokemon);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Base Stats',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
        ),
        
        StatBarItem(text: 'Hp', value: pokemon.hp, barColor: Colors.red),
        StatBarItem(text: 'Attack', value: pokemon.attack, barColor: Colors.green),
        StatBarItem(text: 'Defense', value: pokemon.defense, barColor: Colors.red),
        StatBarItem(text: 'Sp. Atk', value: pokemon.spAtk, barColor: Colors.green),
        StatBarItem(text: 'Sp. Def.', value: pokemon.spDef, barColor: Colors.red),
        StatBarItem(text: 'Speed', value: pokemon.speed, barColor: Colors.blue),
      ]),
    );
  }
}

class StatBarItem extends StatelessWidget {
  const StatBarItem({
    @required this.text,
    @required this.value,
    @required this.barColor,
  });

  final String text;
  final int value;
  final Color barColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(text,
                  style:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0))),
          Expanded(flex: 1, child: Container(color: Colors.amber)),
          Expanded(flex: 1, child: Text(value.toString())),
          Expanded(
            flex: 6,
            child: Container(
              height: 10.0, //altura de indicator bar
              child: Row(
                children: [
                  Expanded(flex: value, child: Container(color: barColor)),
                  Expanded(
                      flex: 100 - value,
                      child: Container(color: Colors.grey[200])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
