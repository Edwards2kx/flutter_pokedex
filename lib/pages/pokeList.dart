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
    // if (_scrollController.offset > _cardHeight * 5) {
    //   //print('llama mas pokemons');
    // }
  }

  PokeHub pokeHub = new PokeHub();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Generation ${widget.generation}',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black),
        ),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1600.0),
              child: FutureBuilder(
          future: pokeHub.getPokeGeneration(widget.generation),
          builder:
              (BuildContext context, AsyncSnapshot<List<PokeGenData>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) => buildCardList(snapshot.data[i]),
              );
            } else
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('Check your internet connection...'),
                  ],
                ),
              );
          },
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
