import 'dart:convert';

import 'package:b2b/Constant/Constants.dart';
import 'package:b2b/Model/suplier_Client_supplier_response.dart';
import 'package:b2b/Screen/MapHomeScreen.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:b2b/apiServices/apiStrings.dart';
import 'package:b2b/color.dart';
import 'package:b2b/utils/GetPreference.dart';
import 'package:b2b/widgets/categoryCard.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/Get_client_model.dart';
import '../Model/businessCategoruModel.dart';
import '../widgets/Appbar.dart';
import '../widgets/appButton.dart';
import 'package:http/http.dart' as http;

import 'HomeScreen.dart';
import 'MapClientScreen.dart';
import 'Product_details_home.dart';

//List <List<ClientListData>> dataList1 = [] ;
class ClientScreen extends StatefulWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  //List <List<ClientListData>> dataList = [] ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClientApi();
    businessCategory();
  }

  String currentItem = "Relavance";
  String currentbusiness = "Manufacturers";
  List<String> items = [
    "Relavance",
    "Top Rated",
    "Newest First",
    "Oldest First",
    "Price - Low to High",
    "Price - High to Low"
  ];

  List<String> bussinessCat = [
    "Manufacturers",
    "Wholesaler",
    "Retailers",
    "Service Provider",
    "Vegetable Business",
    "Stationary Bussiness",
    "Stainless steel Business",
    "Farmer Comapny"
  ];
  BusinessCategoruModel? businesscatorymodel;

  Future<void> businessCategory() async {
    apiBaseHelper.getAPICall(getSupplierCategoryApi).then((getData) {
      bool error = getData['error'];
      if (!error) {
        businesscatorymodel = BusinessCategoruModel.fromJson(getData);
      } else {}
    });
  }

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  TextEditingController nameCtr = TextEditingController();
  TextEditingController numberCtr = TextEditingController();
  TextEditingController cityCtr = TextEditingController();
  TextEditingController otpCtr = TextEditingController();
  TextEditingController numCtr = TextEditingController();

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Contact Supplier ',
            style: TextStyle(fontSize: 15, color: colors.primary),
          ),
          actions: [
            Container(
              // height: 500,
              child: Form(
                key: _formKey1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10.0),
                      child: TextFormField(
                        controller: nameCtr,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          hintText: 'Your Name',
                          hintStyle: TextStyle(color: Colors.black26),
                          prefixIcon: Icon(Icons.person_rounded),
                          prefixIconColor: Colors.black38,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This value is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10.0),
                      child: TextFormField(
                        controller: numberCtr,
                        cursorColor: Colors.black,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          hintText: 'Your Mobile',
                          hintStyle: TextStyle(color: Colors.black26),
                          prefixIcon: Icon(Icons.call),
                          prefixIconColor: Colors.black38,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This value is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10.0),
                      child: TextFormField(
                        controller: cityCtr,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          hintText: 'Your City',
                          hintStyle: TextStyle(color: Colors.black26),
                          prefixIcon: Icon(Icons.location_city),
                          prefixIconColor: Colors.black38,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This value is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: colors.primary),
                        onPressed: () {
                          if (nameCtr.text == "") {
                            Fluttertoast.showToast(
                                msg: "Please enter the name.");
                          } else if (numberCtr.text == "") {
                            Fluttertoast.showToast(
                                msg: "Please enter the mobile number.");
                          } else if (cityCtr.text == "") {
                            Fluttertoast.showToast(
                                msg: "Please enter the city.");
                          } else {
                            otpCtr.text = "";
                            _showDialogOTP(context);
                          }
                        },
                        child: const Text(
                          'Send OTP',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _showDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Contact Supplier ',
            style: TextStyle(fontSize: 15, color: colors.primary),
          ),
          actions: [
            Container(
              // height: 500,
              child: Form(
                key: _formKey2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10.0),
                      child: TextFormField(
                        controller: numCtr,
                        cursorColor: Colors.black,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          hintText: 'Your Mobile',
                          hintStyle: TextStyle(color: Colors.black26),
                          prefixIcon: Icon(Icons.call),
                          prefixIconColor: Colors.black38,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This value is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: colors.primary),
                        onPressed: () {
                          otpCtr.text = "";
                          _showDialogOTP(context);
                        },
                        child: const Text(
                          'Send OTP',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _showDialogOTP(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Contact Supplier ',
            style: TextStyle(fontSize: 15, color: colors.primary),
          ),
          actions: [
            Container(
              // height: 500,
              child: Form(
                key: _formKey3,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10.0),
                      child: TextFormField(
                        controller: otpCtr,
                        cursorColor: Colors.black,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          hintText: 'OTP',
                          hintStyle: TextStyle(color: Colors.black26),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This value is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: colors.primary),
                        onPressed: () {
                          if (otpCtr.text == "") {
                            Fluttertoast.showToast(msg: "Please enter OTP.");
                          } else {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>B2BHome()));
                          }
                        },
                        child: const Text(
                          'Verify OTP',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String? selectedBusiness;
  int? selectedBusinessIndex;
  String? businessId;
  String? businessName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            customAppBar(text: "Your Clients", isTrue: false, context: context),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: colors.primary,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Sort By :",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      border: Border.all(
                                          color: colors.black.withOpacity(0.2))
                                      // border:,
                                      ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      // onTap: () {
                                      //   // getSubCategory();
                                      // },

                                      // decoration: InputDecoration(
                                      //     contentPadding: EdgeInsets.only(
                                      //         bottom: 13.5, left: 20),
                                      //     border: InputBorder.none
                                      // ),
                                      value: currentItem,
                                      // underline: Container(),
                                      isExpanded: true,
                                      // icon: const Icon(
                                      //     Icons.keyboard_arrow_down),
                                      hint: Text(
                                        "Relevance",
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 10),
                                      ),
                                      items: [
                                        "Relavance",
                                        "Top Rated",
                                        "Newest First",
                                        "Oldest First",
                                        "Price - Low to High",
                                        "Price - High to Low"
                                      ]
                                          .map<DropdownMenuItem<String>>(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (String? value) => setState(
                                        () {
                                          if (value != null)
                                            currentItem = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Business Categories :",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color:
                                              colors.black.withOpacity(0.4))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: const Text(
                                        "Categories",
                                        style: TextStyle(
                                            color: colors.black, fontSize: 15),
                                      ),
                                      // dropdownColor: colors.primary,
                                      value: selectedBusiness,
                                      // icon: const Padding(
                                      //   padding: EdgeInsets.only(right:10.0),
                                      //   child: Icon(Icons.keyboard_arrow_down_rounded,  color:colors.secondary,size: 10,),
                                      // ),
                                      // style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                                      underline: Container(
                                        width: 10,
                                        color: colors.white,
                                      ),
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedBusiness = value!;
                                          businesscatorymodel!.data!
                                              .forEach((element) {
                                            if (element.name == value) {
                                              selectedBusinessIndex =
                                                  businesscatorymodel!.data!
                                                      .indexOf(element);
                                              businessId = element.id;
                                              businessName = element.name;
                                              getClientApi();
                                              setState(() {});
                                            }
                                          });
                                        });
                                      },
                                      items: businesscatorymodel?.data
                                          ?.map((items) {
                                        return DropdownMenuItem(
                                          value: items.name.toString(),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            child: Text(
                                              items.name.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: colors.black),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GoogleMapClient(
                                          model: getClientModel!.data)));
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: colors.primary,
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Center(
                                    child: Icon(
                                  Icons.location_on_outlined,
                                  color: colors.white,
                                )))),
                      ),
                    ),
                    getSubcat(),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ));
  }

  getSubcat() {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 12, right: 5),
      child: getClientModel!.data!.isEmpty
          ? const Center(child: Text("Product Not Found!!"))
          : ListView.builder(
              itemCount: getClientModel!.data!.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                if (i == null)
                  return Container();
                else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "${getClientModel!.data![i].categoryName}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.9,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const ScrollPhysics(),
                              itemCount:
                                  getClientModel!.data![i].vendorData?.length ?? 0,
                              //> 6 ? 6 : GetSub!.data![i].products!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () async {
                                    print('');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsHome(
                                                  pId: getClientModel!
                                                      .data![i]
                                                      .vendorData![index]
                                                      .productInfo
                                                      ?.id,
                                                  businessName: getClientModel!
                                                      .data![i]
                                                      .vendorData![index]
                                                      .sellerInfo
                                                      ?.typeOfSeller
                                                      ?.split(',')
                                                      .first,
                                                )));
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    margin: const EdgeInsets.all(0),
                                    child: Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5.6,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: getClientModel!
                                                          .data![i]
                                                          .vendorData![index]
                                                          .productInfo ==
                                                      null
                                                  ? Image.asset(
                                                      "Images/loginlogo.png")
                                                  : Image.network(
                                                      "${imageUrl}${getClientModel!.data![i].vendorData![index].productInfo?.image}" ??
                                                          '',
                                                      fit: BoxFit.fill,
                                                    ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 24, top: 10),
                                            child: getClientModel!
                                                        .data![i]
                                                        .vendorData![index]
                                                        .productInfo ==
                                                    null
                                                ? const Text("No Name")
                                                : Text(
                                                    "${getClientModel!.data![i].vendorData![index].productInfo?.name}" ??
                                                        '',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 24, top: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const CircleAvatar(
                                                          backgroundColor:
                                                              colors.primary,
                                                          radius: 10,
                                                          child: Icon(
                                                            Icons
                                                                .person_rounded,
                                                            color: colors.white,
                                                            size: 15,
                                                          )),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          "${getClientModel!.data![i].vendorData![index].sellerDataInfo?.storeName}" ??
                                                              ''),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          width: 120,
                                                          child: businessName ==
                                                                      null ||
                                                                  businessName ==
                                                                      "Select All"
                                                              ? Text(
                                                                  "(${getClientModel!.data![i].vendorData![index].sellerInfo!.typeOfSeller?.split(',').first})" ??
                                                                      '',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      color: colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              : Text(
                                                                  "(${businessName})" ??
                                                                      '',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      color: colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ))
                                                    ],
                                                  )
                                                ],
                                              )),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 24, top: 5),
                                            child: Row(
                                              children: [
                                                const CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:
                                                      colors.primary,
                                                  child: Icon(
                                                    Icons.location_pin,
                                                    size: 15,
                                                    color: colors.white,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                    width: 180,
                                                    child: Text(
                                                      "${getClientModel!.data![i].vendorData![index].sellerInfo!.address}" ??
                                                          "",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 20, top: 5, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      launch(
                                                          "${getClientModel!.data![i].vendorData![index].productInfo!.video}");
                                                    },
                                                    child: Row(
                                                      children: const [
                                                        Icon(
                                                          Icons
                                                              .video_camera_back_outlined,
                                                          color: colors.primary,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        InkWell(
                                                            child: Text(
                                                                "Watch Video"))
                                                      ],
                                                    )),
                                                Row(
                                                  children: [
                                                    const CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Icon(
                                                          Icons.image,
                                                          color: colors.primary,
                                                        )),
                                                    InkWell(
                                                        onTap: () {
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              title: const Text(
                                                                  'Broucher Image'),
                                                              content:
                                                                  Image.network(
                                                                      "${getClientModel!.data![i].vendorData![index].productInfo!.broucherImage}"),
                                                            ),
                                                          );
                                                        },
                                                        child: const Text(
                                                            "Broucher"))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50)),
                                                          color: Colors
                                                              .deepPurple),
                                                  child: const Icon(
                                                    Icons.add_circle,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          color: Colors
                                                              .deepPurple),
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        top: 3,
                                                        bottom: 3),
                                                    child: Icon(
                                                      Icons.message,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6)),
                                                          color:
                                                              colors.secondary),
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        top: 3,
                                                        bottom: 3),
                                                    child: Icon(
                                                      Icons.mail_outline,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50)),
                                                          color:
                                                              colors.primary),
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        top: 3,
                                                        bottom: 3),
                                                    child: Icon(
                                                      Icons.location_pin,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      20,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  6)),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.grey),
                                                      color: colors.white),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        50)),
                                                            color: getClientModel!
                                                                .data![
                                                            i]
                                                                .vendorData![
                                                            index]
                                                                .sellerDataInfo == null || getClientModel!
                                                                        .data![
                                                                            i]
                                                                        .vendorData![
                                                                            index]
                                                                        .sellerDataInfo!
                                                                        .taxNumber ==
                                                                    ""
                                                                ? colors.primary
                                                                : colors
                                                                    .secondary),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 5,
                                                                  top: 3,
                                                                  bottom: 3),
                                                          child: Icon(
                                                            Icons.description,
                                                            size: 15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        50)),
                                                            color: getClientModel!
                                                                        .data![
                                                                            i]
                                                                        .vendorData![
                                                                            index]
                                                                        .sellerInfo!
                                                                        .subscriptionType ==
                                                                    1
                                                                ? colors.primary
                                                                : colors
                                                                    .secondary),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 5,
                                                                  top: 3,
                                                                  bottom: 3),
                                                          child: Icon(
                                                            Icons
                                                                .check_circle_outline,
                                                            size: 15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        50)),
                                                            color: getClientModel!
                                                                        .data![
                                                                            i]
                                                                        .vendorData![
                                                                            index]
                                                                        .sellerInfo!
                                                                        .subscriptionType ==
                                                                    1
                                                                ? colors.primary
                                                                : colors
                                                                    .secondary),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 5,
                                                                  top: 3,
                                                                  bottom: 3),
                                                          child: Icon(
                                                            Icons.verified_user,
                                                            size: 15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Center(
                                            child: Btn(
                                              height: 40,
                                              width: 150,
                                              title: "Contact Supplier",
                                              onPress: () {
                                                showDialogContactSuplier(
                                                    getClientModel!
                                                        .data![i]
                                                        .vendorData![index]
                                                        .sellerInfo!
                                                        .id
                                                        .toString(),
                                                    mobileNo);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
    );
  }

  // List<ClientSupplierProductData> supplierDataList = [];
  //List <List<ClientListData>> dataList1 = [] ;
  bool isLoading = false;
  GetClientModel? getClientModel;
  List<dataListClient> productList = [];

  getClientApi() async {
    setState(() {
      isLoading = true;
    });
    String? userId = await getString(key: 'id');
    var headers = {
      'Cookie': 'ci_session=956d314ffb2d0bd8f223c4cb36883058400b2dc5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}clients'));
    request.fields.addAll({
      'seller_id': userId.toString(),
      'type': '2',
      "buisness_category":
          businessName == null || businessName == "" ? "" : "${businessName}"
    });
    print('_____request data_____${request.fields}____${request}_____');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print('___this is a data_______${result}_________');
      var finalResult = GetClientModel.fromJson(jsonDecode(result));
      setState(() {
        getClientModel = finalResult;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }

  // Future<void> getClientApi() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   String? userId = await getString(key: 'id');
  //   var param = {"seller_id": userId,"buisness_category":'Wholesaler'};
  //   apiBaseHelper.postAPICall(getSupplierOrClientApi, param).then((getData) {
  //     print('____aaa______${param}_________');
  //     bool error = getData['error'];
  //     String msg = getData['message'];
  //     if (!error) {
  //       var finalJson = GetClientModel.fromJson(getData);
  //       getClientModel = finalJson;
  //       // for(int i = 0; i< getClientModel!.data!.length; i++){
  //       // //  dataList1.add(getClientModel!.data![i].vendorData);
  //       // }
  //       setState(() {
  //         isLoading = false;
  //       });
  //     } else {
  //       Fluttertoast.showToast(msg: msg);
  //     }
  //   });
  // }
  Future<void> contactToClient(String itemId) async {
    String? mobile = await getString(key: 'mobile');

    String? userId = await getString(key: 'id');

    var param = {
      "user_id": userId,
      "product_id": itemId ?? '438',
      "mobile": mobile
    };

    apiBaseHelper
        .postAPICall(contactSupplierOrClientApi, param)
        .then((getData) {
      bool error = getData['error'];
      String msg = getData['message'];

      if (!error) {
        //var finalJson = GetSupplierOrClientResponse.fromJson(getData);
        Fluttertoast.showToast(msg: msg);
      } else {
        Fluttertoast.showToast(msg: msg);
      }
    });
  }

  // getSubcat(){
  //   return Container(
  //     padding: const EdgeInsets.only(top: 0, left: 12,right: 5),
  //     child: ListView.builder(
  //       itemCount:get!.data!.length,
  //       // scrollDirection: Axis.vertical,
  //       physics: NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       itemBuilder: (context, i) {
  //         if (i == null)
  //           return Container();
  //         else {
  //           return
  //            // GetSub!.data![i].products == null || GetSub!.data![i].products!.length == 0? SizedBox.shrink():
  //             Padding(
  //               padding: EdgeInsets.only(bottom: 5),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 // mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text("${get!.data![i].name!.toUpperCase()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
  //                         SizedBox(height: 10,),
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     height: MediaQuery.of(context).size.height/1.9,
  //                     //  GetSub!.data![i].products!.length >3? 280:140,
  //                     child:
  //                     ListView.builder(
  //                         shrinkWrap: true,
  //                         scrollDirection: Axis.horizontal,
  //                         physics: ScrollPhysics(),
  //                         itemCount:GetSub!.data![i].products!.length ,
  //                         //> 6 ? 6 : GetSub!.data![i].products!.length,
  //                         itemBuilder: (BuildContext context, int index) {
  //                           return  GestureDetector(
  //                             onTap: () async {
  //                               {}
  //                             },
  //                             child: Container(
  //                               width: MediaQuery.of(context).size.width/1.2,
  //                               margin: const EdgeInsets.all(0),
  //                               child: Card(
  //                                 elevation: 4,
  //                                 shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(20),
  //                                 ),
  //                                 child: Column(
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   crossAxisAlignment: CrossAxisAlignment.start,
  //                                   children: [
  //                                     const SizedBox(height: 10,),
  //                                     Container(
  //                                       padding: const EdgeInsets.symmetric(horizontal: 20),
  //                                       height: MediaQuery.of(context).size.height / 5.6,
  //                                       width: MediaQuery.of(context).size.width,
  //                                       child: ClipRRect(
  //                                         borderRadius: BorderRadius.circular(20),
  //                                         child: Image.network("${GetSub!.data![i].products![0].productImage}" ?? '',
  //                                           fit: BoxFit.fill,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                     Container(
  //                                       margin: const EdgeInsets.only(left: 24, top: 10),
  //                                       child:  Text(
  //                                         "${GetSub!.data![i].products![0].name}" ?? '',
  //                                         style: const TextStyle(
  //                                             fontWeight: FontWeight.bold, fontSize: 16),
  //                                       ),
  //                                     ),
  //                                     Container(
  //                                         margin: const EdgeInsets.only(left: 24, top: 10),
  //                                         child:
  //                                         Row(
  //                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                           children: [
  //                                             Row(
  //                                               children:  [
  //                                                 CircleAvatar(
  //                                                     backgroundColor: colors.primary,
  //                                                     radius: 10,
  //                                                     child: Icon(Icons.person_rounded,color: colors.white,size: 15,)),
  //                                                 SizedBox(width: 10,),
  //                                                 Text("${GetSub!.data![i].products![0].storeName}" ?? ''),
  //
  //                                               ],
  //
  //                                             ),
  //                                             Row(
  //                                               children: [
  //                                                 Container(
  //                                                     width: 120,
  //                                                     child: Text("(${GetSub!.data![i].products![0].typeOfSeller})" ?? '',
  //                                                       maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: colors.black,fontWeight: FontWeight.bold),)),
  //                                               ],
  //                                             )
  //                                           ],
  //                                         )
  //
  //                                     ),
  //                                     Container(
  //                                       margin: const EdgeInsets.only(left: 24, top: 5),
  //                                       child: Row(
  //                                         children:  [
  //                                           const CircleAvatar(
  //                                             radius: 10,
  //                                             backgroundColor: colors.primary,
  //                                             child: Icon(
  //                                               Icons.location_pin,size: 15,
  //                                               color: colors.white,
  //                                             ),
  //                                           ),
  //                                           const SizedBox(
  //                                             width: 10,
  //                                           ),
  //                                           Container(
  //                                               width: 180,
  //                                               child: Text("${GetSub!.data![i].products![0].address}" ??"",overflow: TextOverflow.ellipsis,maxLines: 1,)),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                     Container(
  //                                       margin:
  //                                       const EdgeInsets.only(left: 20, top: 5, right: 20),
  //                                       child: Row(
  //                                         mainAxisAlignment:
  //                                         MainAxisAlignment.spaceBetween,
  //                                         children: [
  //                                           Row(
  //                                             children: const [
  //                                               CircleAvatar(
  //                                                 radius: 15,
  //                                                 backgroundColor: Colors.white,
  //                                                 child: Icon(
  //                                                   Icons.smart_display_rounded,
  //                                                   color: colors.primary,
  //                                                 ),
  //                                               ),
  //                                               Text("Watch Video")
  //                                             ],
  //                                           ),
  //                                           Row(
  //                                             children: const [
  //                                               CircleAvatar(
  //                                                   radius: 15,
  //                                                   backgroundColor: Colors.white,
  //                                                   child: Icon(
  //                                                     Icons.image,
  //                                                     color: colors.primary,
  //                                                   )),
  //                                               Text("Broucher")
  //                                             ],
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                     SizedBox(height: 10,),
  //                                     Container(
  //                                       margin: const EdgeInsets.only(left: 20, right: 20),
  //                                       child: Row(
  //                                         mainAxisAlignment:
  //                                         MainAxisAlignment.spaceAround,
  //                                         children: [
  //                                           Container(
  //                                             height: 25,
  //                                             width: 25,
  //                                             decoration: const BoxDecoration(
  //                                                 borderRadius: BorderRadius.all(
  //                                                     Radius.circular(50)),
  //                                                 color: Colors.deepPurple),
  //                                             child: Icon(
  //                                               Icons.add_circle,size: 15,
  //                                               color: Colors.white,
  //                                             ),
  //                                           ),
  //                                           Container(
  //                                             height: 25,
  //                                             width: 25,
  //                                             decoration: const BoxDecoration(
  //                                                 borderRadius: BorderRadius.all(
  //                                                     Radius.circular(5)),
  //                                                 color: Colors.deepPurple),
  //                                             child: const Padding(
  //                                               padding: EdgeInsets.only(
  //                                                   left: 5, right: 5, top: 3, bottom: 3),
  //                                               child: Icon(
  //                                                 Icons.message,size: 15,
  //                                                 color: Colors.white,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           Container(
  //                                             height: 25,
  //                                             width: 25,
  //                                             decoration: const BoxDecoration(
  //                                                 borderRadius: BorderRadius.all(
  //                                                     Radius.circular(6)),
  //                                                 color: colors.secondary),
  //                                             child: const Padding(
  //                                               padding: EdgeInsets.only(
  //                                                   left: 5, right: 5, top: 3, bottom: 3),
  //                                               child: Icon(
  //                                                 Icons.mail_outline,size: 15,
  //                                                 color: Colors.white,
  //                                               ),
  //                                             ),
  //                                           ),
  //
  //                                           Container(
  //                                             height: 25,
  //                                             width: 25,
  //                                             decoration: const BoxDecoration(
  //                                                 borderRadius: BorderRadius.all(
  //                                                     Radius.circular(50)),
  //                                                 color: colors.primary),
  //                                             child: const Padding(
  //                                               padding: EdgeInsets.only(
  //                                                   left: 5, right: 5, top: 3, bottom: 3),
  //                                               child: Icon(
  //                                                 Icons.location_pin,size: 15,
  //                                                 color: Colors.white,
  //                                               ),
  //                                             ),
  //                                           ),
  //
  //                                           Container(
  //                                             height: MediaQuery.of(context).size.height/20,
  //                                             width: MediaQuery.of(context).size.width/3,
  //                                             decoration: BoxDecoration(
  //                                                 borderRadius: const BorderRadius.all(Radius.circular(6)),
  //                                                 border: Border.all(width: 2, color: Colors.grey),
  //                                                 color: colors.white),
  //                                             child: Row(
  //                                               mainAxisAlignment:
  //                                               MainAxisAlignment.spaceAround,
  //                                               children:  [
  //                                                 Container(
  //                                                   height: 25,
  //                                                   width: 25,
  //                                                   decoration:  BoxDecoration(
  //                                                       borderRadius: BorderRadius.all(
  //                                                           Radius.circular(50)),
  //                                                       color:GetSub!.data![i].products![0].taxNumber == "" ? colors.primary : colors.secondary),
  //                                                   child: const Padding(
  //                                                     padding: EdgeInsets.only(
  //                                                         left: 5, right: 5, top: 3, bottom: 3),
  //                                                     child: Icon(
  //                                                       Icons.description,size: 15,
  //                                                       color: Colors.white,
  //                                                     ),
  //                                                   ),
  //                                                 ),
  //
  //                                                 Container(
  //                                                   height: 25,
  //                                                   width: 25,
  //                                                   decoration:  BoxDecoration(
  //                                                       borderRadius: BorderRadius.all(
  //                                                           Radius.circular(50)),
  //                                                       color: GetSub!.data![i].products![0].subscriptionType == 1 ? colors.primary : colors.secondary),
  //                                                   child: const Padding(
  //                                                     padding: EdgeInsets.only(
  //                                                         left: 5, right: 5, top: 3, bottom: 3),
  //                                                     child: Icon(
  //                                                       Icons.check_circle_outline,size: 15,
  //                                                       color: Colors.white,
  //                                                     ),
  //                                                   ),
  //                                                 ),
  //                                                 Container(
  //                                                   height: 25,
  //                                                   width: 25,
  //                                                   decoration:  BoxDecoration(
  //                                                       borderRadius: BorderRadius.all(
  //                                                           Radius.circular(50)),
  //                                                       color: GetSub!.data![i].products![0].subscriptionType == 1 ? colors.primary : colors.secondary),
  //                                                   child: const Padding(
  //                                                     padding: EdgeInsets.only(
  //                                                         left: 5, right: 5, top: 3, bottom: 3),
  //                                                     child: Icon(
  //                                                       Icons.verified_user,size: 15,
  //                                                       color: Colors.white,
  //                                                     ),
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                     SizedBox(
  //                                       height:10,
  //                                     ),
  //                                     Center(
  //                                       child: Btn(
  //                                         height: 40,
  //                                         width: 150,
  //                                         title: "Contact Supplier",
  //                                       ),
  //                                     )
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //
  //
  //                           );
  //                         }
  //                     ),
  //
  //
  //                   ),
  //                 ],
  //               ),
  //             );
  //         }
  //
  //
  //       },
  //     ),
  //   );
  // }

  TextEditingController pinCodeController = TextEditingController();
  final _Cotact = GlobalKey<FormState>();

  TextEditingController yournamecontroller = TextEditingController();
  TextEditingController yourMobileNumber = TextEditingController();
  TextEditingController YourcityController = TextEditingController();
  bool verifie = false;
  String? controller;
  String? OTPIS;

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

  void showDialogContactSuplier(String productId, String? mobile) async {
    yourMobileNumber.text = mobile ?? '';
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: userId != "null" ? 250 : 400,
                width: MediaQuery.of(context).size.width / 1.5,
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
                            children: const [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
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
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      maxLength: 10,
                                      readOnly: true,
                                      controller: yourMobileNumber,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        hintText: "Your Mobile",
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(),
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
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        hintText: "Your Name",
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: BorderSide(),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      maxLength: 10,
                                      controller: yourMobileNumber,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        hintText: "Your Mobile",
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Mobile Number';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
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
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        hintText: "Your City",
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: BorderSide(),
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
                                ],
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        Btn(
                          height: 45,
                          width: 150,
                          title: "Send OTP",
                          onPress: () {
                            if (_Cotact.currentState!.validate()) {
                              print("gggggggggggggggg");
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

  void showDialogverifyContactSuplier(String productIddd) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: 350,
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
                          children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
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
                      InkWell(
                        onTap: () {
                          if (controller == OTPIS) {
                            sendEnqury(productIddd);
                          } else {
                            Fluttertoast.showToast(msg: 'Enter Correct OTP');
                          }
                        },
                        child: Container(
                          color: colors.primary,
                          width: 100,
                          height: 40,
                          child: const Center(
                              child: Text(
                            'Verify Otp',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
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

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      var finalResult = jsonDecode(result);
      if (finalResult['status'] == true) {
        Fluttertoast.showToast(msg: finalResult['message']);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: finalResult['message']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
