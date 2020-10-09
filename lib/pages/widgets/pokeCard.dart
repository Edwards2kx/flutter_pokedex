import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/pages/detailPage.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';

class PokeCard extends StatelessWidget {
  final Pokemon pokemon;
  final double pokeCardWidth = 400.0;
  final double pokeCardHeight = 120.0;
  PokeCard(this.pokemon);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('pulsaste sobre ${pokemon.name}');
        if (pokemon.id != 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailPage(pokemon)));
        }
      },
      child: Container(
        width: pokeCardWidth,
        height: pokeCardHeight,
        //padding: EdgeInsets.symmetric(vertical: 20.0),
        margin: EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
//          color: Colors.grey[300],
          color: pokemon.backGroundColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                //color: Colors.grey[100], // casi invisible
                color: pokemon.backGroundColor,
                offset: Offset(0.0, 4.0),
                blurRadius: 10.0,
                spreadRadius: 1.0),
          ],
        ),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(), //contenedor principal
            Positioned(
              left: pokeCardWidth / 2,
              top: 20.0,
              child: dots(),
            ),
            Positioned(
              left:25.0,
              //bottom: 20.0,
              child: pokeBall(),
            ),
            Positioned(
              left: 10.0,
              top: -20.0,
              child: pokeImage(),
            ),
            Positioned(
              right: 10.0,
              child: pokeInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget dots() {
    return Container(
        width: pokeCardWidth / 3,
        height: pokeCardHeight / 3,
        //child: Image.asset('../../../assets/dotted.png')
        child: Image.asset(
          'assets/dotted.png',
          color: Colors.white.withOpacity(0.10),
        ));
  }

  Widget pokeBall() {
    final double size = 140.0;
    return Container(
        width: size,
        height: size,
        child: Image.asset(
          'assets/pokeball.png',
          color: Colors.white.withOpacity(0.10),
        ));
  }

  Widget pokeInfo() {
    List<Widget> typesIcons = [];
    String _name =
        '${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)}';

    pokemon.type.forEach((element) {
      typesIcons.add(TypeCard(typePokemon: element));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('N°${pokemon.number}',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w200)),
        Text(
          _name,
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w800),
        ),
        Row(
          children: typesIcons,
        )
      ],
    );
  }

  Widget pokeImage() {
    return Hero(
      tag: pokemon.id,
      child: Container(
        //color: Colors.red,
        //width: 180,
        height: 140,
        child: FadeInImage.assetNetwork(
          width: 180.0,
          height: 180.0,
          placeholderScale: 0.1,
          placeholder: 'assets/pokeball_icon.png',
          // image:
          //     'https://assets.pokemon.com/assets/cms2/img/pokedex/full/00${pokemon.id}.png', //ojo aqui
          image: pokemon.img != null
              ? pokemon.img
              : 'assets/pokeball_icon.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class TypeCard extends StatelessWidget {
  final String typePokemon;
  TypeCard({this.typePokemon});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        margin: EdgeInsets.only(left: 10.0),
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.white.withOpacity(0.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/types_icons/$typePokemon.png')),
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              typePokemon,
              style: TextStyle(color: Colors.white),
            )
          ],
        ));
  }
}
