
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:leafletapp/bloc/cubic.dart';

import 'package:leafletapp/bloc/state.dart';
import 'package:leafletapp/model/categories.dart';
import 'package:leafletapp/shared/components/components.dart';
import 'package:leafletapp/shared/resources/color_manager.dart';
import 'package:leafletapp/shared/resources/constants_manager.dart';
import 'package:leafletapp/shared/resources/string_manager.dart';
import 'package:leafletapp/shared/resources/values_manager.dart';
import 'package:url_launcher/url_launcher.dart';


class MapsScreen extends StatelessWidget {



  final PopupController _popupController = PopupController();
  TextEditingController searchController = TextEditingController();


  int pointIndex = 0;
  MapController mapController = MapController();
  double? lastpositionlatitude;
  double? lastpositionlongitude;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubic, MapStates>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubic = MapCubic.get(context);
          cubic.getCurrentLocation();
          return Scaffold(
            appBar: buildappbar(searchController),
            floatingActionButton:

                FloatingActionButton(
                  child: Icon(Icons.refresh),
                  onPressed: () {
                    MapCubic.get(context).clearmarker();
                    MapCubic.get(context)
                        .getItemDetail(0);
                  }
            ),
            body:Stack(children: [
              FlutterMap(
                options: MapOptions(controller: mapController,
                  center: cubic.myLocation,
                  zoom: 8,onPositionChanged: (position, hasGesture) {
                     lastpositionlongitude =  position.center!.longitude ;
                     lastpositionlatitude =  position.center!.latitude ;
                   var zomm= position.zoom;

                    print('--------------------------${lastpositionlongitude}********${lastpositionlatitude}---------------');
                  },
                  plugins: [
                    MarkerClusterPlugin(),
                  ],
                  onTap: (tapPosition, point) => _popupController.hideAllPopups(),
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                MarkerLayerOptions(markers: cubic.markers, ),
                ],
              ),
             if(cubic.buttontrue==false &&cubic.categories!=null) Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: IconButton(onPressed: (){
                  MapCubic.get(context)
                      .getItemDetail(0);
                  MapCubic.get(context).buttonCkeck(true);
                  MapCubic.get(context).clearmarker();
                  MapCubic.get(context).getCategories(0);


                },icon:Icon(Icons.arrow_back,size: AppSize.s25,) ,),
              ),
              lastpositionlatitude !=null?
              buildItemlistCategoriesTop(cubic.buttontrue,cubic.categories!,lastpositionlatitude,lastpositionlongitude): buildItemlistCategoriesTop(cubic.buttontrue,cubic.categories!,null, null),
              buildItemlistCategoriesBottom( context,cubic.ItemDetail!.length)


            ],)

          );
        });
  }

}
class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}


List categoriesList = <categoriesmodel>[
  categoriesmodel(
      title: AppStrings.hotels,
      id: AppConstants.idhotels,
      icon: FontAwesomeIcons.hotel),
  categoriesmodel(
      title: AppStrings.museums,
      id: AppConstants.idmuseums,
      icon: FontAwesomeIcons.museum),
  categoriesmodel(
      title: AppStrings.pharmacies,
      id: AppConstants.idpharmacies,
      icon: FontAwesomeIcons.fileMedical),
  categoriesmodel(
      title: AppStrings.restaurants,
      id: AppConstants.idrestaurants,
      icon: FontAwesomeIcons.bowlFood),
  categoriesmodel(
      title: AppStrings.mosque,
      id: AppConstants.idMosque,
      icon: FontAwesomeIcons.mosque),
  categoriesmodel(
      title: AppStrings.attraction,
      id: AppConstants.idattraction,
      icon: FontAwesomeIcons.road),
];
List detailscategoriesList = <categoriesmodel>[
  categoriesmodel(
      title: AppStrings.attractionAr,
      id: AppConstants.idhotels,
      icon: Icons.attractions),
  categoriesmodel(
      title: AppStrings.startAr, id: AppConstants.idmuseums, icon: Icons.send),
  categoriesmodel(
      title: AppStrings.callAr,
      id: AppConstants.idpharmacies,
      icon: Icons.call),
  categoriesmodel(
      title: AppStrings.saveAr,
      id: AppConstants.idrestaurants,
      icon: Icons.save),
];
