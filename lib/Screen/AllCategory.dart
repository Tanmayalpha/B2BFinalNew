import 'dart:convert';

// import 'package:anoop/Model/GetHomeCategoryModel.dart';
import 'package:b2b/widgets/appButton.dart';
import 'package:b2b/widgets/categoryCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/GetHomeCategoryModel.dart';
import '../apiServices/apiConstants.dart';
import '../color.dart';

class HomeFullCategory extends StatefulWidget {
  const HomeFullCategory({Key? key}) : super(key: key);
  @override
  State<HomeFullCategory> createState() => _HomeFullCategoryState();
}
class _HomeFullCategoryState extends State<HomeFullCategory> {
  @override
  void initState() {
    homeCategories();
    // TODO: implement initState
    super.initState();
  }
  String? userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
          title: const Text("All Category"), backgroundColor: colors.primary),
      body: homeCategory?.data == null ? const Center(child: CircularProgressIndicator(color: colors.primary,),) : SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: homeCategory?.data?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                return categoryCard(context,homeCategory?.data?[index].image ?? '', homeCategory?.data?[index].name ?? '' );
              }),

        ),
      ),
    );
  }
  GetHomeCategoryModel? homeCategory;

  homeCategories()async{
    var headers = {
      'Cookie': 'ci_session=a0c4a8147cd6ca589ca5ea95dd55a72e8678d0d2'
    };
    var request = http.MultipartRequest('POST', Uri.parse('Https://b2bdiary.com/App/V1/Api/get_home_categories'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetHomeCategoryModel.fromJson(json.decode(finalResponse));
      homeCategory = jsonResponse;
      print(homeCategory!.data!.first.name);
      setState(() {
        homeCategory = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
  TextEditingController pinCodeController = new TextEditingController();
  final _Cotact = GlobalKey<FormState>();
  TextEditingController yournamecontroller =TextEditingController();
  TextEditingController yourMobileNumber =TextEditingController();
  TextEditingController YourcityController=TextEditingController();
  bool verifie=false;
  String? controller;
  String? OTPIS;
  sendOtpCotactSuplier(String ProductId) async {
    var headers = {
      'Cookie': 'ci_session=aa35b4867a14620a4c973d897c5ae4ec6c25ee8e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}send_otp_for_enquiry'));

    if(userId==null||userId==''||userId=='null') {
      request.fields.addAll({
        'mobile': yourMobileNumber.text.toString(),
        'city': YourcityController.text.toString(),
        'name': yournamecontroller.text.toString(),

      });
    }
    else {
      request.fields.addAll({
        'mobile': yourMobileNumber.text.toString(),
      });

    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult =jsonDecode(result);
      if(finalresult['error']==false)
      {
        setState(() {
          verifie=true;
          OTPIS=finalresult['data']['otp'].toString();
        });
        Navigator.pop(context);
        showDialogverifyContactSuplier(ProductId);
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }
  void showDialogContactSuplier(String productId) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: userId  =="null" ? 400 :250,
                width: MediaQuery.of(context).size.width/1.2,
                // width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Form(
                    key: _Cotact,
                    child:
                    Column(
                      children: [
                        Container(
                          color: colors.primary,
                          height: 60,child: Row(
                          children: [
                            SizedBox(width: 20,),
                            Text('Contact Supplier',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        ),
                        userId!='null'?
                        Column(children: [
                          SizedBox(height: 10,),

                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: TextFormField(
                              maxLength: 10,
                              controller: yourMobileNumber,
                              decoration: new InputDecoration(
                                contentPadding: EdgeInsets.only(top: 5,left: 5),
                                hintText: "Your Mobile",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(),
                                ),

                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Mobile Number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                            ),
                          ),


                        ],)



                            :

                        Column(children: [


                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: TextFormField(
                              controller: yournamecontroller,
                              decoration: new InputDecoration(
                                contentPadding: EdgeInsets.only(top: 5,left: 5),
                                hintText: "Your Name",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(),
                                ),

                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Name';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: TextFormField(
                              maxLength: 10,
                              controller: yourMobileNumber,
                              decoration: new InputDecoration(
                                contentPadding: EdgeInsets.only(top: 5,left: 5),
                                hintText: "Your Mobile",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(),
                                ),

                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Mobile Number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: TextFormField(
                              controller: YourcityController,
                              decoration: new InputDecoration(
                                contentPadding: EdgeInsets.only(top: 5,left: 5),
                                hintText: "Your City",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(),
                                ),

                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter City';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                            ),
                          ),

                        ],),


                        SizedBox(height: 10,),




                        InkWell(

                          onTap: () {

                            if(_Cotact.currentState!.validate()) {
                              sendOtpCotactSuplier(

                                  productId

                              );

                            }

                          },
                          child: Row(
                            children: [
                              SizedBox(width: 15,),
                              Container(

                                color: colors.primary,
                                width: 100,
                                height: 40,child:




                              Center(child: Text('Send Otp',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),)),
                              ),
                            ],
                          ),
                        ),



                      ],
                    ),
                  ),
                ),
              ),

            );
          });
        });
  }
  void showDialogverifyContactSuplier(String productIddd) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: 350,
                width: MediaQuery.of(context).size.width/1.5,
                // width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Container(
                        color: colors.primary,
                        height: 60,child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Text('Contact Supplier',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),),

                      Column(
                        children: [
                          SizedBox(height:
                          20,),

                          Text('OTP : ${OTPIS}',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),

                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: OtpTextField(
                              numberOfFields: 4,
                              fieldWidth: 20,
                              borderColor: Colors.red,
                              focusedBorderColor: Colors.blue,
                              showFieldAsBox: false,
                              borderWidth: 1,
                              //runs when a code is typed in
                              onCodeChanged: (String code) {
                                print(code);
                                // pinCodeController.text=code;
                                //  controller=code;
                                //handle validation or checks here if necessary
                              },
                              //runs when every textfield is filled
                              onSubmit: (String verificationCode) {
                                controller = verificationCode;
                              },),
                          ),

                          SizedBox(height: 30,),
                        ],
                      ),
                      Btn(
                        height: 45,
                        width: 250,
                        title: "Verify Otp",
                        onPress: () {
                          if(controller==OTPIS){
                            sendEnqury(productIddd);
                          }
                          else{
                            Fluttertoast.showToast(msg: 'Enter Correct OTP');
                          }
                        },
                      )

                      // InkWell(
                      //
                      //   onTap: () {
                      //
                      //   },
                      //   child:
                      //   Container(
                      //     color: colors.primary,
                      //     width: 100,
                      //     height: 40,child:
                      //   Center(child: Text('Verify Otp',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),)),
                      //   ),
                      //
                      // )




                    ],
                  ),
                ),
              ),

            );
          });
        });
  }
  Future<void> sendEnqury(String productid) async {
    var headers = {
      'Cookie': 'ci_session=ff1e2af38a215d1057b062b8ff903fc27b0c488b'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}save_inquiry'));

    if(userId==null||userId==''||userId=='null') {
      request.fields.addAll({
        'name': yournamecontroller.text.toString(),
        'mobile': yourMobileNumber.text.toString(),
        'city': YourcityController.text.toString(),
        'product_id': productid.toString()
      });
    }
    else{

      request.fields.addAll({
        'mobile': yourMobileNumber.text.toString(),
        'product_id': productid.toString(),
        'user_id':userId.toString(),
      });
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {


      var result = await response.stream.bytesToString();

      var finalResult=jsonDecode(result);
      if(finalResult['status']==true){

        Fluttertoast.showToast(msg: finalResult['message']);
        Navigator.pop(context);

      }
      else
      {
        Fluttertoast.showToast(msg: finalResult['message']);


      }

    }
    else {
      print(response.reasonPhrase);
    }

  }
}
