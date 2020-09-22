import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String id = 'HomePage';
  @override
  Widget build(BuildContext context) {
    String type = 'bug';
    return Container(
      color: Colors.grey,
      //child: Center(child: Image.asset('../assets/loading_ball.gif')),
      child: Center(child: Image.asset('../assets/types_icons/$type.png')),
      
    );
  }
}