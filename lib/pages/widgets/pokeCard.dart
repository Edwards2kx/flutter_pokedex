import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';

class PokeCard extends StatelessWidget {
  final Pokemon pokemon;
  PokeCard(this.pokemon);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.0,
      height: 150.0,
      //padding: EdgeInsets.symmetric(vertical: 20.0),
      margin: EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(),
          Positioned(
              left: 10.0,
              top: -20.0,
              child: Container(
                //color: Colors.red,
                width: 180,
                height: 180,
                //child: Image.network(pokemon.img , fit: BoxFit.contain,),
                child: Image.network('https://assets.pokemon.com/assets/cms2/img/pokedex/full/${pokemon.number}.png', 
                fit: BoxFit.contain,),
              )),
          Positioned(
            right: 10.0,
            child: Column(
              children: [
                Text('N°${pokemon.number}'),
                Text(pokemon.name),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
