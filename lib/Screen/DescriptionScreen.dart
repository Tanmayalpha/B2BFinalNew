import 'dart:convert';

import 'package:b2b/Api.path.dart';
import 'package:b2b/Screen/myProfile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/GetCountriesModel.dart';
import '../Model/GetHomeProductsModel.dart';
import '../color.dart';

class KitchenDescription extends StatefulWidget {
  ProductData? model;
  KitchenDescription({Key? key, this.model}) : super(key: key);
  @override
  State<KitchenDescription> createState() => _KitchenDescriptionState();
}
class _KitchenDescriptionState extends State<KitchenDescription> {
  TextEditingController mobileCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print("mobileee ${mobileCtr.text}");
  }

  contactSupplier() async{
  final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  var sessionId= sharedPreferences.getString('id');
  var headers = {
    'Cookie': 'ci_session=59768579a25a8d7d27f2e76e34f86504416d4809'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${ApiService.saveInquiry}'));
  request.fields.addAll({
    'user_id': '${sessionId}',
    'product_id': "${widget.model!.id.toString()}",
    'mobile': '${mobileCtr.text}'
  });
  print("contact supplier paraa ${request.fields}");
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("working here");
    var result = await response.stream.bytesToString();
    var finalResult  = jsonDecode(result);
    Fluttertoast.showToast(msg: "${finalResult['message']}");
    Navigator.pop(context);
    setState(() {
      mobileCtr.clear();
    });
  }
  else {
    print(response.reasonPhrase);
  }
}

 _showDialog(BuildContext context) {
  showDialog(context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Text('Contact ',style: TextStyle(fontSize: 22,color: colors.primary),),
            Text('Supplier ',style: TextStyle(fontSize: 22,),),
            SizedBox(width: 40,),
            InkWell(onTap: (){
              Navigator.of(context).pop();
            },
                child: Icon(Icons.close,size: 16,)),
          ],
        ),
        content: Text('Enter Mobile Number',style: TextStyle(fontWeight: FontWeight.w500),),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right:68.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: mobileCtr,
                //  controller: mobileController,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,

                // maxLength: 10,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.black26),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.black26),
                  ),
                  hintText: 'Mobile Number',
                  hintStyle:
                  TextStyle(color: Colors.black26),
                  prefixIcon: Icon(Icons.phone),
                  prefixIconColor: Colors.black38,
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.length<10) {
                    return 'This value is required';
                  }
                  return null;
                },
              ),
            ),
          ),
          ElevatedButton(style: ElevatedButton.styleFrom(primary: colors.primary),
            onPressed: () {
            if(mobileCtr.text == "" ||mobileCtr.text == null || mobileCtr.text.length > 10){
              Fluttertoast.showToast(msg: "Please enter Valid mobile no.");
            }
           else{
             contactSupplier();
            }
              // Perform action when "Cancel" is pressed
             // Navigator.of(context).pop();
            },
            child: Text('Contact Supplier',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          ),
          // TextButton(
          //   onPressed: () {
          //     // Perform action when "OK" is pressed
          //     // Add your logic here for the button action
          //     Navigator.of(context).pop();
          //   },
          // child: Text('OK'),
          //  ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.red[300] ,
        title:Text("Product Detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              child: Image.network(widget!.model!.image.toString(),
                fit: BoxFit.contain,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Container(
                  height: 70,
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox( height:10),
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(widget!.model!.name.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),),
                      ),
                      // SizedBox( height:6),
                      // Container(
                      //   margin: EdgeInsets.only(left: 15),
                      //   alignment: Alignment.centerLeft,
                      //   child:Row(
                      //     children: [
                      //       Icon(Icons.currency_rupee_rounded,size: 15,
                      //         weight:800,
                      //         color: Colors.black,),
                      //       Text(widget!.model!.variants![index].price.toString(),
                      //         style: TextStyle(fontWeight: FontWeight.bold,
                      //           fontSize: 15,
                      //         ),),
                      //     ],
                      //   ),
                      // ),
                      SizedBox( height:6),
                      Container(
                        margin: EdgeInsets.only(left: 19),
                        alignment: Alignment.centerLeft,
                        child: Text("From: ${widget!.model!.address.toString()}",
                          style: TextStyle(fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),),
                      ),
                      // SizedBox( height:10),
                      // Center(
                      //   // alignment: Alignment.centerLeft,
                      //   // margin: EdgeInsets.only(left: 30),
                      //   child: Row(
                      //     children: [
                      //       SizedBox( width:21),
                      //       ElevatedButton(
                      //         onPressed: () {},
                      //         child: Row(
                      //           children: [
                      //             Icon(Icons.chat_outlined,size: 15,
                      //                 weight:800,
                      //                 color:  Color(0xffE57373)),
                      //             SizedBox( width:6),
                      //             Text("Message Us", style:TextStyle(fontSize: 14,
                      //                 color:  Color(0xffE57373))),
                      //           ],
                      //         ),
                      //         style: ElevatedButton.styleFrom(
                      //           backgroundColor: Colors.white,
                      //           side: const BorderSide(
                      //             width: 1.5,
                      //             color: Color(0xffE57373),
                      //           ),
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.only(topLeft:Radius.circular(30),bottomLeft:Radius.circular(30)),
                      //           ),),
                      //       ),
                      //       SizedBox( width:6),
                      //       ElevatedButton(
                      //         onPressed: () {},
                      //         child: Row(
                      //           children: [
                      //             Icon(Icons.call,size: 15,
                      //               weight:800,
                      //               color: Colors.white,),
                      //             SizedBox( width:6),
                      //             Text("Call Us", style:TextStyle(fontSize: 16,)),
                      //             SizedBox( width:40),
                      //           ],
                      //         ),
                      //         style: ElevatedButton.styleFrom(
                      //             backgroundColor: Colors.red[300],
                      //             shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight:Radius.circular(30))
                      //             )),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromRGBO(118, 120, 122, 0.5),
                    width: 1.0,
                  ),
                  bottom: BorderSide(
                    color: Color.fromRGBO(118, 120, 122, 0.5),
                    width: 1.0,
                  ),
                ),
              ),
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromRGBO(118, 120, 122, 0.3),
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 21.0),
                    child: Text(
                      'Product Description',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: DataTable(
                dividerThickness: 0,
                columnSpacing:50 ,
                headingRowHeight: 0,
                columns: const [
                  DataColumn(
                    label: Text(''),
                  ),
                  DataColumn(
                      label: Text('')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Product Name',
                      style: TextStyle(fontWeight: FontWeight.normal,
                          color:Colors.grey.shade600,
                          fontSize:12),)),
                    DataCell(Text(widget!.model!.name.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold,
                          color:Colors.black,
                          fontSize:12),)),
                  ]),
                  DataRow(
                      color: MaterialStateProperty.all(Color.fromRGBO(118, 120, 122, 0.1),),
                      cells: [
                        DataCell(Text('Material',
                          style: TextStyle(fontWeight: FontWeight.normal,
                              color:Colors.grey.shade600,
                              fontSize:12),)),
                        DataCell(Text('${widget!.model!.categoryName}',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color:Colors.black,
                              fontSize:12),)),
                      ]),
                  // DataRow(cells: [
                  //   DataCell(Text('Color',
                  //     style: TextStyle(fontWeight: FontWeight.normal,
                  //         color:Colors.grey.shade600,
                  //         fontSize:14),)),
                  //   DataCell(Text('Multi',
                  //     style: TextStyle(fontWeight: FontWeight.bold,
                  //         color:Colors.black,
                  //         fontSize:14),)),
                  // ]),
                  // DataRow(
                  //     color: MaterialStateProperty.all(Color.fromRGBO(118, 120, 122, 0.1),),
                  //     cells: [
                  //       DataCell(Text('Usage/Aplication',
                  //         style: TextStyle(fontWeight: FontWeight.normal,
                  //             color:Colors.grey.shade600,
                  //             fontSize:14),)),
                  //       DataCell(Text('Kitchen',
                  //         style: TextStyle(fontWeight: FontWeight.bold,
                  //             color:Colors.black,
                  //             fontSize:14),)),
                  //     ]),
                  // DataRow(cells: [
                  //   DataCell(Text('Country of Origin',
                  //     style: TextStyle(fontWeight: FontWeight.normal,
                  //         color:Colors.grey.shade600,
                  //         fontSize:14),)),
                  //   DataCell(Text('Made in India',
                  //     style: TextStyle(fontWeight: FontWeight.bold,
                  //         color:Colors.black,
                  //         fontSize:14),)),
                  // ]),
                ],
              ),
            ),
            SizedBox(height: 20,),
            // Container(
            //     margin: EdgeInsets.all(16),
            //     child:Text(
            //       "We are leading manufacturer of kichen tools and house hold product and we are provide best quality products at a good price.",
            //       style: TextStyle(fontWeight: FontWeight.normal,
            //           color:Colors.black,
            //           fontSize:16),
            //     )
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  // SizedBox( width:30),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.chat_outlined,size: 15,
                  //           weight:800,
                  //           color:  Color(0xffE57373)),
                  //       SizedBox( width:6),
                  //       Text("Message Us", style:TextStyle(fontSize: 14,
                  //           color:  Color(0xffE57373))),
                  //     ],
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.white,
                  //     side: const BorderSide(
                  //       width: 1.5,
                  //       color: Color(0xffE57373),
                  //     ),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.only(topLeft:Radius.circular(30),bottomLeft:Radius.circular(30)),
                  //     ),),
                  // ),
                  // SizedBox( width:6),
                  Container(
                    width: MediaQuery.of(context).size.width/1.1,
                    child: ElevatedButton(
                      onPressed: () {
                        _showDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 65),
                        child: Row(
                          children: [
                            Icon(Icons.call,size: 15,
                              weight:800,
                              color: Colors.white),
                            SizedBox( width:6),
                            Text("Contact Supplier", style:TextStyle(fontSize: 16,)),
                            SizedBox( width:40),
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
