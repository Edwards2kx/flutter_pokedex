import 'package:flutter/material.dart';
import 'package:portfolio_pokedex/pages/widgets/aboutTabPage.dart';
import 'package:portfolio_pokedex/pages/widgets/evolutionTabPage.dart';
import 'package:portfolio_pokedex/pages/widgets/statsTabPage.dart';
import 'package:portfolio_pokedex/providers/pokemon_provider.dart';
import 'package:portfolio_pokedex/pages/widgets/pokeCard.dart';

class DetailPage extends StatefulWidget {
  
  final Pokemon pokemon;
  //final BuildContext context;

  DetailPage(this.pokemon);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
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
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: widget.pokemon.backGroundColor,
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            HeaderHero(pokemon: widget.pokemon),
            Container(
              color: Colors.transparent,
              height: 100.0,
              child: TabBar(
                tabs: myTabs,
                controller: _tabController,
                labelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 16.0),
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    AboutTabPage(),
                    StatsTabPage(),
                    EvolutionTabPage()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderHero extends StatelessWidget {
  final Pokemon pokemon;

  const HeaderHero({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(pokemon.name , style: TextStyle(fontSize: 42.0 , color: Colors.white , fontWeight: FontWeight.bold , letterSpacing: 1.3),),
              Text('#${pokemon.number}' , style: TextStyle(fontSize: 30.0 , color: Colors.white , fontWeight: FontWeight.w400 , )),
            ],
          ),
          TypeCard(typePokemon: pokemon.type[0],),

          Hero(
            tag: pokemon.id,
            child: FadeInImage.assetNetwork(
              width: 180.0,
              height: 180.0,
              placeholderScale: 0.1,
              placeholder: '../../assets/pokeball_icon.png',
              image:
                  'https://assets.pokemon.com/assets/cms2/img/pokedex/full/${pokemon.number}.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
