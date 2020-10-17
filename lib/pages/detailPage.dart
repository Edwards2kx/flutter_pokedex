import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/pages/widgets/aboutTabPage.dart';
import 'package:portfolio_pokedex/pages/widgets/evolutionTabPage.dart';
import 'package:portfolio_pokedex/pages/widgets/statsTabPage.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';
import 'package:portfolio_pokedex/pages/widgets/pokeCard.dart';
import 'package:portfolio_pokedex/ui/size_config.dart';

class DetailPage extends StatelessWidget {
  final Pokemon pokemon;
  static String id = 'DetailPage';

  DetailPage(this.pokemon);

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    Size screenSize = MediaQuery.of(context).size;
    final dataCardHeight = SizeConfig.screenHeight * 0.6;


    return Scaffold(
      backgroundColor: pokemon.backGroundColor,
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(),
          Positioned(
            top: 0.0,
            child: _nameAndType(pokemon, screenSize),
          ),
          Positioned(
              bottom: 0,
              child: InfoTabs(pokemon: pokemon, screenSize: screenSize)),
          //HeaderHero(pokemon: widget.pokemon),
          Positioned(bottom: dataCardHeight - 5.0, child: _heroImage(pokemon , screenSize)),
        ],
      ),
    );
  }

  Widget _nameAndType(Pokemon pokemon, Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0), // global padding
      width: screenSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pokemon.name,
                style: TextStyle(
                    fontSize: 42.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.3),
              ),
              Text('#${pokemon.number}',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  )),
            ],
          ),
          TypeCard(
            typePokemon: pokemon.type[0],
          )
        ],
      ),
    );
  }
}

Widget _heroImage(Pokemon pokemon , Size screenSize) {
  return Hero(
    //placeholderBuilder: ,
    //flightShuttleBuilder: ,
    tag: pokemon.id,
    child: FadeInImage.assetNetwork(
      width: screenSize.width * 0.4,
      alignment: Alignment.bottomCenter,
//      height: 250.0,
      placeholderScale: 0.1,
      placeholder: 'assets/pokeball_icon.png',
      image:pokemon.img,
      //  image:
      //      'https://assets.pokemon.com/assets/cms2/img/pokedex/full/${pokemon.number}.png',
      fit: BoxFit.fill,
    ),
  );
}

class InfoTabs extends StatefulWidget {
  final Pokemon pokemon;
  final Size screenSize;
  InfoTabs({this.pokemon, this.screenSize});
  @override
  _InfoTabsState createState() => _InfoTabsState();
}

class _InfoTabsState extends State<InfoTabs>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> myTabs = [
    Tab(
      text: 'About',
    ),
    Tab(text: 'Stats'),
    Tab(text: 'Evolution'),
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: myTabs.length);
    super.initState();
    //_tabController.
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = widget.screenSize;
    final Pokemon pokemon = widget.pokemon;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0))),
      height: screenSize.height * 0.6,
      width: screenSize.width,
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.transparent,
//            height: 100.0,
            child: TabBar(
              tabs: myTabs,
              controller: _tabController,
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 16.0),
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AboutTabPage(pokemon),
                  StatsTabPage(pokemon),
                  EvolutionTabPage(pokemon)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
