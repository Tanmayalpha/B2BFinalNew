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
import '../Model/Get_faq_model.dart';
import '../apiServices/apiConstants.dart';
import '../apiServices/apiStrings.dart';
import '../color.dart';
import '../utils/GetPreference.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  void initState() {
    super.initState();
    getFaqApi();
  }

String text1="What is your name";
  String text2="Hello";
  GetFaqModel? getFaqModel;
  getFaqApi() async {
    var headers = {
      'Cookie': 'ci_session=7a102c26a4e8ec3e9011e124dc3f68822f2ff281'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_faqs'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       var result =  await response.stream.bytesToString();
       var finalResult = GetFaqModel.fromJson(json.decode(result));
       setState(() {
         getFaqModel = finalResult;
       });
    }
    else {
    print(response.reasonPhrase);
    }
  }
  int? selected = 0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:customAppBar(context: context, text: "FAQ", isTrue: false),
      body:getFaqModel?.data == null ? Center(child: CircularProgressIndicator()):  getFaqModel?.data?.length == 0 ?Text("No Awareness"): Container(
        height: MediaQuery.of(context).size.height/1,
        child: ListView.builder(
          key: Key('builder ${selected.toString()}'),
          itemCount:getFaqModel?.data?.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: colors.black)
                ),
                child: ExpansionTile(
                  textColor: colors.black,
                  iconColor: colors.primary,
                  collapsedTextColor: colors.black,
                  collapsedIconColor: colors.black,
                  key:  Key(index.toString()),
                  initiallyExpanded: index == selected ,
                  title: Row(
                    children: [
                      SizedBox(width: 5,),
                      Text('${getFaqModel?.data?[index].question}'),
                    ],
                  ),
                  onExpansionChanged: (isExpanded) {
                    if(isExpanded) {
                      setState(()  {
                        const Duration(milliseconds: 2000);
                        selected = index;
                      });
                    }else{
                      setState(() {
                        selected = -1;
                      });
                    }
                  },
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                          width: 350,
                          child: Text("${getFaqModel!.data![index].answer}",overflow: TextOverflow.ellipsis,maxLines: 10,style: TextStyle(color: colors.black),)),
                    )

                  ],
                ),

              ),

            );

          },

        ),
      ),

      // SingleChildScrollView(
      //   child: Column(
      //     children:   [
      //       SizedBox(height: 15),
      //    Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           Container(
      //             width: MediaQuery.of(context).size.width ,
      //             height: 45,
      //             margin: EdgeInsets.all(20),
      //             decoration:  BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius:BorderRadius.all(Radius.circular(4)),
      //                 border: Border.all(
      //                     color: colors.black.withOpacity(0.2)
      //                 )
      //               // border:,
      //             ),
      //             child: DropdownButtonHideUnderline(
      //               child: DropdownButtonFormField<String>(
      //                 onTap: () {
      //                   // getSubCategory();
      //                 },
      //
      //                 decoration: InputDecoration(
      //                     contentPadding: EdgeInsets.only(
      //                         bottom: 13.5, left: 20),
      //                     border: InputBorder.none
      //                 ),
      //                 value:text1,
      //                 // underline: Container(),
      //                 isExpanded: true,
      //                 icon: const Icon(
      //                     Icons.keyboard_arrow_down),
      //                 hint: Text(
      //                   "What is your name",
      //                   style: TextStyle(
      //                       color: Colors.grey[400],
      //                       fontSize: 13),
      //                 ),
      //                 items: ["What is your name","my name is pradip kumar patel"]
      //                     .map<DropdownMenuItem<String>>(
      //                       (e) => DropdownMenuItem(
      //                     value: e,
      //                     child: Text(e),
      //                   ),
      //                 )
      //                     .toList(),
      //                 onChanged: (String? value) => setState(
      //                       () {
      //                         text1="What is your name";
      //                   },
      //                 ),
      //               ),
      //             ),
      //           ),
      //
      //           Container(
      //             width: MediaQuery.of(context).size.width ,
      //             height: 45,
      //             margin: EdgeInsets.only(left: 20,right: 20),
      //             decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius:BorderRadius.all(Radius.circular(4)),
      //                 border: Border.all(
      //                     color: colors.black.withOpacity(0.2)
      //                 )
      //             ),
      //             child: DropdownButtonHideUnderline(
      //               child: DropdownButtonFormField<String>(
      //                 onTap: () {
      //                   // getSubCategory();
      //                 },
      //                 decoration:InputDecoration(
      //                     contentPadding: EdgeInsets.only(
      //                         bottom: 13.5, left: 20),
      //                     border: InputBorder.none
      //                 ),
      //
      //                 value:text2,
      //                 // underline: Container(),
      //                 isExpanded: true,
      //                 icon: const Icon(
      //                     Icons.keyboard_arrow_down),
      //                 hint: Text(
      //                   "Hello",
      //                   style: TextStyle(
      //                       color: Colors.grey[400],
      //                       fontSize: 13),
      //                 ),
      //                 items:["Hello","https://www.youtube.com/watch?v=H59OJfVBi30"]
      //                     .map<DropdownMenuItem<String>>(
      //                       (e) => DropdownMenuItem(
      //                     value: e,
      //                     child: Text(e),
      //                   ),
      //                 )
      //                     .toList(),
      //                 onChanged: (String? value) => setState(
      //                       () {
      //                         text2="Hello";
      //                   },
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }


}
