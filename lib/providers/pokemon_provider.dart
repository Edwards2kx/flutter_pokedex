import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_pokedex/providers/copy.dart';

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
  'grass': Color(0xFF48D0B0),
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
      case 3: //deoxys
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

  Future<List<Evolution>> getEvolutionChain(int id) async {
    String _url = 'https://pokeapi.co/api/v2/pokemon-species/$id/';
    String _urlPokemonName = 'https://pokeapi.co/api/v2/pokemon/';
    String _urlEvoChain;
    String _namePokemon;
    String _nameEvolution;
    String _nameEvolution2;
    String _detailEvolution1;
    String _detailEvolution2;
    String _triggerEvolution1;
    String _triggerEvolution2;
    String _id;
    String _number;
    String _img;
    List<String> evolutions = [];
    List<Evolution> evolutionData = [];
//    List<PokeGenData> evolutions;

    var _response = await http.get(_url);
    try {
      if (_response.statusCode == 200) {
        var _jsonMap = json.decode(_response.body);
        _urlEvoChain = _jsonMap['evolution_chain']['url'];

        var _responseEvol = await http.get(_urlEvoChain);
        if (_responseEvol.statusCode == 200) {
          var _jsonMap2 = json.decode(_responseEvol.body);
          _namePokemon = _jsonMap2['chain']['species']['name'];
          _id = _jsonMap2['chain']['species']['url'];
          _id = _id.substring(42, _id.length - 1);
          _number = _id.padLeft(3, '0');
          _img =
              'https://assets.pokemon.com/assets/cms2/img/pokedex/detail/$_number.png';
          evolutionData.add(Evolution( id: _id , name: _namePokemon , img: _img , number: _number));

          print('el pokemon base es $_namePokemon');
          print('la id del pokemon es $_id');
          evolutions.add(_namePokemon);

//          evolutions.add(PokeGenData(nombre: _namePokemon , ));
          List<dynamic> element1 = _jsonMap2['chain'][
              'evolves_to']; //si es mayor de 1 el pokemon es multievolucion como evee
          if (element1.isNotEmpty) {
            _nameEvolution =
                _jsonMap2['chain']['evolves_to'][0]['species']['name'];
            _triggerEvolution1 = _jsonMap2['chain']['evolves_to'][0]
                ['evolution_details'][0]['trigger']['name'];
            print(_triggerEvolution1);
            if (_triggerEvolution1 == 'use-item') {
//                   print('por objeto');
              _detailEvolution1 = _jsonMap2['chain']['evolves_to'][0]
                  ['evolution_details'][0]['item']['name'];
            } else if (_triggerEvolution1 == 'level-up') {
              //if min level es null preguntar por min happiness
//                    print('por nivel');
              _detailEvolution1 = _jsonMap2['chain']['evolves_to'][0]
                      ['evolution_details'][0]['min_level']
                  .toString();
            }
            evolutions.add(_nameEvolution);

          _id = _jsonMap2['chain']['evolves_to'][0]['species']['url'];
          _id = _id.substring(42, _id.length - 1);
          _number = _id.padLeft(3, '0');
          _img =
              'https://assets.pokemon.com/assets/cms2/img/pokedex/detail/$_number.png';
          evolutionData.add(Evolution( id: _id , name: _nameEvolution , img: _img , number: _number));


            print(
                'nombre de la evolución 1 $_nameEvolution mediante $_triggerEvolution1 el nivel $_detailEvolution1');
            List<dynamic> element2 =
                _jsonMap2['chain']['evolves_to'][0]['evolves_to'];
            //print(_jsonMap2['chain']['evolves_to'][0]['evolves_to']);
            if (element2.isNotEmpty) {
              _nameEvolution2 = _jsonMap2['chain']['evolves_to'][0]
                  ['evolves_to'][0]['species']['name'];
              _triggerEvolution2 = _jsonMap2['chain']['evolves_to'][0]
                  ['evolves_to'][0]['evolution_details'][0]['trigger']['name'];
              _detailEvolution2 = _jsonMap2['chain']['evolves_to'][0]
                      ['evolves_to'][0]['evolution_details'][0]['min_level']
                  .toString();


          _id = _jsonMap2['chain']['evolves_to'][0]['evolves_to'][0]['species']['url'];
          _id = _id.substring(42, _id.length - 1);
          _number = _id.padLeft(3, '0');
          _img =
              'https://assets.pokemon.com/assets/cms2/img/pokedex/detail/$_number.png';
          evolutionData.add(Evolution( id: _id , name: _nameEvolution2 , img: _img , number: _number));




              evolutions.add(_nameEvolution2);
              print(
                  'nombre de la evolución 2 $_nameEvolution2 mediante $_triggerEvolution2 en el nivel $_detailEvolution2');
            } else {
              print('no tiene mas evoluciones');
            }
          } else {
            print('no tiene mas evoluciones');
          }

          // if (_jsonMap2['evolution_details'] == []) {

          // }
          // else {
          //   print('tiene evoluciones');
          // }
        } else {
          print('hubo un error en la consulta de las evoluciones');
        }
        //print(_urlEvoChain);
      } else {
        print('hubo un error en la consulta');
      }
    } catch (e) {
      print('error en la consulta de evolucion');
    }

    //if response['chain]['evolves_to'] tiene 0 items el pokemon no tiene evolucion
    //si ya está evolucionado en ['species'] sale el pokemon base
    //if response['chain]['evolves_to'] tiene items entonces
    // response['chain]['evolves_to'][0]['species']['name'] para la primera evolucion
    // response['chain]['evolves_to'][0]['evolution_details']['min_level] = int para indicar el nivel de evolucion
    //si response['chain]['evolves_to'][0]['evolves_to][0]['species']['name']
    //si response['chain]['evolves_to'][0]['evolves_to][0]['evolution_details']['min_level']
    // si el min_level == null se debe mirar item a ver si no es null
    //
    // response['chain]['evolves_to'][0]['evolution_details']['min_level] = int para indicar el nivel de evolucion
    //var _response = await http.get(_url);
    //Evolution evolution = Evolution(1, 'a', 'b', 'c', 'd');
    //return Evolution();

    // var _responsePokemon = await http.get('$_urlPokemonName$_namePokemon');
    // try {
    //   if (_responsePokemon.statusCode == 200) {
    //     var _jsonMap = json.decode(_responsePokemon.body);
    //     evolutionData.add(Evolution.fromJson(
    //       _jsonMap , _triggerEvolution1 , _detailEvolution1
    //     ));
    //     print(_jsonMap['name']);
    //   }
    // } catch (e) {
    //   print('hubo un fallo al consultar el dato de un pokemon');
    // }


  for(var a in evolutionData){
    print('id del pokemon ${a.id} numero del pokemon ${a.number} nombre del pokemon ${a.name} imagen del pokemon ${a.img}');
  }
    return evolutionData;
    //return evolutions;
    //para obtener la imagen del pokemon, consultar con el nombre al api y sacar id y url
//regreso una lista de objetos que tiene : nombre , imagen, id, forma de evolucion (nivel o piedra), detalle evolucion(nivel o nombre piedra),
  }
}

