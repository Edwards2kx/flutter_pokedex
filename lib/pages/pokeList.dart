import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/pages/widgets/pokeCard.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';

class PokeList extends StatefulWidget {
  final generation;
  PokeList({this.generation});
  static String id = 'PokeList';

  @override
  _PokeListState createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
  TrackingScrollController _scrollController;
  @override
  dispose() {
    _scrollController?.removeListener(onScroll);

    super.dispose();
  }

  @override
  initState() {
    _scrollController = TrackingScrollController();
    _scrollController.addListener(onScroll);

    super.initState();
  }

  onScroll() {
    int _cardHeight = 150;
    int _cardView = 10; //depende del tamaño de la lista de pokemons actual

    //print('la posicion es: ${_scrollController.offset}');
    if (_scrollController.offset > _cardHeight * 5) {
      //print('llama mas pokemons');
    }
  }

  PokeHub pokeHub = new PokeHub();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//            ...header(),
            Expanded(
              child: FutureBuilder(
                future: pokeHub.getPokeGeneration(widget.generation),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PokeGenData>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data.length,
                      //itemBuilder: (context, i) => PokeCard(snapshot.data[i]),
                      itemBuilder: (context, i) =>
                          buildCardList(snapshot.data[i]),
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

  List<Widget> header() {
    List<Widget> headerWidgets = [];
    headerWidgets.add(Text(
      'Pokédex',
      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
    ));
    headerWidgets.add(Text(
      'Search for Pokémon by name or using the National Pokédex number.',
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
    ));

    headerWidgets.add(Container(
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(40.0)),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'What Pokémon are you looking for?',
            border: OutlineInputBorder(borderSide: BorderSide.none),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ));

    return headerWidgets;
  }

  Widget buildCardList(PokeGenData pokemon) {
    return FutureBuilder(
      initialData: Pokemon.dummy(),
      future: pokeHub.getPokemon(pokemon),
      builder: (BuildContext context, AsyncSnapshot<Pokemon> snapshot) {
        return PokeCard(snapshot.data);
      },
    );
  }
}
