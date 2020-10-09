import 'package:flutter/material.dart';
//import 'package:portfolio_pokedex/providers/copy.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';

class EvolutionTabPage extends StatelessWidget {
  final Pokemon pokemon;
  EvolutionTabPage(this.pokemon);

  PokeHub pokeHub = new PokeHub();
  
  @override
  Widget build(BuildContext context) {
    pokeHub.getEvolutionChain(pokemon.id);
    //final pokeHub.g
    return Container(
      color: Colors.red,
      child: Column(
        children: [
          Text(
            'Evolution chain',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
          
        ],
      ),
    );
  }
}

/*

PARA EL PROVIDER

guardar esta url en el modelo pokemon
json['species']['url']   =>  https://pokeapi.co/api/v2/pokemon-species/2/
al entrar a la vista de evolucion realizar la consulta

*/
