
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';
class getAppbar extends StatelessWidget {
  final VoidCallback? onTaped;
  final SizedBox? sizedBox;
  String? text;
  bool? istrue;


  getAppbar({this.onTaped, this.text, this.sizedBox,this.istrue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height /10,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.primary,
                  colors.primary,
                ],
                stops: [
                  0,
                  1,
                ]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: istrue?? false ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:colors.white.withOpacity(0.4)
                      ),
                      child: Icon(Icons.arrow_back,color: colors.white,),
                    ),
                  ):SizedBox()
              ),

              Text('${text}',style: TextStyle(color: Colors.white,fontSize: 20),),

              // Icon(Icons.chat_rounded,color: Colors.white,),

              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.white.withOpacity(0.4)
                    ),
                    child: Icon(Icons.notifications_none,color: colors.white,),
                  ),
                ),
              ),
            ],
          ),

        ),
      ],
    );
  }
}

AppBar customAppBar(
    {
      required BuildContext context,
      VoidCallback? onTaped,
      required String text,
      required bool isTrue,

    }){
  return AppBar(
    elevation: 0,
   // backgroundColor: colors.white,
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(1),bottomLeft: Radius.circular(1)),
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            colors: [
             colors.primary,
              colors.primary,
            ],
            stops: [
              0,
              1,
            ]),
      ),
    ),
    leading: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child:  Padding(padding: const EdgeInsets.only(right: 10), child: Icon(Icons.arrow_back_ios_new_outlined,color: colors.white,))
    ),
    title: Text('${text}',style: TextStyle(color: Colors.white,fontSize: 20),),
    actions: [
    ],

  );
}