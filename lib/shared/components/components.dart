import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:leafletapp/bloc/cubic.dart';
import 'package:leafletapp/model/categories.dart';
import 'package:leafletapp/model/modelcategories.dart';
import 'package:leafletapp/shared/resources/assets_manager.dart';
import 'package:leafletapp/shared/resources/color_manager.dart';
import 'package:leafletapp/shared/resources/routes_manager.dart';
import 'package:leafletapp/shared/resources/string_manager.dart';
import 'package:leafletapp/shared/resources/values_manager.dart';

import 'package:leafletapp/view/map_screen.dart';
import 'package:url_launcher/url_launcher.dart';

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  EdgeInsetsGeometry? contentPadding,
  TextStyle? textStyle,
  TextStyle? labelStyle,
  InputBorder? enabledBorder,
  bool isPassword = false,
  ValueChanged? change,
  VoidCallback? suffixPressed,
  required FormFieldValidator validate,
  String? label,
  IconData? prefix,
  String? hintText,
  OutlineInputBorder? myfocusborder,
  ValueChanged? onSubmit,
  IconData? suffix,
  bool isClickable = true,
  GestureTapCallback? TapWhenClick,
}) =>
    TextFormField(
      onTap: TapWhenClick,
      controller: controller,
      style: textStyle,
      keyboardType: type,
      obscureText: isPassword,
      validator: validate,
      enabled: isClickable,
      onChanged: change,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: enabledBorder,
        labelText: label,
        labelStyle: labelStyle,
        focusedBorder: myfocusborder,
        contentPadding: contentPadding,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

Widget builditemCategories(context,ItemDetail) => Container(
  width: 250,
  height: 120,
  decoration: BoxDecoration(
    borderRadius: new BorderRadius.circular(20),
    color: Colors.white,
  ),
  child:   InkWell(
        onTap: () async {
          buildbottomsheet(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageAssets.images), fit: BoxFit.cover),
                    borderRadius: new BorderRadius.circular(20)),
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ItemDetail['name'], maxLines: 3,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    height: 20,

                    child: AutoSizeText(
                      ItemDetail['address'],

                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row( mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(child: Icon(Icons.call),onTap: ()async{

                            final String phoneUrl = 'tel: ${ItemDetail['phone']}';
                            if (await canLaunch(phoneUrl)) {
                              await launch(phoneUrl);
                            } else {
                            throw 'Could not launch $phoneUrl';
                          }

                        },),
                        SizedBox(width: 10,),
                        InkWell(child: Icon(Icons.add_location_outlined),onTap: (){
                          MapUtils.openMap(double.parse(ItemDetail['lat']), double.parse(ItemDetail['long']));
                        },),
                    Spacer(),
                    ItemDetail['rate']>0?Icon(Icons.star,size: 15,color: Colors.yellow,):Icon(Icons.star_border_purple500_sharp,size: 15,),
                 ItemDetail['rate']>1?Icon(Icons.star,size: 15,color: Colors.yellow,):Icon(Icons.star_border_purple500_sharp,size: 15,),
                 ItemDetail['rate']>2?Icon(Icons.star,size: 15,color: Colors.yellow,):Icon(Icons.star_border_purple500_sharp,size: 15,),
                 ItemDetail['rate']>3?Icon(Icons.star,size: 15,color: Colors.yellow,):Icon(Icons.star_border_purple500_sharp,size: 15,),
                        ItemDetail['rate']>4?Icon(Icons.star,size: 15,color: Colors.yellow,):Icon(Icons.star_border_purple500_sharp,size: 15,),


                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
);

Future buildbottomsheet(context) => showModalBottomSheet(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Container(
                      height: 320,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImageAssets.images),
                              fit: BoxFit.cover),
                          borderRadius: new BorderRadius.circular(20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, left: 8),
                      child: InkWell(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Dhoom',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.star_border_purple500_sharp),
                          Icon(Icons.star_border_purple500_sharp),
                          Icon(Icons.star_border_purple500_sharp),
                          Icon(Icons.star_border_purple500_sharp),
                          Icon(Icons.star_border_purple500_sharp),
                          SizedBox(
                            width: 5,
                          ),
                          Text('4,1'),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('يغلق عند الساعة 2 ص'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'مفتوح',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('35 د'),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.drive_eta),
                          SizedBox(
                            width: 5,
                          ),
                          Text('مطعم وجبات سريعه'),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: defaultButton(
                                  icon: true,
                                  shape: true,
                                  width: 170,
                                  icons: detailscategoriesList[index].icon,
                                  Textcolor: ColorManager.blue,
                                  background: ColorManager.white,
                                  function: () {

                                  },
                                  text: detailscategoriesList[index].title,
                                  isUpperCase: false),
                            ),
                            itemCount: detailscategoriesList.length,
                            separatorBuilder: (context, index) => SizedBox(
                              width: 5,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 130,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 130,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(ImageAssets.images),
                                          fit: BoxFit.cover),
                                      borderRadius:
                                          new BorderRadius.circular(20)),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 5,
                                  ),
                              itemCount: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

buildappbar(searchController)=>AppBar(
  title: Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(32.0)),
    child: defaultFormField(
        controller: searchController,
        type: TextInputType.text,
        suffix: Icons.cancel,
        label: AppStrings.labelSearch,
        prefix: Icons.location_on,
        validate: (value) {}),
  ),
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.orangeAccent,
  Color Textcolor = Colors.white,
  dynamic? Iconcolor,
  bool isUpperCase = true,
  double radius = 3.0,
  bool shape = true,
  bool checkwidth = true,
  dynamic icons = Icons.shopping_cart_outlined,
  bool icon = false,
  required VoidCallback? function,
  required String text,
}) =>
    checkwidth
        ? Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            width: width,
            height: 50.0,
            child: MaterialButton(
                onPressed: function,
                child: icon
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(icons, color: Iconcolor),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            isUpperCase ? text.toUpperCase() : text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Textcolor,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          isUpperCase ? text.toUpperCase() : text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Textcolor,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      )),
            decoration: shape
                ? ShapeDecoration(
                    shape: StadiumBorder(
                      side: BorderSide(
                        width: 2,
                        color: Colors.black12,
                      ),
                    ),
                  )
                : ShapeDecoration(
                    color: background,
                    shape: StadiumBorder(
                      side: BorderSide(
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
          )
        : Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: 50.0,
            child: MaterialButton(
                onPressed: function,
                child: icon
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Icon(icons, color: Iconcolor),
                            onTap: () {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            isUpperCase ? text.toUpperCase() : text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Textcolor,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          isUpperCase ? text.toUpperCase() : text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Textcolor,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      )),
            decoration: shape
                ? ShapeDecoration(
                    shape: StadiumBorder(
                      side: BorderSide(
                        width: 2,
                        color: Colors.black12,
                      ),
                    ),
                  )
                : ShapeDecoration(
                    color: background,
                    shape: StadiumBorder(
                      side: BorderSide(
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
          );

void ShowToast({required String text, required Toaststates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);
enum Toaststates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(Toaststates state) {
  Color color;
  switch (state) {
    case Toaststates.SUCCESS:
      color = Colors.orangeAccent;
      break;
    case Toaststates.ERROR:
      color = Colors.red;
      break;
    case Toaststates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

buildItemlistCategoriesBottom(context,ItemDetaillengh) =>   Padding(
  padding: const EdgeInsets.only(top: 500),
  child: SizedBox( height: 220,
    child: ListView.separated(itemBuilder: (context, index) {
      return builditemCategories(context, MapCubic.get(context).ItemDetail![index]);
    }, separatorBuilder: (context, index) => SizedBox(width: 5,), itemCount: ItemDetaillengh,  physics:const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,),
  ),
);
buildItemlistCategoriesTop(ckeckbutton,categories,latitude,longitude)=>  SizedBox(
  height: 60,
  child: Padding(
    padding:  ckeckbutton==true ? const EdgeInsets.only(left:AppPadding.p8):const EdgeInsets.only(left: AppPadding.p50),
    child: ListView.separated(
      physics:const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => InkWell(
        onTap: () {


        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:ckeckbutton==true&&categories!=null? buildbutton(context, categories![index],latitude,longitude):buildbutton(context, categories![index],latitude,longitude),),
      ),
      itemCount: ckeckbutton==true &&categories!=null?categories!.length:categories!.length,
      separatorBuilder: (context, index) =>const SizedBox(
        width: 5,
      ),
    ),
  ),
);
buildbutton(context, categories,latitude,longitude) => defaultButton(
    icon: true,
    shape: false,
    checkwidth: false,
    width: 170,
    icons: IconDataSolid(int.parse(categories['icon_name'])),
    Textcolor: ColorManager.blue,
    Iconcolor:HexColor(categories['color']),
    background: Colors.white,
    function: () {

      MapCubic.get(context)
          .getItemcategories(categories['id'],latitude,longitude);
      MapCubic.get(context).getCategories(categories['id']);

      if(MapCubic.get(context).buttontrue==true) MapCubic.get(context)
          .getItemDetail(categories['id']);
      MapCubic.get(context).buttonCkeck(false);

      MapsScreen();
    },
    text: categories['name'],
    isUpperCase: false);

