import 'dart:convert';
import 'package:b2b/Screen/Media.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import '../Model/GetCatModel.dart';
import '../Model/GetSubCat.dart';
import '../Model/Get_brand_model.dart';
import '../color.dart';
import '../widgets/Appbar.dart';
import '../widgets/Custom_Text.dart';
import '../widgets/Custom_textForm.dart';
import '../widgets/appButton.dart';
import 'HomeScreen.dart';


class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

List <String> otherImageList=[];
GetSubData? selectedSubCategory;
String? productImageUrl1;
String? broncherImageUrl1;
GetSubCatModel? getSubCatModel;
GetSubData? getSubData;

GetCatDataList? getCatDataList;
GetCatModel? getCatModel;

GetSubData? subCategory;
String? category_id;
var category;
var subcat;


//TextEditingController _skuCtr= TextEditingController();
//TextEditingController _total_Stock_Ctr= TextEditingController();
//TextEditingController _priceCtr= TextEditingController();
//TextEditingController _specialpriceCtr= TextEditingController();



int videoLinkindex=0;
int pressed=0;
bool _isChecked=false;
int product=0;

final _formKey= GlobalKey<FormState>();


class _AddProductState extends State<AddProduct> {

  // Future<void> _getImage(ImageSource source) async {
  //     final pickedFile = await ImagePicker().pickImage(
  //       source: source,
  //       imageQuality: 50,
  //     );
  //
  //     if (pickedFile != null) {
  //       setState(() {
  //         _imageFile = File(pickedFile.path) ;
  //       });
  //     }
  // }
  // void _showImagePicker(BuildContext context) {
  //   showModalBottomSheet(
  //
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         width: MediaQuery.of(context).size.width,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))),
  //         child: SafeArea(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               ListTile(
  //                 leading: Icon(Icons.photo_library),
  //                 title: Text('Gallery'),
  //                 onTap: () {
  //                   _getImage(ImageSource.gallery);
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //               ListTile(
  //                 leading: Icon(Icons.photo_camera),
  //                 title: Text('Camera'),
  //                 onTap: () {
  //                   _getImage(ImageSource.camera);
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  // File? _imageFile;

  final TextEditingController _nameCtr= TextEditingController();
  final TextEditingController _shortDesCtr= TextEditingController();
  final TextEditingController _fullDesCtr= TextEditingController();
  final TextEditingController _extraDesCtr= TextEditingController();
  final TextEditingController _videoLink= TextEditingController();
  String videoType = 'None';
  var videoList = [
    'None',
    'Youtube'
  ];
  String prodType = 'Select Type';
  var prodList = [
    'Select Type',
    'Simple Product',
  ];
  String stockStatus = 'In Stock';
  var stockList = [
    'In Stock',
    'Out Of Stock'
  ];
  var cat_id;

  void initState() {
    // TODO: implement initState
    // fetchData();

    getCategory();
    getBrandApi();
    getSubCategory("");
    super.initState();
  }

  onclick() async {
     CustomTextFormField(
      controller: _videoLink, hintText: 'Paste Youtube/video link',);
  }

  getCategory() async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=ea5681bb95a83750e0ee17de5e4aa2dca97184ef'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${baseUrl}get_category'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetCatModel.fromJson(json.decode(finalResponse));
   print('____dsdsfds______${finalResponse}_________');
      for (int i = 0; i < jsonResponse.data!.length; i++) {
        print("${jsonResponse.data?[i].id}");
        category_id = jsonResponse.data?[i].id ?? "";
      }

      setState(() {
        getCatModel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  getSubCategory(var catId) async {
    // var catId = category_id ?? "1";
    var headers = {
      'Cookie': 'ci_session=42a446b2158b0665d69eb924baea971b3adf8b1d'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse(
        '${baseUrl}get_sub_category'));
    request.fields.addAll({
      'cat_id': '$catId',
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
      GetSubCatModel.fromJson(json.decode(finalResponse));
      for (int i = 0; i < jsonResponse.data!.length; i++) {
        print("sub cat:${jsonResponse.data?[i].id}");
      }

      setState(() {
        getSubCatModel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  String? selectBrand;
  GetBrandModel? getBrandModel;
  List <GetBrandDataList> getBrandDataList = [];
  String? brandId;
  int? selectedSateIndex;

  getBrandApi() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=ea5681bb95a83750e0ee17de5e4aa2dca97184ef'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_category'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = GetBrandModel.fromJson(json.decode(finalResponse));
      setState(() {
        getBrandModel = finalResult;
        print('____ffffff______${getBrandModel}_________');
      });
    } else {
      print(response.reasonPhrase);
    }
  }

 String? selectedState;
 String? selectedSub;
  String? stateId;
  String? subCatId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: customAppBar(
          text: "Add Product", isTrue: false, context: context),
      // appBar: AppBar(
      //   title: Text('Add Product'),
      //   backgroundColor: colors.primary,
      // ),
      body: getBrandModel == null ? const Center(
          child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Card(
            margin: const EdgeInsets.all(15),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width,),
                  Custom_Text(text: 'Name', text2: '*',),
                  const SizedBox(height: 10,),
                  CustomTextFormField(controller: _nameCtr, hintText: 'Product Name'),
                  const SizedBox(height: 20,),
                  Custom_Text(text: 'Category', text2: ' *',),
                  const SizedBox(height: 10,),
                  getCatModel == null ?const Center(child: CircularProgressIndicator()): SizedBox(
                    height: 50,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(color: colors.black)
                    // ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text('Select Category',
                        style: TextStyle(color: colors.black,fontWeight: FontWeight.w500,fontSize:15
                        ),
                      ),
                      // dropdownColor: colors.primary,
                      value: selectedState,
                      icon: const Padding(
                        padding: EdgeInsets.only(left:10.0,top: 10),
                        child: Icon(Icons.keyboard_arrow_down_rounded,  color:Colors.grey,size: 25,),
                      ),
                      // elevation: 16,
                      style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                      underline: Padding(
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Container(
                          // height: 2,
                          color:  colors.white,
                        ),
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          selectedState = value!;
                          getCatModel!.data!.forEach((element) {
                            if(element.name == value){
                              selectedSateIndex = getCatModel!.data!.indexOf(element);
                              stateId = element.id;
                              getSubCategory(stateId!);
                              //getStateApi();
                            }
                          });
                        });
                      },
                      items: getCatModel!.data!.map((items) {
                        return DropdownMenuItem(
                          value: items.name.toString(),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Container(
                                    width: MediaQuery.of(context).size.width/1.42,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:colors.black),),
                                    )),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Divider(color: colors.black,),
                  SizedBox(height: 20,),
                  Custom_Text(text: 'Sub Category', text2: '*',),
                  SizedBox(height: 10,),
                  // DropdownButtonHideUnderline(
                  //   child: InkWell(
                  //     onTap: () {},
                  //     child: DropdownButtonFormField<GetSubData>(
                  //       onTap: () {},
                  //       decoration: const InputDecoration(
                  //         contentPadding:
                  //         EdgeInsets.only(left: 1),
                  //       ),
                  //       value: selectedSubCategory,
                  //       isExpanded: true,
                  //       icon: Icon(Icons.keyboard_arrow_down, color: Colors
                  //           .grey,),
                  //       hint: Text(
                  //         "Select Subcategory",
                  //         style: TextStyle(
                  //           color: Colors.grey,
                  //         ),
                  //       ),
                  //       items: getSubCatModel?.data?.map((item) {
                  //         return DropdownMenuItem(
                  //           value: item,
                  //           child: Container(
                  //             child: Text(item.name.toString()),
                  //           ),
                  //         );
                  //       }).toList(),
                  //       onChanged: (GetSubData? newValue) {
                  //         setState(() {
                  //           selectedSubCategory = newValue;
                  //           print('${selectedSubCategory?.id}');
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // getSubCatModel == null ?Center(child: CircularProgressIndicator()):
                  getSubCatModel == null ? SizedBox.shrink() :   Container(
                    height: 50,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(color: colors.black)
                    // ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text('Select Subcategory',
                        style: TextStyle(
                            color: colors.black,fontWeight: FontWeight.w500,fontSize:15
                        ),),
                      // dropdownColor: colors.primary,
                      value: selectedSub,
                      icon: const Padding(
                        padding: EdgeInsets.only(left:10.0,top: 10),
                        child: Icon(Icons.keyboard_arrow_down_rounded,  color:Colors.grey,size: 25,),
                      ),
                      // elevation: 16,
                      style: const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                      underline: Padding(
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Container(
                          // height: 2,
                          color:  colors.white,
                        ),
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          selectedSub = value;
                          getSubCatModel!.data!.forEach((element) {
                            if(element.name == value){
                              selectedSateIndex = getSubCatModel!.data!.indexOf(element);
                              subCatId = element.id;
                              //getStateApi();
                            }
                          });
                        });
                      },
                      items: getSubCatModel!.data!.map((items) {
                        return DropdownMenuItem(
                          value: items.name.toString(),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Container(
                                    width: MediaQuery.of(context).size.width/1.42,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:colors.black),),
                                    )),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Divider(color: Colors.grey,),
                  SizedBox(height: 20,),
                  Custom_Text(text: 'Short Description', text2: ' *',),
                  SizedBox(height: 15,),
                  TextFormField(
                    maxLines: 3,
                    controller: _shortDesCtr,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Product Short Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Product Short Description .';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Custom_Text(text: 'Tags', text2: ' *',),
                      const Text('(These tags help you in search result )',
                        style: TextStyle(fontSize: 12))
                    ],
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: tagC,
                    decoration: const InputDecoration(
                      hintText: 'Type in some tags for example AC,Cooler,Flagship Smartphone,Mobiles,Sport Shose ect',
                      hintStyle: TextStyle(color: Colors.grey),
                      //
                      // contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      // border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter tags .';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),

                  Custom_Text(text: 'Brand', text2: '',),
                  SizedBox(height: 5,),
                  // DropdownButton<String>(
                  //   isExpanded: true,
                  //   hint: const Text('Search for brands',
                  //     style: TextStyle(
                  //         color: Colors.grey, fontSize: 15
                  //     ),),
                  //   value: selectBrand,
                  //   icon: const Padding(
                  //     padding: EdgeInsets.only(left: 10.0, bottom: 10),
                  //     child: Icon(Icons.keyboard_arrow_down_rounded, size: 30,
                  //       color: Colors.grey,),
                  //   ),
                  //   // elevation: 16,
                  //   style: const TextStyle(color: colors.secondary,),
                  //   onChanged: (String? value) {
                  //     // This is called when the user selects an item.
                  //     setState(() {
                  //       selectBrand = value!;
                  //       getBrandModel!.data!.forEach((element) {
                  //         if (element.name == value) {
                  //           selectedSateIndex =
                  //               getBrandModel!.data!.indexOf(element);
                  //           brandId = element.id;
                  //           print('_____Surendra_____${brandId}_________');
                  //         }
                  //       });
                  //     });
                  //   },
                  //   items: getBrandModel!.data!.map((items) {
                  //     return DropdownMenuItem(
                  //       value: items.name.toString(),
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(top: 5),
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(top: 0),
                  //           child: Text(items.name.toString(),
                  //             overflow: TextOverflow.ellipsis,
                  //             style: const TextStyle(color: colors.black),),
                  //         ),
                  //       ),
                  //     );
                  //   })
                  //       .toList(),
                  //
                  //
                  // ),
                  getBrandModel == null ?Center(child: CircularProgressIndicator()): Container(
                    height: 50,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(color: colors.black)
                    // ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text('Select Category',
                        style: TextStyle(
                            color: colors.black,fontWeight: FontWeight.w500,fontSize:15
                        ),
                      ),
                      // dropdownColor: colors.primary,
                      value: selectBrand,
                      icon:  const Padding(
                        padding: EdgeInsets.only(left:10.0,top: 10),
                        child: Icon(Icons.keyboard_arrow_down_rounded,  color:Colors.grey,size: 25,),
                      ),
                      // elevation: 16,
                      style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                      underline: Padding(
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Container(
                          // height: 2,
                          color:  colors.white,
                        ),
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          selectBrand = value!;
                          getBrandModel!.data!.forEach((element) {
                            if(element.name == value){
                              selectedSateIndex = getBrandModel!.data!.indexOf(element);

                              //getStateApi();
                            }
                          });
                        });
                      },
                      items: getBrandModel!.data!.map((items) {
                        return DropdownMenuItem(
                          value: items.name.toString(),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Container(
                                    width: MediaQuery.of(context).size.width/1.42,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:colors.black),),
                                    )),
                              ),


                            ],
                          ),
                        );
                      })
                          .toList(),


                    ),
                  ),
                  Divider(color: Colors.grey,),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Custom_Text(text: 'Main Image', text2: ' *',),
                      const SizedBox(width: 20,),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2.8,
                        child: Text(' (Recommended Size: 180 x 180 pixels)',
                          style: TextStyle(fontSize: 12),),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      // showExitPopup1();
                      var result = await Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => Media(from: 'main',)));
                      if (result != null) {
                        setState(() {
                          productImageUrl1 = result;
                        });
                      }
                    },
                    child: Container(
                      width: 100,
                      color: colors.primary,
                      height: productImageUrl1 == null ? 50 : 100,
                      child: productImageUrl1 == null || productImageUrl1 == ""
                          ? const Center(
                          child: Text("Upload ",
                            style: TextStyle(color: colors.white),))
                          : Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0),
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
                  // Custom_Button(text: 'Update',onPressed: (){_showImagePicker(context);},),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Custom_Text(text: 'Other Image', text2: '',),
                      const SizedBox(width: 20,),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2.8,
                        child: const Text(
                          ' (Recommended Size: 180 x 180 pixels)',
                          style: TextStyle(fontSize: 12),),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),


                  InkWell(
                    onTap: () async {
                      otherImageList.clear();
                      //  showExitPopup2();
                      List <String> result = await Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => Media(from: 'other',)));
                      if (result != null) {
                        setState(() {
                          otherImageList = result;
                        });
                      }
                    },
                    child: Container(

                        color:
                        otherImageList.isEmpty ?
                        colors.primary : Colors.white,
                        height: otherImageList.isEmpty ? 50 : 100,
                        child: otherImageList == null || otherImageList.isEmpty
                            ? const Center(
                            child: Text("Upload ",
                              style: TextStyle(color: colors.white),))
                            :

                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: otherImageList.length,

                          itemBuilder: (context, index) {
                            return
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.network(
                                    '${imageUrl}${otherImageList[index]}',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                          },)


                    ),
                  ),

                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Custom_Text(text: 'Broucher Image', text2: '',),
                      SizedBox(width: 10,),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2.8,
                        child: Text(' (Recommended Size: 180 x 180 pixels)',
                          style: TextStyle(fontSize: 12),),
                      )
                    ],
                  ),
                  SizedBox(height: 20),

                  InkWell(
                    onTap: () async {
                      // showExitPopup3();
                      var result = await Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => Media(from: 'Broncherimage',)));

                      if (result != null) {
                        setState(() {
                          broncherImageUrl1 = result.toString();
                        });
                      }
                    },
                    child: Container(
                      width: 100,
                      color: colors.primary,
                      height: broncherImageUrl1 == null ? 50 : 100,
                      child: broncherImageUrl1 == null ||
                          broncherImageUrl1 == ""
                          ? const Center(
                          child: Text("Upload ",
                            style: TextStyle(color: colors.white),))
                          : Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.network(
                              broncherImageUrl1!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Custom_Text(text: 'Video Type', text2: '',),
                  SizedBox(height: 10,),
                  DropdownButtonFormField<String>(
                    value: videoType,
                    decoration: const InputDecoration(
                      contentPadding:
                      EdgeInsets.only(left: 20),
                    ),
                    hint: Text('None', style: TextStyle(color: Colors.grey),),
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp, color: Colors.grey,),
                    items: videoList.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        videoType = newValue!;
                        if (newValue == 'Youtube') {
                          videoLinkindex = 1;
                          print(newValue);
                        }
                        if (newValue != 'Youtube') {
                          videoLinkindex = 0;
                        }
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                  ),
                  (videoLinkindex == 1) ? Container(
                    child: Column(
                      children: [
                        SizedBox(height: 15,),
                        Custom_Text(text: 'Video Link', text2: ' *',),
                        CustomTextFormField(controller: _videoLink,
                          hintText: 'Paste Youtube/video link',),
                        SizedBox(height: 15,),
                      ],
                    ),
                  ) // CustomTextFormField(controller: _videoLink,hintText: 'Paste Youtube/video link',);
                      : Container(),
                  SizedBox(height: 20,),


                  Column(
                    children: [
                      Container(
                        height: 150,
                        child: ListView.builder(
                            itemCount: controllersOfController.length,
                            itemBuilder: (context, index) =>
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(5),
                                              border: Border.all()
                                          ),
                                          child: TextFormField(
                                            controller: controllersOfController[index][0],
                                            decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 5),
                                                hintText: 'Title',
                                                border: InputBorder.none
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      Expanded(
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(5),
                                              border: Border.all()
                                          ),
                                          child: TextFormField(
                                            controller: controllersOfController[index][1],
                                            decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 5),
                                                hintText: 'Value',
                                                border: InputBorder.none
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                        ),
                      ),

                      Btn(
                        height: 45,
                        title: "Add",
                        onPress: () {
                          addToMyList();
                          List<TextEditingController> controlle1 = [];
                          controlle1.add(TextEditingController());
                          controlle1.add(TextEditingController());
                          controllersOfController.add(controlle1);
                          print('_____ssas_____${myList.join(', ')}_________');
                          setState(() {
                            // addData(controller1, controller2);
                          });
                        },
                      )
                    ],
                  ),


                  const SizedBox(height: 20,),
                  const Text(
                    'Additional Info', style: TextStyle(fontSize: 17),),
                  /*const SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: colors.primary,width: 1)
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: (){
                                setState(() {
                                  pressed=0;
                                });
                              },
                              child:(pressed==0)? const Text('General',style: TextStyle(fontSize: 17),):Text('General',style: TextStyle(fontSize: 17,color: Colors.grey.shade400),),
                            ),
                            // SizedBox(width: 20,),
                            // TextButton(
                            //   onPressed: (){
                            //     setState((){
                            //       pressed=1;
                            //     });
                            //   },
                            //   child:(pressed==1) ?Text('Attribute',style: TextStyle(fontSize: 17),):Text('Attribute',style: TextStyle(fontSize: 17,color: Colors.grey.shade400),),
                            // )
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       height: 5,
                        //       width: 90,
                        //       decoration: BoxDecoration(
                        //         color: (pressed==0)?colors.primary: Colors.grey.shade200,
                        //         borderRadius: BorderRadius.all(Radius.circular(5)),
                        //       ),
                        //     ),
                        //     Container(
                        //       height: 5,
                        //       width: 90,
                        //       decoration: BoxDecoration(
                        //         color: colors.primary,
                        //         borderRadius: BorderRadius.all(Radius.circular(5)),
                        //       ))
                        //   ],
                        // ),
                        // (pressed==1)?Container():
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15,),
                              Text('Type Of Product:',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                              SizedBox(height: 10,),
                              DropdownButtonFormField<String>(
                                value: prodType,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only( left: 20),
                                ),
                                hint: Text('Select Type',style:TextStyle(color: Colors.grey) ,),
                                icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,),
                                items:prodList.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    prodType= newValue!;
                                    if(newValue=='Simple Product'){
                                      product=1;
                                      print(newValue);
                                    }
                                    if(newValue!='Simple Product'){
                                      product=0;
                                    }

                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select an option';
                                  }
                                  return null;
                                },
                              ),
                              (product==1)?Container(
                                child: Column(
                                  children: [
                                    SizedBox(height: 15,),
                                    Custom_Text(text: 'Price', text2: ':'),
                                    CustomTextFormField(controller: _priceCtr, hintText: ''),
                                    SizedBox(height: 15,),
                                    Custom_Text(text: 'Special Price', text2: ':'),
                                    CustomTextFormField(controller: _specialpriceCtr, hintText: ''),
                                    SizedBox(height: 20,),


                                  ],
                                ),
                              ):Container(),

                              (product==1)?ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colors.primary,
                                  ),
                                  onPressed: (){}, child: Container(


                                  child: Text('Save Setting')))
                                  : (product==2)?ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colors.primary,
                                  ),
                                  onPressed: (){}, child: Container(


                                  child: Text('Save Setting')))
                                  :Container(),



                            ],
                          ),
                        ),

                      ],
                    ),
                  ),*/
                  SizedBox(height: 20,),
                  Custom_Text(text: 'Description', text2: '',),
                  SizedBox(height: 15,),
                  TextFormField(
                    maxLines: 3,
                    controller: _fullDesCtr,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Product Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product description';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20,),
                  Custom_Text(text: 'Extra Description', text2: '',),
                  SizedBox(height: 15,),
                  TextFormField(
                    maxLines: 5,
                    controller: _extraDesCtr,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Product Extra Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product Extra Description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  // Container(
                  //   height: 120,
                  //   child: ListView(
                  //     children: <Widget>[
                  //       Row(children: [
                  //         TextFormField(
                  //           decoration: InputDecoration(labelText: 'Field 1'),
                  //         ),
                  //         TextFormField(
                  //           decoration: InputDecoration(labelText: 'Field 2'),
                  //         ),
                  //         ...textFormFields,
                  //       ],),
                  //
                  //
                  //
                  //       ElevatedButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             textFormFields.add(
                  //              Row(
                  //                children: [
                  //                  TextFormField(
                  //                    controller: _shortDesCtr,
                  //                    decoration: InputDecoration(labelText: 'New Field'),
                  //                  ),
                  //                  TextFormField(
                  //                    controller: _extraDesCtr,
                  //                    decoration: InputDecoration(labelText: 'New Field'),
                  //                  ),
                  //                ],
                  //              )
                  //             );
                  //           });
                  //         },
                  //         child: Text('Add TextFormField'),
                  //       ),
                  //     ],
                  //   ),
                  // ),


                  Center(
                    child: Btn(
                        height: 50,
                        width: 150,
                        title: isLodding ? "please wait...":"Add Product",
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            addProductApi();
                          }
                        }
                    ),
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   alignment: Alignment.center,
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: Colors.green,
                  //       ),
                  //       onPressed: (){
                  //
                  //       }, child: Container(
                  //       child: Text('Add Product'))),
                  // )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController tagC = TextEditingController();

  addData(TextEditingController controller1, controller2) {
    return rows.add(
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all()
                  ),
                  child: TextFormField(
                    controller: controller1,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 5),
                        hintText: 'Title ',
                        border: InputBorder.none
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all()
                  ),
                  child: TextFormField(
                    controller: controller2,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 5),
                        hintText: 'Value',
                        border: InputBorder.none
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  List<Widget> textFormFields = [];
  List<Widget> rows = [];
  List <List<TextEditingController>> controllersOfController = [];


  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();


  TextEditingController nameC = TextEditingController();

 bool  isLodding  = false;
  addProductApi() async {
    setState(() {
      isLodding = true;
    });
    var headers = {
      'Cookie': 'ci_session=cab7ed449e294e8cd139fc530309156a2468b1d0'
    };
    var request = http.MultipartRequest('POST', Uri.parse(
        '${baseUrl}add_products'));
    request.fields.addAll({
      'seller_id': userId.toString(),
      'pro_input_name':_nameCtr.text,
      'short_description':_shortDesCtr.text,
      'tags': tagC.text,
      'pro_input_tax': 'tax_id',
      'indicator': '1',
      'made_in': 'ind',
      'hsn_code': '456',
      'brand': selectBrand ?? 'adidas',
      'total_allowed_quantity': '100',
      'minimum_order_quantity': '12',
      'quantity_step_size': '1',
      'warranty_period': '1 month',
      'guarantee_period': '1 month',
      'deliverable_type': '1',
      'deliverable_zipcodes': '1,2,3',
      'is_prices_inclusive_tax': '0',
      'cod_allowed': '1',
      'categorys_id': stateId ?? '1',
      'sub_cat_id': subCatId ?? '1',
      'product_type': 'simple_type',
      'pro_input_image': productImageUrl1?.split('.com/')[1] ?? '',
      'other_images': otherImageList.join(','),
      'attribute_values': '1',
      'simple_price': '4',
      'simple_special_price': '2',
      'attribute_title': myList.join(','),
      'attribute_value': myList.join(','),
      'short_description':_fullDesCtr.text,
      'description':_fullDesCtr.text,
      'extra_input_description':_extraDesCtr.text
    });
   print("------this ------------>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      otherImageList.clear();
      selectedSubCategory = null;
      productImageUrl1 = null;
      broncherImageUrl1 = null;
      getSubCatModel = null;
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");

      Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BHome()));

      setState(() {
        isLodding = false;
      });
    }

    else {
      setState(() {
        isLodding = false;
      });
      print(response.reasonPhrase);
    }
  }

addMedia() async {
  var headers = {
    'Cookie': 'ci_session=132520c09b577cf52b95da927b9b0491da5d3bda'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}upload_media'));
  request.files.add(await http.MultipartFile.fromPath('documents[]', '/C:/Users/indian 5/Downloads/no-image-icon.png'));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
  var result = await response.stream.bytesToString();
  var finalResult =  jsonDecode(result);

  }
  else {
  print(response.reasonPhrase);
  }

}
  List<String> myList = [];

  void addToMyList() {
  //  String text = controller1.text;
    for (int i=0;i<controllersOfController.length ; i++) {
      controllersOfController[i].forEach((element) {
        myList.add(element.text);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameCtr.dispose();
    _shortDesCtr.dispose();
    _fullDesCtr.dispose();
        _extraDesCtr.dispose();
    _videoLink.dispose();

  }
}
