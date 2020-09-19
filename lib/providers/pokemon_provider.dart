import 'dart:convert';

import 'package:http/http.dart' as http;

class PokeHub {
  String _url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  Future<List<Pokemon>> getPokemons() async {
    List<Pokemon> pokemons = [];

    var response = await http.get(_url);

    if (response.statusCode == 200) {
      var jsonMap = jsonDecode(response.body);

      //print('respuesta ${response.body}');
      //print('respuesta ${jsonMap['pokemon'][0]}');

       for (var i in jsonMap['pokemon']) {
         //pokemons.add(Pokemon.fromJsonMap(jsonMap['pokemon'][i]));
         //print('respuesta ${jsonMap['pokemon'][i]}');
         pokemons.add(Pokemon.fromJsonMap(i));
         //print(i);
       }

      return pokemons;

    } else {
      print('fallo en la consulta');
      return [];
    }
  }
}

class Pokemon {
  int id;
  String number;
  String name;
  String img;

  Pokemon({this.id, this.name, this.number, this.img});
  Pokemon.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    number = json['num'];
    name = json['name'];
    img = json['img'];
  }
}

//https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json

// url para las imagenes
// https://assets.pokemon.com/assets/cms2/img/pokedex/full/$id.png
