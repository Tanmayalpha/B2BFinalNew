import 'dart:convert';

import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:b2b/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../Constant/Constants.dart';
import '../Model/Get_product_model.dart';
import '../utils/GetPreference.dart';
import '../widgets/Appbar.dart';
import 'Product_Update.dart';

class GetProductScreen extends StatefulWidget {
  const GetProductScreen({Key? key}) : super(key: key);

  @override
  State<GetProductScreen> createState() => _GetProductScreenState();
}

class _GetProductScreenState extends State<GetProductScreen> {
  @override
  void initState() {
    getProductApi();
    super.initState();
  }

  GetProductModel? getProductModel;

  getProductApi() async {
    // String? userId = await getString(key: 'id');
    var headers = {
      'Cookie': 'ci_session=be1a4874400517fa367c64ea9c8d9c09c8964614'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}get_products'));
    request.fields.addAll({
      'seller_id': userId.toString()
      // 'seller_id': userId.toString()
    });
    print('_____saasss_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetProductModel.fromJson(jsonDecode(result));
      setState(() {
        getProductModel = finalResult;
        print('_____surendra_____${finalResult}______${result}___');
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(text: "Product", isTrue: false, context: context),
      body: getProductModel == null
          ? const Center(
              child: CircularProgressIndicator(
              color: colors.primary,
            ))
          : getProductModel!.data!.length == 0
              ? const Center(
                  child: Text("No Product Found!!"),
                )
              : SingleChildScrollView(
                  child: RefreshIndicator(
                      onRefresh: () {
                        return Future.delayed(const Duration(seconds: 2), () {
                          getProductApi();
                        });
                      },
                      child: ListView.builder(
                          itemCount: getProductModel!.data!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            print(
                                '${getProductModel!.data![i].image}___________');
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 100,
                                        height: 90,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              "${getProductModel!.data![i].image}",
                                              fit: BoxFit.fill,
                                            ))),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        //mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${getProductModel!.data![i].name}"),
                                          const SizedBox(
                                            height: 1,
                                          ),
                                          /*Text("₹ ${getProductModel!.data![i].variants![0].price}",style: const TextStyle(
                                  color: colors.black,fontWeight: FontWeight.bold
                              ),),*/
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateProduct(
                                                        pId: getProductModel!
                                                                .data![i]
                                                                .variants![0]
                                                                .productId ??
                                                            "",
                                                      ))).then((value) {
                                                        if(value !=null){
                                                          getProductApi();
                                                        }
                                          });
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: colors.primary,
                                        )),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          deleteAccountDailog(
                                            getProductModel!.data![i]
                                                    .variants![0].productId ??
                                                "",
                                          );
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: colors.primary,
                                        )),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })),
                ),
    );
  }

  deleteAccountDailog(String? pId) async {
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          content: const Text("Are you sure you want to delete?",
              style: TextStyle(color: colors.primary)),
          actions: <Widget>[
            TextButton(
                child: const Text(
                  "NO",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                }),
            TextButton(
                child: const Text(
                  "YES",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  //deleteSendOTP();
                  deleteApi(pId);
                  Navigator.pop(context);
                  //deleteAccount();
                  //Navigator.of(context).pop(false);
                  // SettingProvider settingProvider =
                  // Provider.of<SettingProvider>(context, listen: false);
                  // settingProvider.clearUserSession(context);
                  // //favList.clear();
                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  //     '/home', (Route<dynamic> route) => false);
                })
          ],
        );
      });
    }));
  }

  deleteApi(String? Id) async {
    var headers = {
      'Cookie': 'ci_session=e1d1dc3b7f210a0a186df7cf75f17a2c051d249a'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}delete_product'));
    request.fields.addAll({'product_id': Id.toString()});
    print('______sasdsd____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      getProductApi();
    } else {
      print(response.reasonPhrase);
    }
  }
}
