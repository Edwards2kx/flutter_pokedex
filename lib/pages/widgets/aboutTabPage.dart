import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';

class AboutTabPage extends StatelessWidget {
  final Pokemon pokemon;
  AboutTabPage(this.pokemon);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0 , vertical: 5.0),
      //color: Colors.yellow,
      child: Column(
        
        children: [
          Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
          SizedBox(
            height: 20.0,
          ),
          infoRow('Height', pokemon.height),
          infoRow('Weight', pokemon.weight),
          infoRow('Abilities', 'Overgrow , Chlorophyl'),
          infoRow('Weakeness', 'Fight , Fire'),
          
        ],
      ),
    );
  }

  Widget infoRow(String tag , String data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0 ),
      child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
            Expanded(
                flex: 2,
                child: Text(tag, style: TextStyle(color: Colors.grey))),
            //Flexible(child: null)                ,
            Expanded(flex: 1 , child: Container()),
            Expanded(
                flex: 5,
                child: Text(data, style: TextStyle(color: Colors.black)))
          ]),
    );
  }
}
