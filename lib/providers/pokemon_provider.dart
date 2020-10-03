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

class PokeHub {
  Future<List<Pokemon>> runPokeAPi() async {
    String pokeApiUrl = 'https://pokeapi.co/api/v2/pokemon?limit=10&offset=30';
    List<Pokemon> pokemons = [];
    var _response = await http.get(pokeApiUrl);
    if (_response.statusCode == 200) {
      print('consulta 1 exitosa');
      var _json = jsonDecode(_response.body);
      for (var i in _json['results']) {
        //print(i['url']);
        var _resp = await http.get(i['url']);
        if (_resp.statusCode == 200) {
          var _data = jsonDecode(_resp.body);
//          print(_data['types'][0]['type']['name']);
          pokemons.add(Pokemon.fromJsonMap(_data));

          //print(data['name']);
          //print(_resp.body);
        } else {
          print('hubo un error en la consulta, cod: ${_resp.statusCode}');
          return [];
        }
      }
      // for(Pokemon i in pokemons) {
      //   print(i.name);
      // }
      print('fin del future');
      return pokemons;
    } else {
      print('hubo un error en la consulta, cod: ${_response.statusCode}');
      return [];
    }
  }

  Future<List<PokeGenData>> getPokeGeneration(int generation) async {
    int _limit = 151;
    int _offset = 0;
    List<PokeGenData> _pokemons = [];

    switch (generation) {
      case 1: //mew
        _limit = 151;
        _offset = 0;
        break;
      case 2: //celebi
        _limit = 100;
        _offset = 151;
        break;
      case 3:  //deoxys
        _limit = 135;
        _offset = 251;
        break;                
      case 4: //arceus
        _limit = 107;
        _offset = 386;
        break;
      case 5: //genesect
        _limit = 156;
        _offset = 493;
        break;
        case 6: //volcanion
        _limit = 71;
        _offset = 649;
        break;
        case 7: //melmetal
        _limit = 71;
        _offset = 721;
        break;        
      default:
    }

    String _pokeApiUrl =
        'https://pokeapi.co/api/v2/pokemon?limit=$_limit&offset=$_offset';
    var _response = await http.get(_pokeApiUrl);

    try {
      if (_response.statusCode == 200) {
        print('se hizo la consulta');
        var _json = jsonDecode(_response.body);
        //print('data: ${_response.body}' );
        for (var i in _json['results']) {
          _pokemons.add(PokeGenData(nombre: i['name'], url: i['url']));
        }
        _pokemons.forEach((element) {
          //print(element.nombre);
        });
      } else {
        return [];
      }
      return _pokemons;
    } catch (e) {
      print('hubo un error');
    }
  }

  Future<Pokemon> getPokemon(PokeGenData _getThisPokemon) async {
    Pokemon _pokemon;
    var _response = await http.get(_getThisPokemon.url);
    if (_response.statusCode == 200) {
      var _json = jsonDecode(_response.body);
      //print(_json['name']);
      _pokemon = Pokemon.fromJsonMap(_json);
      //print(_response.body);
    } else {
      print('hubo un error al consultar un pokemon');
    }

    return _pokemon;
  }

  String _url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  Future<List<Pokemon>> getPokemons() async {
    List<Pokemon> pokemons = [];
    var response = await http.get(_url);
    if (response.statusCode == 200) {
      print('consulta 1 exitosa');
      var jsonMap = jsonDecode(response.body);
      for (var i in jsonMap['pokemon']) {
        //second await function
        //print(i['species']['name']);
        pokemons.add(Pokemon.fromJsonMap(i));
      }
      return pokemons;
    } else {
      print('fallo en la consulta');
      return [];
    }
  }

  Future<Evolution> getEvolutionChain() async {
    //var _response = await http.get(_url);
    Evolution evolution = Evolution(1, 'a', 'b', 'c', 'd');
    return evolution;
  }
}

class Evolution {
  int id;
  String preEvolution;
  String lvPreEvolution;
  String evolution;
  String lvEvolution;

  Evolution(this.id, this.evolution, this.lvEvolution, this.preEvolution,
      this.lvPreEvolution);
}

class PokeGenData {
  String nombre;
  String url;
  PokeGenData({this.nombre, this.url});
}

/*

PARA EL PROVIDER

guardar esta url en el modelo pokemon
json['species']['url']   =>  https://pokeapi.co/api/v2/pokemon-species/2/
al entrar a la vista de evolucion realizar la consulta

*/

class Pokemon {
  int id;
  String number;
  String name;
  String img;
  int height;
  int weight;
  int hp;
  int attack;
  int defense;
  int spAtk;
  int spDef;
  int speed;
  List<String> type = [];
  List<String> abilities = [];
  List<dynamic> preEvolution;
  List<dynamic> netxEvolution;
  Color backGroundColor = pokemonColorMap['normal'];

  Pokemon({this.id, this.name, this.number, this.img, this.type});

  Pokemon.dummy() {
    id = 000;
    name = '???';
    number = '???';
    type = ['normal'];
  }

  Pokemon.fromJsonMap(Map<String, dynamic> json) {
    try {
      id = json['id'];
      number = id.toString().padLeft(3, '0');
      name = json['name'];
      img = json['sprites']['other']['official-artwork']['front_default'];
      //print(img);
      height = json['height'];
      weight = json['weight'];
      for (var i in json['types']) {
        type.add(i['type']['name']);
      }
      for (var i in json['abilities']) {
        abilities.add(i['ability']['name']);
      }

      hp = json['stats'][0]['base_stat'];
      attack = json['stats'][1]['base_stat'];
      defense = json['stats'][2]['base_stat'];
      spAtk = json['stats'][3]['base_stat'];
      spDef = json['stats'][4]['base_stat'];
      speed = json['stats'][5]['base_stat'];

      backGroundColor = pokemonColorMap[type[0].toString().toLowerCase()];
    } catch (e) {
      print('hubo un error en los tipado de los datos $e');
    }
    //var _types = json['types'][0]['type']['name'];
    //print(_types);

    //preEvolution = json[''];
    //  type = json['type'];
    //print(json['type'].toString());
    //type.forEach((element) {print(element);});
    //types = json['type'].cast<String>();
    //  types = json['type'].
    //types.map((e) => null)
//    List<String>
    //backGroundColor = pokemonColorMap[type[0].toString().toLowerCase()];
  }
}

//https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json

// url para las imagenes
// https://assets.pokemon.com/assets/cms2/img/pokedex/full/$id.png
