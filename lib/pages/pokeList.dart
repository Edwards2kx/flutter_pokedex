import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/pages/widgets/pokeCard.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';

class PokeList extends StatelessWidget {
  static String id = 'PokeList';

  @override
  Widget build(BuildContext context) {
    PokeHub pokeHub = PokeHub();
    pokeHub.getPokemons();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pokédex',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Search for Pokémon by name or using the National Pokédex number.',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
            ),
            Container(
              height: 80.0,
              color: Colors.grey[300],
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'What Pokémon are you looking for?',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: pokeHub.getPokemons(),
                builder: (BuildContext context, AsyncSnapshot<List<Pokemon>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) => PokeCard(snapshot.data[i]),
                    );
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
