import 'package:flutter/material.dart';
//import 'package:portfolio_pokedex/providers/copy.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';
import 'package:portfolio_pokedex/ui/size_config.dart';

class EvolutionTabPage extends StatelessWidget {
  final Pokemon pokemon;
  EvolutionTabPage(this.pokemon);

  PokeHub pokeHub = new PokeHub();

  @override
  Widget build(BuildContext context) {
  SizeConfig().init(context);
//    pokeHub.getEvolutionChain(pokemon.id);
    return Container(
//      color: Colors.red,
      child: Column(
        children: [Container( padding: EdgeInsets.symmetric(vertical: 10.0 , horizontal: 20.0),
        child: Text('Evolution Chain' , style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.w500),),),
          FutureBuilder(
            future: pokeHub.getEvolutionChain(pokemon.id),
            builder:
                (BuildContext context, AsyncSnapshot<List<Evolution>> snapshot) {
              if (snapshot.hasData) {
                List<Widget> _pokemons = [];
                for (var i in snapshot.data) {
                  _pokemons.add(_pokeEvolCard(i));
                }

                if (_pokemons.length == 1) {
                  return Center(
                    child: (Text(
                      'this pokemon do not evol',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  );
                } else if (_pokemons.length == 2) {
                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [_pokemons[0], _pokemons[1]],
                        ),
                        SizedBox(
                          height: 30.0,
                          child: Divider(
                            color: Colors.grey[200],
                            height: 2.0,
                            indent: 20.0,
                            endIndent: 20.0,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [_pokemons[0], _pokemons[1]],
                        ),
                        SizedBox(
                          height: 30.0,
                          child: Divider(
                            color: Colors.grey[200],
                            height: 2.0,
                            indent: 20.0,
                            endIndent: 20.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [_pokemons[1], _pokemons[2]],
                        ),
                      ],
                    ),
                  );
                }

                //modifica la fila para hacer 2 lineas

              } else
                return Container(color: Colors.red[100]);
            },
          ),
        ],
      ),
    );
  }

  Widget _pokeEvolCard(Evolution pokemon) {
    
    //double size = 100.0;
    double size = SizeConfig().getProportionalScreenHeight(12);
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size * 1.2,
              height: size * 1.2,
              decoration: BoxDecoration(
//                shape: BoxShape.circle,
//                border: Border.all(color: Colors.orange, width: 4.0),
                  ),
              child: Image.asset(
                'assets/pokeball.png',
                color: Colors.black.withOpacity(0.2),
                fit: BoxFit.contain,
              ),
              //     width: 130.0,
              //     child: Image.asset(
              //       'assets/pokeball.png',
              //       color: Colors.white.withOpacity(0.10),
              //     ),
            ),
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      pokemon.img,
                    ),
                    fit: BoxFit.contain),
              ),
            ),
          ],
        ),
        Text(pokemon.name, style: TextStyle(fontWeight: FontWeight.w600))
      ],
    );
  }
}

/*

PARA EL PROVIDER

guardar esta url en el modelo pokemon
json['species']['url']   =>  https://pokeapi.co/api/v2/pokemon-species/2/
al entrar a la vista de evolucion realizar la consulta

*/
