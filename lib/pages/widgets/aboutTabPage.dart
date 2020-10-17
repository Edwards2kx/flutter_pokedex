import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';

class AboutTabPage extends StatelessWidget {
  final Pokemon pokemon;
  AboutTabPage(this.pokemon);

  @override
  Widget build(BuildContext context) {
    final String _height = (pokemon.height*10).toString() ;
    final String _weight = (pokemon.weight/10).toString();
    final String _abilities = pokemon.abilities.join(' , ');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0 , vertical: 5.0),
      //color: Colors.yellow,
      child: ListView(
        
        children: [
          Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
          SizedBox(
            height: 20.0,
          ),
          infoRow('Height', '$_height cms'),
          infoRow('Weight', '$_weight Kilograms'),
          infoRow('Abilities', _abilities),
          infoRow('Weakeness', 'Fight , Fire'), 
          Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
          SizedBox(
            height: 20.0,
          ),
          Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
          SizedBox(
            height: 20.0,
          ),
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
