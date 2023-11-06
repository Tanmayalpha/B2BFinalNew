import 'dart:convert';

import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/Screen/Media.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../color.dart';
import '../utils/GetPreference.dart';
import '../widgets/Appbar.dart';
import '../widgets/appButton.dart';
import 'Add_Product.dart';
import 'package:http/http.dart'as http;

class CommunityScreen extends StatefulWidget {
  final String? image;
  bool? fromMedia;
  CommunityScreen({Key? key, this.image, this.fromMedia}) : super(key: key);
  String? productImageUrl ;
  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {

  TextEditingController nameC =  TextEditingController();
  TextEditingController mobileC =  TextEditingController();
  TextEditingController cityC =  TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isloader =  false;
  //String? productImageUrl ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(text: "Add Community",isTrue: false, context: context),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                width: double.infinity,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(6)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Theme(
                      data: new ThemeData(
                        primaryColor: Colors.red,
                        primaryColorDark: Colors.black,
                      ),
                      child: Container(
                        child: TextFormField(
                          controller: nameC,
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(top: 5,left: 5),
                            hintText: "Name",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),

                          ),
                          validator: (val) {
                            if (val?.length == 0) {
                              return "Name cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.name,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Theme(
                      data: new ThemeData(
                        primaryColor: Colors.red,
                        primaryColorDark: Colors.black,
                      ),
                      child: Container(
                        child: TextFormField(
                          maxLength: 10,
                          controller: mobileC,
                          decoration: new InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.only(top: 5,left: 5),
                            hintText: "Mobile",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),

                          ),
                          validator: (val) {
                            if (val?.length == 0) {
                              return "Mobile cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Theme(
                      data: new ThemeData(
                        primaryColor: Colors.red,
                        primaryColorDark: Colors.black,
                      ),
                      child: Container(
                        child:

                        TextFormField(
                          controller: cityC,
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(top: 5,left: 5),
                            hintText: "City",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),

                          ),
                          validator: (val) {
                            if (val?.length == 0) {
                              return "City cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.name,
                        ),

                      ),
                    ),

                    const SizedBox(height: 20),

                    InkWell(
                      onTap: () async {
                        // showExitPopup1();
                        var  result =
                        await Navigator.push(context, MaterialPageRoute(builder: (context)=>Media(from: 'main',)));
                        if(result != null){
                          setState(() {
                            productImageUrl1 = result;
                            print("==================${productImageUrl1}");
                          });
                        }
                      },
                      child:Container(
                        width: 100,

                        decoration: BoxDecoration(
                            color: colors.primary,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        height: productImageUrl1 == null ? 50:100,
                        child: productImageUrl1 == null || productImageUrl1 == ""
                            ? const Center(
                            child: Text("Upload Image ",style: TextStyle(color: colors.white),))
                            : Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                productImageUrl1!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Btn(
                        height: 50,
                        width: 150,
                        title: isloader ? "Please wait......" :"Add Community",
                        onPress: (){
                         // addCommuntiy();
                          if(_formKey.currentState!.validate()) {
                            addCommuntiy();
                          }else{
                            // setState(() {
                            //   isloader = false;
                            // });
                            Fluttertoast.showToast(
                                msg:
                                "all field are Required!!");
                          }

                        },),
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  addCommuntiy() async {
    setState(() {
      isloader = true;
    });

    var headers = {
      'Cookie': 'ci_session=65472b3971537438cebb84c312160277678e379e'
    };
    String? userId = await getString(key: 'id');
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}add_community'));
    request.fields.addAll({
      'name': nameC.text,
      'mobile': mobileC.text,
      'city': cityC.text,
      'user_id': userId.toString()
    });
    print('____cxczcxz______${request.fields}_________');
    //request.files.add(await http.MultipartFile.fromPath('brand_input_image', productImageUrl1 ?? ''));
    // if(productImageUrl1 != null){
    //
    // }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
    var  result = await response.stream.bytesToString();
    var finalResult = jsonDecode(result);
   Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BHome()));
    Fluttertoast.showToast(msg: "${finalResult['message']}");
    nameC.clear();
    mobileC.clear();
    cityC.clear();
    setState(() {
      isloader = false;
    });
    }
    else {
      setState(() {
        isloader = false;
      });
    print(response.reasonPhrase);
    }

  }
  // addCommuntiy() async {
  //   setState(() {
  //     isloader = true;
  //   });
  //   String? userId = await getString(key: 'id');
  //   var headers = {
  //     'Cookie': 'ci_session=6aefb97711103d7411ea9d141f9ed7f2ae06c087'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}add_community'));
  //   request.fields.addAll({
  //     'name': nameC.text,
  //     'mobile': mobileC.text,
  //     'city': cityC.text,
  //     'brand_input_image':"${productImageUrl1}",
  //     'user_id': userId.toString()
  //   });
  //   print('_____xcvcvc_____${request.fields}_________');
  //
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var result = await response.stream.bytesToString();
  //     var finalResult =  jsonDecode(result);
  //     productImageUrl1 == null;
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BHome()));
  //     Fluttertoast.showToast(msg: "${finalResult['message']}");
  //     setState(() {
  //       isloader = false;
  //     });
  //   }
  //   else {
  //     setState(() {
  //       isloader = false;
  //     });
  //     print(response.reasonPhrase);
  //   }
  //
  // }
}
