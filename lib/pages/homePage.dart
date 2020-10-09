import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/pages/pokeList.dart';
import 'package:portfolio_pokedex/pages/widgets/pokeCard.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';

class HomePage extends StatelessWidget {
  static String id = 'HomePage';
  PokeHub pokeHub = new PokeHub();
  //final List<int> _generation = [1, 2, 3, 4, 5, 6, 7];

  @override
  Widget build(BuildContext context) {
    //pokeHub.getPokeGeneration(1);
    //return _testing();
    return _home(context);
  }

  Widget _home(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      '../assets/logo.png',
                    ),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          Expanded(flex: 7, child: gridGenerations()),
          Expanded(flex: 1, child: Center(child: Text('Made by Edwards2kX'))),
        ],
      ),
      //body: generationListView(),
    );
  }

  Widget gridGenerations() {
    return Container(
      child: Column(children: [
        Expanded(
          child: Row(
            children: [GenerationCard(1), GenerationCard(2)],
          ),
        ),
        Expanded(
          child: Row(
            children: [GenerationCard(3), GenerationCard(4)],
          ),
        ),
        Expanded(
          child: Row(
            children: [GenerationCard(5), GenerationCard(6)],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              GenerationCard(7),
              Expanded(child: SizedBox()),
            ],
          ),
        )
      ]),
    );
  }

 
}

class GenerationCard extends StatelessWidget {
  final int generation;
  GenerationCard(this.generation);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        margin: EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokeList(
                          generation: generation,
                        )));
          },
          child: Stack(
            overflow: Overflow.clip,
            children: [
              Container(),
              Align(
                alignment: Alignment.center,
                child: Column(children: [
                  Text('generation $generation' , style: TextStyle(fontSize: 20.0),),
                  SizedBox(height: 10.0,),
                  Container(
                    child: Image.asset(
                      'assets/generation_img/Generation_$generation.jpg',
                      height: 80.0,
                    ),
                  ),
                ]),
              ),
              Positioned(
                right: 0.0,
                bottom: 0.0,
                child: Image.asset(
                  'assets/pokeball.png',
                  width: 100.0,
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
