import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static const primaryColor = Colors.teal;
  static const secondaryColor = Colors.orange;
  static TextStyle appBarTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 30,
    fontFamily: GoogleFonts.orienta().fontFamily,
  );

  static TextStyle todoTextStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize:45,
  );
  static TextStyle completedTodoTextStyle = const TextStyle(
    fontWeight: FontWeight.w500,
    letterSpacing: 2,
    fontSize: 20,
    decoration: TextDecoration.lineThrough,
    color: Colors.grey,
  );
}
