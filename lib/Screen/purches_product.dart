import 'dart:convert';

import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/Screen/updatePurchesProduct.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:flutter/material.dart';

import '../Model/getPurchesProductModel.dart';
import '../color.dart';
import '../widgets/Appbar.dart';
import 'package:http/http.dart' as http;

class GetPurches extends StatefulWidget {
  const GetPurches({Key? key}) : super(key: key);

  @override
  State<GetPurches> createState() => _GetPurchesState();
}

class _GetPurchesState extends State<GetPurches> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5,),(){

      getData();

    });



  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        bottomSheet: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePurchesProduct(),));
          },
          child: Container(height: 60,


          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.primary),
            child: Center(child: Text('Update Product',style: TextStyle(fontWeight: FontWeight.w500),),)
            ,
          ),
        ),
      appBar: customAppBar(text: "Purchase Product",isTrue: false, context: context),
      body:

      getPurchesProductModel == null  ||  getPurchesProductModel == ""? Center(child: CircularProgressIndicator()): getPurchesProductModel!.purchaesData?.length == 0 ?Center(child: Text("No Product Found!!"),):  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
              itemCount: getPurchesProductModel?.purchaesData?.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,i) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text( "Purches Product : ${getPurchesProductModel!.purchaesData?[i].name}"),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );


  }
  GetPurchesProductModel?getPurchesProductModel;
  Future<void> getData() async {

    var headers = {
      'Cookie': 'ci_session=2cf0dd46837cc989e8d6c6b0e74176357ce90405'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_purchsae_product'));
    request.fields.addAll({
      'user_id': userId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =await response.stream.bytesToString();
      var finalResult=jsonDecode(result);
      if(finalResult['error']==false){

    var finalresult1=GetPurchesProductModel.fromJson(finalResult);
       setState(() {
         getPurchesProductModel=finalresult1;
       });

      }
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
