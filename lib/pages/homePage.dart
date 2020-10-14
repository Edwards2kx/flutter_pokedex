import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/pages/pokeList.dart';
import 'package:portfolio_pokedex/pages/widgets/pokeCard.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';
import 'package:portfolio_pokedex/ui/size_config.dart';

class HomePage extends StatelessWidget {
  static String id = 'HomePage';
  PokeHub pokeHub = new PokeHub();

  @override
  Widget build(BuildContext context) {
    //pokeHub.getPokeGeneration(1);
    //return _testing();
    SizeConfig().init(context);
    // print(
    //     'alto de pantalla : ${SizeConfig.screenHeight} /n ancho de pantalla : ${SizeConfig.screenWidth}');
    // return Scaffold(
    //   body: Center(
    //     child: ConstrainedBox(
    //       constraints: BoxConstraints( maxWidth: 400),
    //               child: Container(
    //         color: Colors.orange,
    //         width: SizeConfig().getProportionalScreenWidth(50),
    //         height: SizeConfig().getProportionalScreenHeight(50),
    //         child: Text('alto de pantalla : ${SizeConfig().getProportionalScreenWidth(50)} \n ancho de pantalla : ${SizeConfig().getProportionalScreenHeight(50)}' )
    //       ),
    //     ),
    //   ),
    // );
    return _home(context);
  }

  Widget _home(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(
        children: [
          Container(
            //width: ,
            height: SizeConfig().getProportionalScreenHeight(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/logo.png',
                  ),
                  fit: BoxFit.contain),
            ),
          ),
//          Container(
//              height: SizeConfig().getProportionalScreenHeight(80),
//              child: gridGenerations()),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [GenerationCard(1), GenerationCard(2)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [GenerationCard(3), GenerationCard(4)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [GenerationCard(5), GenerationCard(6)],
          ),
          Container(
              height: SizeConfig().getProportionalScreenHeight(10),
              child: Center(
                  child: Text(
                'Made by Edwards2kX',
              ))),
        ],
      ),
      //body: generationListView(),
    );
  }

  Widget gridGenerations() {
    return Container(
      child: Column(children: [
        // Expanded(
        //   child:
        // ),
        // Expanded(
        //   child:
        // ),
        // Expanded(
        //   child: Row(
        //     children: [
        //       GenerationCard(7),
        //       Expanded(child: SizedBox()),
        //     ],
        //   ),
        // )
      ]),
    );
  }
}

class GenerationCard extends StatelessWidget {
  final int generation;
  GenerationCard(this.generation);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 140.0,
        maxWidth: 350.0
      ),
      child: Container(
      width: SizeConfig().getProportionalScreenWidth(45),
//      height: SizeConfig().getProportionalScreenHeight(23),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,

        ),
//        margin: EdgeInsets.all(SizeConfig().getProportionalScreenWidth(2.5) ), //poner maximo
        margin: EdgeInsets.symmetric(vertical: SizeConfig().getProportionalScreenHeight(2.5) , horizontal: SizeConfig().getProportionalScreenWidth(2.5) ), //poner maximo
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
            //overflow: Overflow.clip,
            children: [
              Container(),
              Align(
                alignment: Alignment.center,
                child: Column(children: [
                  Text(
                    'generation $generation',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Image.asset(
                      'assets/generation_img/Generation_$generation.jpg',
                      fit: BoxFit.contain,
                      //width: SizeConfig().getProportionalScreenWidth(30),
                      height: 100.0,
                    ),
                  ),
                ]),
              ),
              Positioned(
                right: 0.0,
                bottom: 0.0,
                child: Image.asset(
                  'assets/pokeball.png',
                  //width: SizeConfig().getProportionalScreenWidth(30),
                  width: 80.0,
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
