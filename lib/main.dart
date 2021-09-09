
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_app/screen/home.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
runApp(MaterialApp(
  home: Home(),
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.grey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme: AppBarTheme(
      color: Colors.white,
    ),
  ),
));
}
