import 'dart:convert';

import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:b2b/widgets/Appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/Enquir_model.dart';

class EnquiryList extends StatefulWidget {
  const EnquiryList({Key? key}) : super(key: key);

  @override
  State<EnquiryList> createState() => _EnquiryListState();
}

class _EnquiryListState extends State<EnquiryList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEnquirListApi();
  }
  EnquirModel? enquirModel;
  getEnquirListApi() async {
    var headers = {
      'Cookie': 'ci_session=1781142861f1b85438a816447e7d63bfe6b7391c'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_inquery_list'));
    request.fields.addAll({
      'user_id':userId.toString()
    });
   print('_____scsd_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       var result = await response.stream.bytesToString();
       var finalResult = EnquirModel.fromJson(jsonDecode(result));
       setState(() {
         enquirModel =  finalResult;
       });
    }
    else {
    print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  customAppBar(context: context, text: "Enquiry", isTrue: false),
      body: RefreshIndicator(
          onRefresh:() {
            return Future.delayed(const Duration(seconds: 2), () {
              getEnquirListApi();
            });
          },
        child: ListView.builder(
          itemCount: 1,
            itemBuilder: (context,i){
              return  SingleChildScrollView(
                child:
                enquirModel == null  ||  enquirModel == "" ? const Center(child: CircularProgressIndicator()):
                enquirModel!.data!.length == 0 ? const Center(child: Text("No Enquiry Found!!")):
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: enquirModel?.data?.length ?? 0,
                      itemBuilder: (context,i){
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Name : ",style: TextStyle(fontWeight: FontWeight.bold,),),
                                      Text("${enquirModel!.data![i].name}")
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Mobile : ",style: TextStyle(fontWeight: FontWeight.bold,),),
                                      Text("${enquirModel!.data![i].mobile}")
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("City : ",style: TextStyle(fontWeight: FontWeight.bold,),),
                                      Text("${enquirModel!.data![i].city}")
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Date : ",style: TextStyle(fontWeight: FontWeight.bold,),),
                                      Text("${enquirModel!.data![i].createdAt!.substring(0,11)}")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }


        ),
      ),
    );
  }
}
