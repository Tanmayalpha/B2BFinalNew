import 'dart:convert';

import 'package:b2b/apiServices/apiConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:video_player/video_player.dart';
import '../Model/Get_our_model.dart';
import '../color.dart';
import '../widgets/Appbar.dart';

class OurActivity extends StatefulWidget {
  const OurActivity({Key? key}) : super(key: key);

  @override
  State<OurActivity> createState() => _OurActivityState();
}

class _OurActivityState extends State<OurActivity> {
  @override
  void initState() {
    // TODO: implement initState
    getOurActivityApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(text: "Our Activity",isTrue: false, context: context),
      body:getOurModel == null || getOurModel == "" ? Center(child: CircularProgressIndicator()): getOurModel!.data!.length == 0 ? Text("No our activity found!!!"): SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: getOurModel!.data!.length,
            itemBuilder: (context,i){
            var  showData = getOurModel!.data![i];
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text("${showData.message}",style: const TextStyle(color: colors.black,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  showData.image == null ||  showData.image  == ""? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                      child: Image.asset("Images/no-image-icon.png",height: 200,width:double.infinity,fit: BoxFit.fill,)) :SizedBox(
                    width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                          child: Image.network("${showData.image}",fit: BoxFit.fill,))),
                  const SizedBox(height: 20,),
                   Container(
                  //  height:MediaQuery.of(context).size.height/3.2,
                    margin: const EdgeInsets.only(bottom: 10),
                    child:
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                                height:MediaQuery.of(context).size.height/3.5,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:getOurModel!.data![i].video == null ?Image.asset("Images/videodefault.png",height: 200,width:double.infinity,fit: BoxFit.fill,): AspectRatio(aspectRatio: _vController[i].value.aspectRatio,child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: VideoPlayer(_vController[i])),)),
                            const SizedBox(height: 10,),

                          ],
                        ),
                        Positioned(
                            left: 1,right: 1,
                            top: -10,
                            bottom: 1,
                            child: isPlayed[i] == true ? InkWell(
                                onTap: (){
                                  setState(() {
                                    isPlayed[i] = false;
                                    _vController[i].pause();
                                  });
                                },
                                child: Icon(Icons.pause,color: Colors.white,)) : InkWell(
                                onTap: (){
                                  setState(() {
                                    isPlayed[i] = true;
                                   _vController[i].play();
                                  });
                                },
                                child: Icon(Icons.play_arrow,color: Colors.white,))),

                      ],
                    ),


                    // Stack(
                    //   children: [
                    //     // _showThumbnail ==  true
                    //     //     ? Image.network(
                    //     //   'https://developmentalphawizz.com/dr_booking/uploads/media/2023/Is-Sensodyne-world’s-no-1-sensitivity-toothpaste-2_(1).jpg',
                    //     //   // Replace 'thumbnail_url_here' with the actual URL of the thumbnail image
                    //     //   width: double.infinity,
                    //     //   height: double.infinity,
                    //     //   fit: BoxFit.cover,
                    //     // ):
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Container(
                    //           width: MediaQuery.of(context).size.width,
                    //           height: 220,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(10),
                    //             color: colors.secondary,
                    //           ),
                    //           child: Column(
                    //             children: [
                    //               Container(
                    //                   height:180,
                    //                   width: MediaQuery.of(context).size.width,
                    //                   decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(10),
                    //                   ),
                    //                   child: AspectRatio(aspectRatio: _vController[index].value.aspectRatio,child: ClipRRect(
                    //                       borderRadius: BorderRadius.circular(10),
                    //                       child: VideoPlayer(_vController[index])),)),
                    //              const SizedBox(height: 10,),
                    //              Column(
                    //                crossAxisAlignment: CrossAxisAlignment.start,
                    //                children: [
                    //                  Text("${getAwareNess?.data.video?[index].title}",style: const TextStyle(color: colors.whiteTemp),),
                    //
                    //                ],
                    //              )
                    //
                    //             ],
                    //           )),
                    //     ),
                    //     Positioned(
                    //         left: 1,right: 1,
                    //         top: 0,
                    //         bottom: 1,
                    //         //alignment: Alignment.center,
                    //         child: isPlayed[index] == true ? InkWell(
                    //             onTap: (){
                    //               setState(() {
                    //                 isPlayed[index] = false;
                    //                 _vController[index].pause();
                    //               });
                    //             },
                    //             child: Icon(Icons.pause,color: Colors.white,)) : InkWell(
                    //             onTap: (){
                    //               setState(() {
                    //                 isPlayed[index] = true;
                    //                 _vController[index].play();
                    //               });
                    //             },
                    //             child: Icon(Icons.play_arrow,color: Colors.white,))),
                    //
                    //   ],
                    // ),
                  ),

              ],
              ),
            ),
          );
        }),
      )
    );
  }
  late List<VideoPlayerController> _vController = [];
  List<bool> isPlayed = [];

  getVideoList(model, int index){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height:MediaQuery.of(context).size.height/3,
        margin: const EdgeInsets.only(bottom: 10),
        child:
        Stack(
          alignment: Alignment.center,
          children: [
            Container( decoration: BoxDecoration(
              color: colors.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
              height:MediaQuery.of(context).size.height/3,
              child: Column(
                children: [
                  Container(
                      height:MediaQuery.of(context).size.height/3.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AspectRatio(aspectRatio: _vController[index].value.aspectRatio,child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: VideoPlayer(_vController[index])),)),
                  const SizedBox(height: 10,),

                ],
              ),
            ),
            Positioned(
                left: 1,right: 1,
                top: -10,
                bottom: 1,
                //alignment: Alignment.center,
                child: isPlayed[index] == true ? InkWell(
                    onTap: (){
                      setState(() {
                        isPlayed[index] = false;
                        _vController[index].pause();
                      });
                    },
                    child: Icon(Icons.pause,color: Colors.white,)) : InkWell(
                    onTap: (){
                      setState(() {
                        isPlayed[index] = true;
                        _vController[index].play();
                      });
                    },
                    child: Icon(Icons.play_arrow,color: Colors.white,))),
            // VideoPlayer(_vController[index]),

          ],
        ),


        // Stack(
        //   children: [
        //     // _showThumbnail ==  true
        //     //     ? Image.network(
        //     //   'https://developmentalphawizz.com/dr_booking/uploads/media/2023/Is-Sensodyne-world’s-no-1-sensitivity-toothpaste-2_(1).jpg',
        //     //   // Replace 'thumbnail_url_here' with the actual URL of the thumbnail image
        //     //   width: double.infinity,
        //     //   height: double.infinity,
        //     //   fit: BoxFit.cover,
        //     // ):
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Container(
        //           width: MediaQuery.of(context).size.width,
        //           height: 220,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: colors.secondary,
        //           ),
        //           child: Column(
        //             children: [
        //               Container(
        //                   height:180,
        //                   width: MediaQuery.of(context).size.width,
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(10),
        //                   ),
        //                   child: AspectRatio(aspectRatio: _vController[index].value.aspectRatio,child: ClipRRect(
        //                       borderRadius: BorderRadius.circular(10),
        //                       child: VideoPlayer(_vController[index])),)),
        //              const SizedBox(height: 10,),
        //              Column(
        //                crossAxisAlignment: CrossAxisAlignment.start,
        //                children: [
        //                  Text("${getAwareNess?.data.video?[index].title}",style: const TextStyle(color: colors.whiteTemp),),
        //
        //                ],
        //              )
        //
        //             ],
        //           )),
        //     ),
        //     Positioned(
        //         left: 1,right: 1,
        //         top: 0,
        //         bottom: 1,
        //         //alignment: Alignment.center,
        //         child: isPlayed[index] == true ? InkWell(
        //             onTap: (){
        //               setState(() {
        //                 isPlayed[index] = false;
        //                 _vController[index].pause();
        //               });
        //             },
        //             child: Icon(Icons.pause,color: Colors.white,)) : InkWell(
        //             onTap: (){
        //               setState(() {
        //                 isPlayed[index] = true;
        //                 _vController[index].play();
        //               });
        //             },
        //             child: Icon(Icons.play_arrow,color: Colors.white,))),
        //
        //   ],
        // ),
      ),
    );
  }

  GetOurModel? getOurModel;
  getOurActivityApi() async {
    var headers = {
      'Cookie': 'ci_session=a5bdf0fa0910366f0bff353d95b4d349cfbedafd'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}our_activities'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetOurModel.fromJson(jsonDecode(result));
      setState(() {
        getOurModel =  finalResult;
      });
      for(var i=0;i<finalResult.data!.length;i++){
        _vController.add(VideoPlayerController.network(finalResult.data![i].video.toString())..initialize().then((value){
          setState(() {
          });
        }));
        isPlayed.add(false);
        print("video controller length ${_vController.length}----------${_vController}");
      }

    }
    else {
    print(response.reasonPhrase);
    }

  }
}
