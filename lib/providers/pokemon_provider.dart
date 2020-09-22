import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

// Map<String , String> pokemonTypeIcon = {
//   'normal': 'Norma',
//   'fighting': ,
//   'flying': Color(0xFF3dc7ef),
//   'poison': Color(0xFFb97fc9),
//   'ground': Color(0xFFab9842),
//   'rock': Color(0xFFa38c21),
//   'bug': Color(0xFF729f3f),
//   'ghost': Color(0xFF7b62a3),
//   'steel': Color(0xFF9eb7b8),
//   'fire': Color(0xFFfd7d24),
//   'water': Color(0xFF4592c4),
//   'grass': Color(0xFF9bcc50),
//   'electric': Color(0xFFeed535),
//   'psychic': Color(0xFFf366b9),
//   'ice': Color(0xFF51c4e7),
//   'dragon': Color(0xFFf16e57),
//   'dark': Color(0xFF707070),
//   'fairy': Color(0xFFfdb9e9),
//   'unknown': Color(0xFFFFFFFF),
//   'shadow': Color(0xFFFFFFFF),
// };

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
  List<String> type = [];
  Color backGroundColor;

  Pokemon({this.id, this.name, this.number, this.img});
  Pokemon.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    number = json['num'];
    name = json['name'];
    img = json['img'];
    type = json['type'].cast<String>();
    backGroundColor = pokemonColorMap[type[0].toString().toLowerCase()];
  }
}

//https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json

// url para las imagenes
// https://assets.pokemon.com/assets/cms2/img/pokedex/full/$id.png
