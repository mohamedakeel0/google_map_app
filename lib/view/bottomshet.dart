import 'package:flutter/material.dart';
import 'package:leafletapp/model/categories.dart';
import 'package:leafletapp/shared/components/components.dart';
import 'package:leafletapp/shared/resources/assets_manager.dart';
import 'package:leafletapp/shared/resources/color_manager.dart';
import 'package:leafletapp/shared/resources/constants_manager.dart';
import 'package:leafletapp/shared/resources/string_manager.dart';
import 'package:leafletapp/view/map_screen.dart';

class bottomsheet extends StatefulWidget {
  const bottomsheet({Key? key}) : super(key: key);

  @override
  _bottomsheetState createState() => _bottomsheetState();
}

class _bottomsheetState extends State<bottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FlatButton(
            child: Text('Show bottom'),
            onPressed: () async {
              showModalBottomSheet(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                )),
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
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
                                    borderRadius:
                                        new BorderRadius.circular(20)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25.0, left: 8),
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
                            padding: const EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
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
                                    SizedBox(width: 5,),
                                    Text('4,1'),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('يغلق عند الساعة 2 ص'),

                                    SizedBox(width: 5,),
                                    Text('مفتوح',style: TextStyle(color: Colors.green),),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('35 د'),
                                    SizedBox(width: 5,),
                                    Icon(Icons.drive_eta),
                                    SizedBox(width: 5,),
                                    Text('مطعم وجبات سريعه'),
                                  ],
                                ),
                                SizedBox(height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: ListView.separated(  physics: BouncingScrollPhysics(), scrollDirection: Axis.horizontal,itemBuilder:(context, index) =>   Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: defaultButton(icon: true,
                                          shape: true,
                                          width: 170,icons:detailscategoriesList[index].icon,
                                          Textcolor: ColorManager.blue,
                                          background: ColorManager.white,
                                          function: () {

                                          },
                                          text: detailscategoriesList[index].title,
                                          isUpperCase: false),
                                    ),itemCount:detailscategoriesList.length ,separatorBuilder:(context, index) => SizedBox(width: 5,) ,

                                    ),
                                  ),
                                ),
                                SizedBox(height: 130,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.separated( physics: BouncingScrollPhysics(), scrollDirection: Axis.horizontal,itemBuilder: (context, index) {
                                      return Container(width: 130,decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(ImageAssets.images),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                          new BorderRadius.circular(20)),);
                                    }, separatorBuilder: (context, index) => SizedBox(width: 5,), itemCount: 10),
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
            },
          ),
        ),
        color: Colors.white,
      ),
    );
  }

}