// class Evolution {
//   int id;
//   String preEvolution;
//   String lvPreEvolution;
//   String evolution;
//   String lvEvolution;

//   Evolution(this.id, this.evolution, this.lvEvolution, this.preEvolution,
//       this.lvPreEvolution);
// }

class PokeGenData {
  String nombre;
  String url;
  PokeGenData({this.nombre, this.url});
}

class Evolution {
  String name;
  String id;
  String img;
  String number;
  //String trigger;
  //String evoDetail;

  //Evolution({ this.name , this.id ,  this.img ,  this.trigger ,this.evoDetail });
  Evolution({this.name, this.id, this.img , this.number});

//   Evolution.fromJson(Map<String, dynamic> json , String trigger , String evoDetail) {
//     this.name = json['name'];
//     this.id = json['id'];
//     this.img = json['sprites']['other']['official-artwork']['front_default'];
//     this.trigger = trigger;
//     this.evoDetail = evoDetail;
//   }

}

/*

PARA EL PROVIDER

guardar esta url en el modelo pokemon
json['species']['url']   =>  https://pokeapi.co/api/v2/pokemon-species/2/
al entrar a la vista de evolucion realizar la consulta

*/


Map <int , String>  generationMap  = {
  1 : 'I',
  2 : 'II',
  3 : 'III',
  4 : 'IV',
  5 : 'V',
  6 : 'VI',
  7 : 'VII',
  8 : 'VIII'
};

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
      //img = json['sprites']['other']['official-artwork']['front_default'];
      img =
          'https://assets.pokemon.com/assets/cms2/img/pokedex/detail/$number.png'; //carga mas rapido que la original
      // if (img == null) {
      //   img = 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/$number.png';
      // }
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
