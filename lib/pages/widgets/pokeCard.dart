import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';

Map<String, Color> pokemonColorMap = {
  'normal': Color(0xFFA4ACAF),
  'fighting': Color(0xFFd56723),
  'flying': Color(0xFF3dc7ef),
  'poison': Color(0xFFb97fc9),
  'ground': Color(0xFFab9842),
  'rock': Color(0xFFa38c21),
  'bug': Color(0xFF729f3f),
  'ghost': Color(0xFF7b62a3),
  'steel': Color(0xFF9eb7b8),
  'fire': Color(0xFFfd7d24),
  'water': Color(0xFF4592c4),
  'grass': Color(0xFF9bcc50),
  'electric': Color(0xFFeed535),
  'psychic': Color(0xFFf366b9),
  'ice': Color(0xFF51c4e7),
  'dragon': Color(0xFFf16e57),
  'dark': Color(0xFF707070),
  'fairy': Color(0xFFfdb9e9),
  'unknown': Color(0xFFFFFFFF),
  'shadow': Color(0xFFFFFFFF),
};

class PokeCard extends StatelessWidget {
  final Pokemon pokemon;
  PokeCard(this.pokemon);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('pulsaste sobre ${pokemon.name}');
      },
      child: Container(
        width: 400.0,
        height: 150.0,
        //padding: EdgeInsets.symmetric(vertical: 20.0),
        margin: EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          //color: Colors.grey[300],
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

  Widget pokeInfo() {
    List<Widget> typesIcons = [];

    pokemon.type.forEach((element) {
      typesIcons.add(typeCard(element));
    });
    return Column(
      children: [
        Text('N°${pokemon.number}'),
        Text(pokemon.name),
        Row(
          children: typesIcons,
        )
      ],
    );
  }

  Widget typeCard(String typePokemon) {
    int desfaseColor = -30;
    Color baseColor = pokemon.backGroundColor;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        height: 50.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: Color.fromRGBO(
                baseColor.red + desfaseColor,
                baseColor.green + desfaseColor,
                baseColor.blue + desfaseColor,
                1),
            boxShadow: [
              BoxShadow(
                  //color: pokemon.backGroundColor,
                  color: Colors.black38,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 10.0,
                  spreadRadius: 1.0),
            ]),
        child: Row(
          children: [
            Container(
              width: 40.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        '../../assets/types_icons/$typePokemon.png')),
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(typePokemon)
          ],
        ));
  }

  Widget pokeImage() {
    return Container(
      //color: Colors.red,
      width: 180,
      height: 180,
      //child: Image.network(pokemon.img , fit: BoxFit.contain,),
      child: FadeInImage.assetNetwork(
        width: 180.0,
        height: 180.0,
        placeholderScale: 0.1,
        placeholder: '../../assets/pokeball_icon.png',
        image:
            'https://assets.pokemon.com/assets/cms2/img/pokedex/full/${pokemon.number}.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
