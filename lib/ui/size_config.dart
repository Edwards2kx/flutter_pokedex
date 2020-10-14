import 'package:flutter/material.dart';


class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double _blockSizeHorizontal;
  static double _blockSizeVertical;
  static double defaultSize;
  static Orientation orientation;



  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    _blockSizeHorizontal = screenWidth / 100;
    _blockSizeVertical = screenHeight / 100;

  }


  double getProportionalScreenHeight(double size){
    return ( size * _blockSizeVertical);
  }

  double getProportionalScreenWidth(double size){
    return ( size * _blockSizeHorizontal);
  }


}