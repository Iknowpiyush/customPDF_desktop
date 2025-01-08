import 'package:flutter/widgets.dart';

class Dimensions {
  static double screenHeight = 0.0;
  static double screenWidth = 0.0;

  static double heightMultiplier = 0.1;  // 10% of screen height
  static double widthMultiplier = 0.08;  // 8% of screen width

  static double xsmallPaddingMultiplier = 0.01;
  static double smallPaddingMultiplier = 0.02;
  static double mediumPaddingMultiplier = 0.03;
  static double largePaddingMultiplier = 0.04;
  static double xlargePaddingMultiplier = 0.05;
  static double xxlargePaddingMultiplier = 0.06;

  static double buttonHeightMultiplier = 0.08;  // 8% of screen height
  static double textFieldHeightMultiplier = 0.1; // 10% of screen height

  static double smallIconMultiplier = 0.03; // 3% of screen width
  static double medIconMultiplier = 0.05;   // 5% of screen width
  static double largeIconMultiplier = 0.08;  // 8% of screen width

  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }

  // Use these getters to get the responsive values
  static double get height => screenHeight * heightMultiplier;
  static double get width => screenWidth * widthMultiplier;

  static double get xsmallPadding => screenHeight * xsmallPaddingMultiplier;
  static double get smallPadding => screenHeight * smallPaddingMultiplier;
  static double get mediumPadding => screenHeight * mediumPaddingMultiplier;
  static double get largePadding => screenHeight * largePaddingMultiplier;
  static double get xlargePadding => screenHeight * xlargePaddingMultiplier;
  static double get xxlargePadding => screenHeight * xxlargePaddingMultiplier;

  static double get buttonHeight => screenHeight * buttonHeightMultiplier;
  static double get textFieldHeight => screenHeight * textFieldHeightMultiplier;

  static double get smallIcon => screenHeight * smallIconMultiplier;
  static double get medIcon => screenHeight * medIconMultiplier;
  static double get largeIcon => screenHeight * largeIconMultiplier;
}
