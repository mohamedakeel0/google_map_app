import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafletapp/bloc/cubic.dart';
import 'package:leafletapp/bloc/state.dart';
import 'package:leafletapp/shared/network/ckecknetwork.dart';
import 'package:leafletapp/shared/network/remot/dio_helper.dart';
import 'package:leafletapp/shared/resources/routes_manager.dart';
import 'package:leafletapp/shared/resources/theme_manager.dart';
import 'package:leafletapp/view/bottomshet.dart';
import 'package:leafletapp/view/map_screen.dart';

import 'bloc/bloc_observer/blocObserver.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  await MapUtils;
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MapCubic()..checkEnternet()..getPosition()..getCurrentLocation()..getCategories(0)..getItemDetail(0),
        ),
       
      ],
      child: BlocConsumer<MapCubic, MapStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MapCubic.get(context).getCurrentLocation();
          MapCubic.get(context).checkEnternet();
           return MaterialApp(theme: getApplicationTheme(), onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.firstScreen,

            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
   
  }


