import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/pages/pokeList.dart';
import 'package:portfolio_pokedex/pages/widgets/pokeCard.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';

class HomePage extends StatelessWidget {
  static String id = 'HomePage';
  PokeHub pokeHub = new PokeHub();

  Widget _testing() {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.red,
            width: double.infinity,
            height: 100.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: pokeHub.getPokeGeneration(1),
              builder: (BuildContext context,
                  AsyncSnapshot<List<PokeGenData>> snapshot) {
                if (snapshot.hasData) {
                  print(
                      'se resolvio el future con ${snapshot.data.length} datos');
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) => pokeCard(snapshot.data[i]),
                  );
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _home() {
    List<int> _generation = [1, 2, 3, 4, 5, 6, 7];
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokeList(
                          generation: _generation[i],
                        )));
          },
          child: Container(
            height: 120.0,
            decoration: BoxDecoration(color: Colors.grey),
            margin: EdgeInsets.all(20.0),
            child: Center(
              child: Text('Generation ${_generation[i]}'),
            ),
          ),
        ),
        itemCount: _generation.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //pokeHub.getPokeGeneration(1);
    //return _testing();
    return _home();
  }

  Widget pokeCard(PokeGenData pokemon) {
    return Container(
//      margin: EdgeInsets.all(20.0),
//      color: Colors.blueAccent,
//      width: double.infinity,
      //height: 100.0,
      child: Column(
        children: [
          getPokemonData(pokemon),
        ],
      ),
    );
  }

  Widget getPokemonData(PokeGenData pokemon) {
    return FutureBuilder(
      initialData: Pokemon.dummy(),
      future: pokeHub.getPokemon(pokemon),
      builder: (BuildContext context, AsyncSnapshot<Pokemon> snapshot) {
        return PokeCard(snapshot.data);
      },
    );
  }
}
