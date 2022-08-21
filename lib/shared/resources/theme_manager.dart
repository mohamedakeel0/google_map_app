
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leafletapp/shared/resources/color_manager.dart';
import 'package:leafletapp/shared/resources/font_manager.dart';
import 'package:leafletapp/shared/resources/styles_manager.dart';
import 'package:leafletapp/shared/resources/values_manager.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
      primarySwatch: Colors.blue,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.blue,
      ),
      appBarTheme: AppBarTheme(
          titleSpacing: 20,
          backgroundColor: ColorManager.blue,
          backwardsCompatibility: false,
          elevation: 0.0,

          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor:ColorManager.blue,
              statusBarBrightness: Brightness.light),
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.black)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorManager.blue,
          unselectedItemColor: Colors.black45,
          elevation: 30),
    textTheme: TextTheme(subtitle2:getLightStyle(fontsize: FontSize.s22,color:ColorManager.white),
      headline1: getSemiBoldStyle(color:ColorManager.blue ,fontsize: FontSize.s16),subtitle1: getMediumStyle(color:ColorManager.blue  ,fontsize: FontSize.s16),
      caption: getRegularStyle(fontsize: FontSize.s14,color:ColorManager.blue),
      bodyText1: getRegularStyle(fontsize: FontSize.s16,color:ColorManager.blue ),),
    //input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // content Padding
      contentPadding: EdgeInsets.all(AppPadding.p8),
//hint Style
      hintStyle: getRegularStyle(fontsize: FontSize.s14,color:ColorManager.blue),
      //label Style
      labelStyle:getMediumStyle(fontsize: FontSize.s14,color:ColorManager.blue ),
      errorStyle: getRegularStyle(fontsize: FontSize.s14,color:ColorManager.blue ),
      //enabled Border Style
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:ColorManager.blue,width: AppSize.s1_5),borderRadius: BorderRadius.circular(AppSize.s8)),
      //focused Border Style
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:ColorManager.blue,width: AppSize.s1_5),borderRadius: BorderRadius.circular(AppSize.s8)),
      //error Border Style
      errorBorder: OutlineInputBorder(borderSide: BorderSide(color:ColorManager.blue,width: AppSize.s1_5),borderRadius: BorderRadius.circular(AppSize.s8)),
      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color:ColorManager.blue,width: AppSize.s1_5),borderRadius: BorderRadius.circular(AppSize.s8)),
    ),);
}