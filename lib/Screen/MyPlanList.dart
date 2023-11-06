import 'dart:convert';

import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/widgets/Appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../Model/PlansModel.dart';
import '../apiServices/apiConstants.dart';
import '../color.dart';
import 'PlanScreen.dart';

class MyPlanList extends StatefulWidget {
  const MyPlanList({Key? key}) : super(key: key);

  @override
  State<MyPlanList> createState() => _MyPlanListState();
}

class _MyPlanListState extends State<MyPlanList> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlanDetail();
  }
  PlansModel? plansModel;
  getPlanDetail() async {
    var headers = {
      'Cookie': 'ci_session=434027e3658c98f6bd1d5717d757ed6bb45592d4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}plans'));
    request.fields.addAll({
      'user_id': userId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = PlansModel.fromJson(jsonDecode(result));
      setState(() {
        plansModel = finalResult;
      });
      for(var i=0;i<plansModel!.data!.length;i++){
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text: "My Plan", isTrue: false),
      body:  plansModel == null  || plansModel == ""? Center(child: CircularProgressIndicator()) : plansModel!.data!.length == 0 ? Text("No Plan List Found !!"):
      RefreshIndicator(
        onRefresh:() {
          return Future.delayed(const Duration(seconds: 2), () {
            getPlanDetail();
          });
        },
        child: ListView.builder(
          itemCount: 1,
          itemBuilder:(BuildContext context, int index) {
            return Container(
              height: MediaQuery.of(context).size.height/1.4,
              width: double.infinity,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: plansModel!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return plansModel!.data![index].isPurchased == false ? SizedBox.shrink(): InkWell(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                elevation: 5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: MediaQuery.of(context).size.width/1.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("Images/plan.jpg"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child:  Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 200,),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${plansModel!.data![index].title}",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: colors.black),
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("₹ ${plansModel!.data![index].price}",style: TextStyle(color: colors.primary,fontWeight: FontWeight.bold,fontSize: 20,decoration: TextDecoration.lineThrough,
                                                decorationThickness: 2, ),),
                                              SizedBox(height: 5,),
                                              Text("₹ ${plansModel!.data![index].sellingPrice}",style: TextStyle(color: colors.primary,fontWeight: FontWeight.bold,fontSize: 20,
                                                decorationThickness: 2,),),
                                            ],
                                          ),
                                          SizedBox(height: 20,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 30),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset("Images/rightcheck.png",height: 20,width: 20,),
                                                    SizedBox(width: 10,),
                                                    Text(
                                                      "${plansModel!.data![index].planCat}",
                                                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20,color: colors.black.withOpacity(0.5)),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 100,left: 20,top: 20),
                                                  child: MySeparator(),
                                                ),
                                                SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Image.asset("Images/rightcheck.png",height: 20,width: 20,),
                                                    SizedBox(width: 10,),
                                                    Text(
                                                      "${plansModel!.data![index].subCat}",
                                                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20,color: colors.black.withOpacity(0.5)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 100,left: 20,top: 10),
                                                  child: MySeparator(),
                                                ),
                                                SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Image.asset("Images/rightcheck.png",height: 20,width: 20,),
                                                    SizedBox(width: 10,),
                                                    Text(
                                                      "${plansModel!.data![index].benifits} Contacts",
                                                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20,color: colors.black.withOpacity(0.5)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),


                            ),
                          )
                      ),
                    );
                  }),
            );
          } ,

        ),
      )
    );
  }
}
