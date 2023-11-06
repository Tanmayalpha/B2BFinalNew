import 'dart:convert';
import 'dart:io';

import 'package:b2b/Model/GetCommunityModel.dart';
import 'package:b2b/Model/GetCountriesModel.dart';
import 'package:b2b/widgets/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert' as convert;
import '../apiServices/apiConstants.dart';
import '../apiServices/apiStrings.dart';
import '../color.dart';
import '../utils/GetPreference.dart';

class AllCommunity extends StatefulWidget {
  const AllCommunity({Key? key}) : super(key: key);

  @override
  State<AllCommunity> createState() => _AllCommunityState();
}

class _AllCommunityState extends State<AllCommunity> {
  @override
  void initState() {
    super.initState();
    getCommunity();
  }


  // GetCommunityModel? getCommunityModel;
  List commData = [];
  File? selectedImage;


  getCommunity() async {
    String? userId = await getString(key: 'id');
    Map<String, dynamic> params = {
      'user_id': '${userId}'
    };
    print("parametere ${params}");
    var response = await http.post(
        Uri.parse('${baseUrl}get_community'), body: params);
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse['error'] == false) {
      setState(() {
        commData = jsonResponse['data'];
      });
      print('get_categories_response____${commData}_________');
    }
  }


  bool isLoading = false;
  String imgTxt = "Choose Image";
  final _formKey2 = GlobalKey<FormState>();
  TextEditingController msgCtr = TextEditingController();

  File? image;

  Future<void> _showImageSourceDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                pickImage(ImageSource.gallery);
              },
              child: Text('Gallery'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                pickImage(ImageSource.camera);
              },
              child: Text('Camera'),
            ),
          ],
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
        imgTxt = selectedImage.toString();
      });
    }
  }

  _showDialog(BuildContext context) {
    showDialog(context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message Member ',
            style: TextStyle(fontSize: 15, color: colors.primary),),
          actions: [
            Container(
              // height: 500,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10.0),
                    child: Form(
                      key: _formKey2,
                      child: TextFormField(
                        controller: msgCtr,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          hintText: 'Type message here',
                          hintStyle:
                          TextStyle(color: Colors.black26),
                          prefixIcon: Icon(Icons.message_outlined),
                          prefixIconColor: Colors.black38,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'This value is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 30, right: 10.0),
                    child: InkWell(
                      onTap: () {
                        _showImageSourceDialog(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0,
                                  color: colors.black.withOpacity(0.3)),
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.image, color: Colors.black38,),
                            SizedBox(width: 10,),
                            Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                child: Text(imgTxt,
                                  style: TextStyle(color: Colors.black26,
                                  ),
                                  overflow: TextOverflow.ellipsis,)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: colors.primary),
                      onPressed: () {
                        if (msgCtr.text == "") {
                          Fluttertoast.showToast(
                              msg: "Please type the message.");
                        }
                        else if (selectedImage == null) {
                          Fluttertoast.showToast(msg: "Please choose Image");
                        } else {
                          Navigator.pop(context);
                          setState(() {
                            msgCtr.text = "";
                            imgTxt = "Choose Image";
                          });
                        }
                      },
                      child: Text('Send', style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        );
      },
    );
  }


  Future<void> deleteCommuntiyApi(String Id) async {
    setState(() {
      isLoading = true;
    });
    var param = {"id": Id};
    apiBaseHelper.postAPICall(deleteCommunity, param).then((getData) async {
      bool error = getData['error'];
      String msg = getData['message'];

      if (!error) {
        setState(() {
          isLoading = false;

        });
        await getCommunity();
        Fluttertoast.showToast(msg: msg,);
        Navigator.pop(context);
        setState(() {});
        print("responseeeeee ${getData}");
      } else {
        Fluttertoast.showToast(msg: msg);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: customAppBar(context: context, text: "Community", isTrue: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
        commData == null ? Center(child: CircularProgressIndicator()):commData.length == 0? Center(child: Text("No Community List")):
             RefreshIndicator(
          onRefresh:() {
            return Future.delayed(const Duration(seconds: 2), () {
              getCommunity();
            });
          },
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: commData.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commData[index]['image'] == null ||
                            commData[index]['image'] == "" ? Text("--") :
                        Container(
                          height: 55,
                          width: 55,
                          // color: Colors.green,
                          child: Image.network(
                            "${commData[index]['image']}", height: 80,
                            width: 80,
                            fit: BoxFit.cover,),
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 23,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${commData[index]['name']}",
                                style: const TextStyle(
                                    fontSize: 12,
                                    //  color: colors.blacktextColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 150,
                              ),
                              Text(
                                "${commData[index]['mobile']}",
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 150,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 12,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: colors.primary
                              ),
                              child: InkWell(
                                  onTap: () {
                                    _dialogBuilder(context,commData[index]['id']);
                                  },
                                  child: Icon(Icons.delete)),
                            ),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 30,
                            ),
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: colors.primary
                              ),
                              child: InkWell(
                                  onTap: () {
                                    _showDialog(context);
                                  },
                                  child: Icon(Icons.message_sharp)),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 50,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(onPressed: () {
        _showDialog(context);
      }, label: Text("Send Message to All"),
        backgroundColor: colors.primary,
        icon: Icon(Icons.message),
      ),
    );
  }

  // Widget getCommunityView() {
  //   return
  //     commData == null ? Center(child: CircularProgressIndicator()):commData.length == 0? Center(child: Text("No Community List")):
  //   RefreshIndicator(
  //     onRefresh:() {
  //       return Future.delayed(const Duration(seconds: 2), () {
  //         getCommunity();
  //       });
  //     },
  //     child: ListView.builder(
  //         scrollDirection: Axis.vertical,
  //         shrinkWrap: true,
  //         physics: NeverScrollableScrollPhysics(),
  //         itemCount: commData.length,
  //         itemBuilder: (context, index) {
  //           return Card(
  //             elevation: 4,
  //             child: Container(
  //               color: Colors.white,
  //               padding: const EdgeInsets.all(14.0),
  //               child: Row(
  //                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   commData[index]['image'] == null ||
  //                       commData[index]['image'] == "" ? Text("--") :
  //                   Container(
  //                     height: 55,
  //                     width: 55,
  //                     // color: Colors.green,
  //                     child: Image.network(
  //                       "${commData[index]['image']}", height: 80,
  //                       width: 80,
  //                       fit: BoxFit.cover,),
  //                   ),
  //                   SizedBox(
  //                     width: MediaQuery
  //                         .of(context)
  //                         .size
  //                         .width / 23,
  //                   ),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "${commData[index]['name']}",
  //                           style: const TextStyle(
  //                               fontSize: 12,
  //                               //  color: colors.blacktextColor,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                         SizedBox(
  //                           height: MediaQuery
  //                               .of(context)
  //                               .size
  //                               .height / 150,
  //                         ),
  //                         Text(
  //                           "${commData[index]['mobile']}",
  //                           style: TextStyle(fontSize: 12, color: Colors.grey),
  //                         ),
  //                         SizedBox(
  //                           height: MediaQuery
  //                               .of(context)
  //                               .size
  //                               .height / 150,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: MediaQuery
  //                         .of(context)
  //                         .size
  //                         .width / 12,
  //                   ),
  //                   Row(
  //                     children: [
  //                       Container(
  //                         height: 35,
  //                         width: 35,
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(6),
  //                             color: colors.primary
  //                         ),
  //                         child: InkWell(
  //                             onTap: () {
  //                               _dialogBuilder(context,commData[index]['id']);
  //                             },
  //                             child: Icon(Icons.delete)),
  //                       ),
  //                       SizedBox(
  //                         width: MediaQuery
  //                             .of(context)
  //                             .size
  //                             .width / 30,
  //                       ),
  //                       Container(
  //                         height: 35,
  //                         width: 35,
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(6),
  //                             color: colors.primary
  //                         ),
  //                         child: InkWell(
  //                             onTap: () {
  //                               _showDialog(context);
  //                             },
  //                             child: Icon(Icons.message_sharp)),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     width: MediaQuery
  //                         .of(context)
  //                         .size
  //                         .width / 50,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         }),
  //   );
  // }

  Future<void> _dialogBuilder(BuildContext context,String Id) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Community'),
          content: const Text(
            'Are you sure want to delete'
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme
                    .of(context)
                    .textTheme
                    .labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () {
                print('__________surendra_________');
                deleteCommuntiyApi(Id);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme
                    .of(context)
                    .textTheme
                    .labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}