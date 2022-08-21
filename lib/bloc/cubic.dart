import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:leafletapp/bloc/state.dart';
import 'package:leafletapp/shared/network/remot/dio_helper.dart';
import 'package:leafletapp/model/modelcategories.dart';
import 'package:leafletapp/shared/resources/color_manager.dart';

class MapCubic extends Cubit<MapStates> {
  MapCubic() : super(MapInitailState());

  static MapCubic get(context) => BlocProvider.of(context);
  List? categories;

  void getCategories(cat) async {
    emit(LoadingcategoriesMapState());
    await DioHelper.getdata(url: 'mapapi/categories.php', query: {
      'lang': 'ar',
      'cat': '${cat}',
    }).then((value) {
      print(value.data.runtimeType);

      categories = jsonDecode(value.data);

      print('cato++++++++++${categories!}');
      emit(SuccesscategoriesMapState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorcategoriesMapState(error.toString()));
    });
  }

  List? itemcategories;

  List<Marker> markers = [];

  void getItemcategories(cat,lat,long) async {
    print('cattttttttttttttttttttt=${cat}');
    emit(LoadingItemcategoriesMapState());
    await DioHelper.getdata(url: 'mapapi/map_markers.php', query: {
      'lang': 'ar',
      'lat': lat!=null?'${lat}':'30.0374562',
      'long':long!=null? '${long}':'31.2095052',
      'cat': '${cat}',
    }).then((value) async {
      print(value.data.runtimeType);

      itemcategories = await jsonDecode(value.data);

      print('ithem before````````````````/////////////${itemcategories}');

      emit(SuccessPotinMarkerMapState());
      print(itemcategories![2]['name']);
      print(itemcategories![2]['long']);
      if (markers == null) clearmarker();
      itemcategories!.forEach((element) {
        markers.add(
          Marker(
            anchorPos: AnchorPos.align(AnchorAlign.center),
            height: 30,
            width: 30,
            point: LatLng(double.parse('${element['lat']}'),
                double.parse('${element['long']}')),
            builder: (ctx) => Icon(
              IconDataSolid(int.parse(element['icon_name'])),
              color: HexColor(element['color']),
              size: 30,
            ),
          ),
        );
      });
      if (markers == null) clearmarker();
      print('ithem come/////////////${itemcategories}');

      print(
          'errrrrrrrrrrrrrrrorrrrrrrrrrrrrrrrrr****************+++++++++++++++++++++++++++++++++++++++${markers.length}');

      emit(SuccessItemcategoriesMapState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorItemcategoriesMapState(error.toString()));
    });
  }

  List? ItemDetail;

  void getItemDetail(cat) async {
    print('cattttttttttttttttttttt=${cat}');
    emit(LoadingItemDetailMapState());
    await DioHelper.getdata(url: 'mapapi/map_slider.php', query: {
      'lang': 'ar',
      'lat': '30.0374562',
      'long': '31.2095052',
      'cat': '${cat}',
    }).then((value) async {
      print(value.data.runtimeType);

      ItemDetail = await jsonDecode(value.data);
      print('itemdetail${ItemDetail}');

      emit(SuccessItemDetailMapState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorItemDetailMapState(error.toString()));
    });
  }
void newPosition(lat,long){

  clearmarker();
    emit(newPositionState());
}
  void clearmarker() {
    markers.clear();
    markers.add(Marker(
      point: myLocation!,
      anchorPos: AnchorPos.align(AnchorAlign.center),
      height: 30,
      width: 30,
      builder: (ctx) => Center(
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: ColorManager.blue.withOpacity(0.5),
                    shape: BoxShape.circle),
              ),
            ),
            Center(
              child: Icon(
                Icons.circle,
                color: ColorManager.blue,
                size: 20,
              ),
            ),

          ],
        ),
      ),
    ));
    emit(ClearMarkerState());
  }

  void getCurrentLocation() async {
    print('------------------++++++++++++++++++++++++++++++++++');
    await Geolocator.checkPermission().then((value) async {
      print('request_Permission$value');
      if (value == LocationPermission.denied) {
        Geolocator.requestPermission().then((value) {
          if (value == LocationPermission.denied) {
            Fluttertoast.showToast(
              msg: 'Need Permission to get Location',
              backgroundColor: Colors.red,
            );
            print('Need Permission to get Location');
          } else {
            getPosition();
          }
        });
      } else {
        getPosition();
      }
    });
  }

  LatLng? myLocation;

  Future<void> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('!!!!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@');
    // print('${position.latitude}-${position.longitude}

    myLocation = LatLng(position.latitude, position.longitude);

    GeocodingPlatform.instance
        .placemarkFromCoordinates(position.latitude, position.longitude)
        .then((value) =>
            print('placeMark =========${value[0].name}${value[0].locality}'));
    emit(SuccessPositionState());
  }

  bool buttontrue = true;

  void buttonCkeck(value) {
    buttontrue = value;

    emit(buttonCkeckState());
  }

  bool? result;

  void checkEnternet() async {
    bool result1 = await InternetConnectionChecker().hasConnection;
    if (result1 == true) {
      print(' Connection Done ');
    } else {
      print(' Connection failed ');
      emit(ErrorcheckEnternetState());
    }
    result = result1;
    emit(checkEnternetState());
  }
}
