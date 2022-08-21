import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafletapp/bloc/cubic.dart';
import 'package:leafletapp/bloc/state.dart';
import 'package:leafletapp/shared/components/components.dart';
import 'package:leafletapp/shared/resources/assets_manager.dart';
import 'package:leafletapp/shared/resources/color_manager.dart';
import 'package:leafletapp/shared/resources/routes_manager.dart';
import 'package:leafletapp/shared/resources/string_manager.dart';
class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubic, MapStates>(
        listener: (context, state) {
          if(state is ErrorcheckEnternetState)ShowToast(text: 'No internet connection',state: Toaststates.ERROR);
        },
        builder: (context, state) {

          var cubic = MapCubic.get(context);
          cubic.getCurrentLocation();
          return Scaffold(body: Container( decoration: BoxDecoration(image: DecorationImage(image: AssetImage(ImageAssets.background),fit:BoxFit.cover )),height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width ,
              child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [
                CircleAvatar(
                  backgroundImage:AssetImage(ImageAssets.Logo), //NetworkImage
                  radius: 90,
                ),
                SizedBox(height: 10,),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: AppStrings.Map,
                        style: TextStyle(
                            fontSize:  32,color:ColorManager.blue,
                            fontWeight: FontWeight.w800)),
                    TextSpan(
                        text:  AppStrings.mo,
                        style: TextStyle(
                          fontSize:  32,
                          fontWeight: FontWeight.w800,
                          color: ColorManager.blue,))
                  ]),
                ),
                SizedBox(height: 15,),
                MapCubic.get(context).result==true? defaultButton(shape: false,width: 180,Textcolor: ColorManager.white,background:ColorManager.blue,
                    function: () {
                      Navigator.pushReplacementNamed(context, Routes.mapScreen);
                      MapCubic.get(context).getCurrentLocation();
                      MapCubic.get(context).clearmarker();
                    },
                    text:AppStrings.start,isUpperCase: false
                ):Center(child: CircularProgressIndicator(),),

              ],) //Center
          ),);
        });

  }
}
