
import 'package:flutter/material.dart';
import 'package:leafletapp/shared/resources/string_manager.dart';
import 'package:leafletapp/view/bottomshet.dart';
import 'package:leafletapp/view/first_screen.dart';
import 'package:leafletapp/view/map_screen.dart';

class Routes{
  static const String firstScreen ='/';
  static const String mapScreen ='/map';
  static const String bottomsheet ='/bottomsheet';

}
class RouteGenerator{
 static Route<dynamic>  getRoute(RouteSettings settings){
switch(settings.name){
  case Routes.firstScreen:
    return MaterialPageRoute(builder: (_)=>FirstScreen());
  case Routes.mapScreen:
    return MaterialPageRoute(builder: (_)=>MapsScreen());
  case Routes.mapScreen:
    return MaterialPageRoute(builder: (_)=>bottomsheet());

  default:
    return unDefinedRoute();
}
  }
  static Route<dynamic>unDefinedRoute(){
   return MaterialPageRoute(builder: (_)=>Scaffold(
     appBar: AppBar(title: Text(AppStrings.noRoutefound),),body: Center(child: Text(AppStrings.noRoutefound),),
   ));
  }
}