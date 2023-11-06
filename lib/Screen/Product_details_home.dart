import 'dart:convert';

import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Api.path.dart';
import '../Model/Get_home_product_details_model.dart';
import '../color.dart';
import '../widgets/Appbar.dart';
import '../widgets/appButton.dart';

class ProductDetailsHome extends StatefulWidget {
  String? pId,businessName;
   ProductDetailsHome({Key? key,this.pId,this.businessName}) : super(key: key);

  @override
  State<ProductDetailsHome> createState() => _ProductDetailsHomeState();
}

class _ProductDetailsHomeState extends State<ProductDetailsHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
    getProductDetailsApi();
  }

  String? mNo;
  getProfile() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var sessionId = sharedPreferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=60e6733f1ca928a67f86820b734e34f4e5e0dd4e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getUserProfile}'));
    request.fields.addAll({'user_id': '${sessionId}'});
    print('____sss______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result2 = await response.stream.bytesToString();
      var profileStore = jsonDecode(result2);
      setState(() {
        profileStore2 = profileStore;
      });
    }
    if (profileStore2['error'] == false) {
      mNo = "${profileStore2['data']['mobile']}";
      yourMobileNumber.text = mNo ?? "";
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {

    print('___dssdfsd_______${widget.pId}___${widget.businessName}______');
    return Scaffold(
      appBar: customAppBar(text: "Product Details",isTrue: false, context: context),
      body:getHomeProductDetails == null || getHomeProductDetails == ""?const Center(child: CircularProgressIndicator()) : getHomeProductDetails!.data!.length == 0 ? const Center(child: Text("No Details Found!!")): Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                        child:getHomeProductDetails?.data?.first.image == null || getHomeProductDetails?.data?.first.image == " " ? Image.asset("Images/no-image-icon.png",height: 200,width:double.infinity,fit: BoxFit.fill,): Image.network("${getHomeProductDetails?.data?.first.image}",fit: BoxFit.fill,))),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Text("${getHomeProductDetails?.data?.first.storeName}",style: const TextStyle(color: colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(
                      width: 110,
                        child: Text("(${widget.businessName})",style: const TextStyle(color: colors.black,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),maxLines: 1,)),
                  ],
                ),
                const SizedBox(height: 5,),
                  Text("${getHomeProductDetails?.data?.first.name}",style: const TextStyle(color: colors.black,fontWeight: FontWeight.bold),),
                const SizedBox(height: 5,),
              RatingBar.builder(
                itemSize: 20,
                //initialRating: 3,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: getHomeProductDetails!.data!.first.sellerRating!.length,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context,_) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                 print(rating);

                },
              ),
                Text("${getHomeProductDetails?.data?.first.sellerRating} (Review)"),

                const SizedBox(height: 5,),
              Container(
                height: 40,
                child:Row(
                  children: [
                    const Text("Tags :",style: TextStyle(color: colors.black,fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10,),
                    getHomeProductDetails?.data![0].tags == null ? const SizedBox.shrink(): Container(
                      decoration: BoxDecoration(
                        color: colors.primary.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      height: 25,
                      width: 140,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: getHomeProductDetails?.data![0].tags!.length,
                          itemBuilder: (context,i){
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("${getHomeProductDetails?.data![0].tags!.join(',')}"),
                            );
                          }),
                    ),
                  ],
                )
              ),
                const Text("Description",style: TextStyle(color: colors.black,fontWeight: FontWeight.bold),),
                const SizedBox(height: 5,),
                Text("${getHomeProductDetails?.data?.first.shortDescription}"),
                const SizedBox(height: 50,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      child: Btn(
                        height: 40,
                        width: 150,
                        title: "Contact Supplier",
                        onPress: () {
                          showDialogContactSuplier(getHomeProductDetails?.data?.first.id ?? "", mobilee);
                        },
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController pinCodeController = new TextEditingController();
  final _Cotact = GlobalKey<FormState>();
  TextEditingController yournamecontroller = TextEditingController();
  TextEditingController yourMobileNumber = TextEditingController();
  TextEditingController YourcityController = TextEditingController();
  bool verifie = false;
  String? controller;
  String? OTPIS;

  void showDialogContactSuplier(String productId, Mobile) async {
    print('______sasdsd____${productId}_________');
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: userId == "null" ? 400 : 250,
                width: MediaQuery.of(context).size.width / 1.2,
                // width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Form(
                    key: _Cotact,
                    child: Column(
                      children: [
                        Container(
                          color: colors.primary,
                          height: 60,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'Contact Supplier',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        userId != 'null'
                            ? Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: TextFormField(
                                maxLength: 10,
                                readOnly: true,
                                controller: yourMobileNumber,
                                decoration: new InputDecoration(
                                  prefixIcon: const Padding(
                                    padding:
                                    EdgeInsets.only(top: 3),
                                    child: Icon(
                                      Icons.call,
                                      color: colors.primary,
                                      size: 20,
                                    ),
                                  ),
                                  counterText: "",
                                  contentPadding:
                                  const EdgeInsets.only(top: 0, left: 0),
                                  hintText: "Your Mobile",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                    new BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "mobile cannot be empty";
                                  } else if(val.length < 10){
                                    return "Please enter 10 digit number";

                                  }
                                },
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        )
                            : Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: TextFormField(
                                controller: yournamecontroller,
                                decoration: new InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.only(top: 5, left: 5),
                                  hintText: "Your Name",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                    new BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),

                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Name cannot be empty";
                                  } else if(val.length < 3){
                                    return "Please enter 3 digit Name";

                                  }
                                },

                                keyboardType: TextInputType.name,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: TextFormField(
                                maxLength: 10,
                                readOnly: true,
                                controller: yourMobileNumber,
                                decoration: new InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.only(top: 5, left: 5),
                                  hintText: "Your Mobile",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                    new BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "mobile cannot be empty";
                                  } else if(val.length < 10){
                                    return "Please enter 10 digit number";

                                  }
                                },
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: TextFormField(
                                controller: YourcityController,
                                decoration: new InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.only(top: 5, left: 5),
                                  hintText: "Your City",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                    new BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "City cannot be empty";
                                  } else if(val.length < 3){
                                    return "Please enter 3 digit City";
                                  }
                                },
                                keyboardType: TextInputType.name,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Btn(
                          height: 40,
                          width: 150,
                          title: "Send OTP",
                          onPress: () {
                            if (_Cotact.currentState!.validate()) {
                              sendOtpCotactSuplier(productId);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }
  sendOtpCotactSuplier(String ProductId) async {
    var headers = {
      'Cookie': 'ci_session=aa35b4867a14620a4c973d897c5ae4ec6c25ee8e'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}send_otp_for_enquiry'));

    if (userId == null || userId == '' || userId == 'null') {
      request.fields.addAll({
        'mobile': yourMobileNumber.text.toString(),
        'city': YourcityController.text.toString(),
        'name': yournamecontroller.text.toString(),
      });
    } else {
      request.fields.addAll({
        'mobile': yourMobileNumber.text.toString(),
      });
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['error'] == false) {
        setState(() {
          verifie = true;

          OTPIS = finalresult['data']['otp'].toString();
        });

        Navigator.pop(context);
        showDialogverifyContactSuplier(ProductId);
      }
    } else {
      print(response.reasonPhrase);
    }
  }
  void showDialogverifyContactSuplier(String productIddd) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: 250,
                width: MediaQuery.of(context).size.width / 1.5,
                // width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Container(
                        color: colors.primary,
                        height: 60,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Contact Supplier',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'OTP : ${OTPIS}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
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
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Btn(
                        height: 40,
                        width: 150,
                        title: "Verify OTP",
                        onPress: () {
                          if (controller == OTPIS) {
                            sendEnqury(productIddd);
                          } else {
                            Fluttertoast.showToast(msg: 'Enter Correct OTP');
                          }
                        },
                      )
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
    var request =
    http.MultipartRequest('POST', Uri.parse('${baseUrl}save_inquiry'));

    if (userId == null || userId == '' || userId == 'null') {
      request.fields.addAll({
        'name': yournamecontroller.text.toString(),
        'mobile': yourMobileNumber.text.toString(),
        'city': YourcityController.text.toString(),
        'product_id': productid.toString()
      });
    } else {
      request.fields.addAll({
        'mobile': yourMobileNumber.text.toString(),
        'product_id': productid.toString(),
        'user_id': userId.toString(),
      });
    }
    print('____sassasadad______${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      var finalResult = jsonDecode(result);
      if (finalResult['status'] == true) {
        Fluttertoast.showToast(msg: finalResult['message']);
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const B2BHome()));
      } else {
        Fluttertoast.showToast(msg: finalResult['message']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }
  GetHomeProductDetailsModel? getHomeProductDetails ;
  getProductDetailsApi() async {
    var headers = {
      'Cookie': 'ci_session=7b70d852d78e7fa54dfcb9f70964683c6b672974'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_products'));
    request.fields.addAll({
      'id': widget.pId ??""
    });
   print('____this is a parameter______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetHomeProductDetailsModel.fromJson(jsonDecode(result));
      setState(() {
        getHomeProductDetails = finalResult;
      });
      print('____Aaa______${result}_________');
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
