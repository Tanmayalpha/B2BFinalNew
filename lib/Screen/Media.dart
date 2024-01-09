// import 'dart:convert';
//
// import 'package:b2b/Model/GetCommunityModel.dart';
// import 'package:b2b/Model/GetCountriesModel.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
// import '../Model/MediaModel.dart';
// import '../apiServices/apiConstants.dart';
// import '../color.dart';
// import '../utils/GetPreference.dart';
// import 'CommunityScreen.dart';
//
// class MediaScreen extends StatefulWidget {
//   const MediaScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MediaScreen> createState() => _MediaScreenState();
// }
//
// class _MediaScreenState extends State<MediaScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     getMedia();
//   }
//
//
//   List mediaData =[];
//   bool isLoading = false;
//
//   getMedia() async {
//     setState(() {
//       isLoading = true;
//     });
//     String? userId = await getString(key: 'id');
//     Map<String, dynamic> params = {
//       'seller_id': '${userId}'
//     };
//     print("parametere ${params}");
//     var response = await http.post(Uri.parse('Https://b2bdiary.com/App/V1/Api/get_media'), body: params);
//     var jsonResponse = convert.jsonDecode(response.body);
//     if (jsonResponse['error'] == false) {
//       setState(() {
//         mediaData = jsonResponse['data'];
//       });
//      print("media api response ${jsonResponse}");
//       print('mediaaa responseeee${mediaData}_________');
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: colors.primary,
//         centerTitle: true,
//         title: const Text("Media"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 10,),
//             ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: mediaData.length,
//                 // itemCount: getCommunityModel?.data?.length,
//                 itemBuilder: (context, index){
//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityScreen(image: mediaData[index]['image'], fromMedia: true,)));
//                     },
//                     child: Card(
//                       elevation: 4,
//                       child: Container(
//                         height: 120,
//                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
//                         padding: const EdgeInsets.all(14.0),
//                         child: Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                            mediaData[index]['image'] == null ||  mediaData[index]['image'] == "" ? Text("--"):
//                             Container(
//                               height: 85,
//                               width: 85,
//                               // color: Colors.green,
//                               child: Image.network("${mediaData[index]['image']}", height: 100, width: 100, fit: BoxFit.cover,),
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width/33,
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text('Name : ' + mediaData[index]['name']),
//                                     Text('Sub Directory : ' + mediaData[index]['sub_directory']),
//                                     Text('Extension : ' + mediaData[index]['extension']),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/widgets/Appbar.dart';
import 'package:b2b/widgets/appButton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/MediaModelNew.dart';
import '../apiServices/apiConstants.dart';
import '../apiServices/apiStrings.dart';
import '../color.dart';
import 'Add_Product.dart';
import 'package:http/http.dart' as http;

class Media extends StatefulWidget {
  final from, pos;

  const Media({Key? key, this.from, this.pos}) : super(key: key);

  @override
  _MediaState createState() => _MediaState();
}

class _MediaState extends State<Media> with TickerProviderStateMixin {

  String? productImageUrl;
  String? broncherImageUrl;
  bool _isNetworkAvail = true;
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  bool scrollLoadmore = true, scrollGettingData = false, scrollNodata = false;
  int scrollOffset = 0;
  List<MediaModel> mediaList = [];
  List<MediaModel> tempList = [];
  List<MediaModel> selectedList = [];

  ScrollController? scrollController;
  late List<String> variantImgList = [];
  late List<String> variantImgUrlList = [];

  late List<String> otherImgList = [];
  late List<String> otherImgUrlList = [];

  @override
  void initState() {
    super.initState();
    scrollOffset = 0;
    getMedia();
    buttonController =  AnimationController(duration:  Duration(milliseconds: 2000), vsync: this);
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController!.addListener(_transactionscrollListener);

    buttonSqueezeanimation = new Tween(
      // begin: width * 0.7,
      end: 50.0,
    ).animate(
      new CurvedAnimation(
        parent: buttonController!,
        curve: new Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }

  _transactionscrollListener() {
    if (scrollController!.offset >=
        scrollController!.position.maxScrollExtent &&
        !scrollController!.position.outOfRange) {
      if (mounted)
        setState(
              () {
            scrollLoadmore = true;
            getMedia();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: customAppBar(context: context, text: "Media", isTrue: true),
         appBar: getAppBar("Add Media",context),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _showImageSourceDialog(context);
          },
            child: const Icon(Icons.add)),
        body: _showContent());
  }

  _showContent() {
    return
      Column(
        children: [
          Expanded(
            child: ListView.builder(

              controller: scrollController,
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.only(
                  bottom: 5, start: 10, end: 10),
              itemCount: mediaList.length,
              itemBuilder: (context, index) {



                MediaModel? item;
                item = mediaList.isEmpty ? null : mediaList[index];
                return item == null ? Container() : getMediaItem(index);



              },
            ),
          ),
          scrollGettingData
              ? Padding(
            padding: EdgeInsetsDirectional.only(top: 5, bottom: 5),
            child: CircularProgressIndicator(),
          )
              : Container(),
        ],

      );
  }

  getAppBar(String title, BuildContext context) {
    return AppBar(
      centerTitle: true,
      titleSpacing: 0,
      backgroundColor: colors.white,
      leading: Builder(
        builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.all(10),
            // decoration: BoxDecoration(
            //     border: Border.all(color: colors.primary)
            // ),
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () => Navigator.of(context).pop(),
              child: Center(
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: colors.primary,
                  size: 30,
                ),
              ),
            ),
          );
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          color: colors.primary,
        ),
      ),
      actions: [
        (widget.from == "other" || widget.from == 'variant')
            ? TextButton(
            onPressed: () {
              if (widget.from == "other") {
                // otherPhotos.addAll(otherImgList);
                // otherImageUrl.addAll(otherImgUrlList);
              } else if (widget.from == 'variant') {
                // variationList[widget.pos].images = variantImgList;
                // variationList[widget.pos].imagesUrl = variantImgUrlList;
              }
              Navigator.pop(context,otherImgUrlList);
            },
            child: Text('Done',style: TextStyle(color: colors.primary),))
            : Container()
      ],
    );
  }

  Widget noInternet(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // noIntImage(),
            // noIntText(context),
            // noIntDec(context),
            Btn(
              title: "fdggfdg",
              // btnAnim: buttonSqueezeanimation,
              // btnCntrl: buttonController,
              onPress: () async {
                _playAnimation();

                Future.delayed(Duration(seconds: 2)).then(
                      (_) async {
                    //_isNetworkAvail = await isNetworkAvailable();
                    if (_isNetworkAvail) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                              super.widget)).then((value) {
                        setState(() {});
                      });
                    } else {
                      await buttonController!.reverse();
                      if (mounted) setState(() {});
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  Future<void> getMedia() async {
    //_isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      if (scrollLoadmore) {
        if (mounted) {
          setState(() {
            scrollLoadmore = false;
            scrollGettingData = true;
            if (scrollOffset == 0) {
              mediaList = [];
            }
          });
        }

        try {
          var parameter = {
          'seller_id': "1",
            // LIMIT: perPage.toString(),
            // OFFSET: scrollOffset.toString(),

            // SEARCH: _searchText.trim(),
          };

          if (widget.from == "video") {
            parameter["type"] = "video";
          }
          Response response =
          await post(getMediaApi, body: parameter,).timeout(Duration(seconds: timeOut));
          var getdata = json.decode(response.body);
          print('____asasasas______${getMediaApi}_____${parameter}____');
          bool error = getdata["error"];
          String? msg = getdata["message"];
          // total = int.parse(getdata["total"]);
          scrollGettingData = false;
          if (scrollOffset == 0) scrollNodata = error;
          if (!error) {
            tempList.clear();
            var data = getdata["data"];
            print('_____sdsdfsdfds_____${data.length}____sdfsfsdfs_____');
            if (data.length != 0) {
              tempList = (data as List)
                  .map((data) => new MediaModel.fromJson(data))
                  .toList();
              mediaList.addAll(tempList);
              scrollLoadmore = true;
              //scrollOffset = scrollOffset + perPage;
            } else {
              scrollLoadmore = false;
            }
          } else {
            scrollLoadmore = false;
          }
          if (mounted)
            setState(() {
              scrollLoadmore = false;
            });
        } on TimeoutException catch (_) {
          setSnackbar("gjgjhghj");
          setState(() {
            scrollLoadmore = false;
          });
        }
      }
    } else {
      if (mounted)
        setState(() {
          _isNetworkAvail = false;
          scrollLoadmore = false;
        });
    }
  }

  setSnackbar(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: colors.primary,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  getMediaItem(int index) {
    return Card(
      child: InkWell(
        onTap: () {

          setState(() {
            print('___ASasAS_______${widget.from}_________');
            mediaList[index].isSelected = !mediaList[index].isSelected;
            if (widget.from == "main") {
              // productImage = mediaList[index].subDic! + "" + mediaList[index].name!;
              productImageUrl = mediaList[index].image!;
              Navigator.pop(context,productImageUrl);
            } else if (widget.from == "video") {
              //uploadedVideoName = mediaList[index].subDic! + "" + mediaList[index].name!;
              Navigator.pop(context);
            } else if (widget.from == "other") {
              if (mediaList[index].isSelected) {
                print('if');
                otherImgList.add(mediaList[index].subDic! + "" + mediaList[index].name!);
                otherImgUrlList.add(mediaList[index].image!.split('B2B')[1]);
                print(otherImgUrlList);
              } else {
                print('else');
                otherImgList.remove(mediaList[index].subDic! + "" + mediaList[index].name!);
                otherImgUrlList.remove(mediaList[index].image!.split('B2B')[1]);
                print(otherImgUrlList);

              }
            }
            else if(widget.from=='Broncherimage'){
              print('===========bronger image');
              broncherImageUrl = mediaList[index].image!;
              Navigator.pop(context,broncherImageUrl);

            }





            else if (widget.from == 'variant') {

              if (mediaList[index].isSelected) {
                print('if');
                variantImgList.add(mediaList[index].subDic! + "" + mediaList[index].name!);
                variantImgUrlList.add(mediaList[index].image!);
              } else {
                print('else');

                variantImgList.remove(mediaList[index].subDic! + "" + mediaList[index].name!);
                variantImgUrlList.remove(mediaList[index].image!);
              }
            }

          });



        },
        child: Stack(
          children: [
            Row(
              children: [
                Image.network(
                  mediaList[index].image!,
                  height: 200,
                  width: 200,
                  //errorBuilder: (context, error, stackTrace) => erroWidget(200),
                  color: Colors.black
                      .withOpacity(mediaList[index].isSelected ? 1 : 0),
                  colorBlendMode: BlendMode.color,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name : ' + mediaList[index].name!),
                        Text('Sub Directory : ' + mediaList[index].subDic!),
                        Text('Size : ' + mediaList[index].size!),
                        Text('extension : ' + mediaList[index].extention!),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.black
                  .withOpacity(mediaList[index].isSelected ? 0.1 : 0),
            ),
            mediaList[index].isSelected
                ? Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check_circle,
                  color: colors.primary,
                ),
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }


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
                chooseImage(ImageSource.gallery);
              },
              child: Text('Gallery'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                chooseImage(ImageSource.camera);
              },
              child: Text('Camera'),
            ),
          ],
        );
      },
    );
  }

// getAppBar(String title, BuildContext context) {
//   return AppBar(
//     titleSpacing: 0,
//     backgroundColor: white,
//     leading: Builder(
//       builder: (BuildContext context) {
//         return Container(
//           margin: const EdgeInsets.all(10),
//           decoration: DesignConfiguration.shadow(),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(circularBorderRadius5),
//             onTap: () => Navigator.of(context).pop(),
//             child: const Center(
//               child: Icon(
//                 Icons.keyboard_arrow_left,
//                 color: primary,
//                 size: 30,
//               ),
//             ),
//           ),
//         );
//       },
//     ),
//     title: Text(
//       title,
//       style: const TextStyle(
//         color: grad2Color,
//       ),
//     ),
//     actions: [
//       (widget.from == "other" ||
//           widget.from == 'variant' ||
//           (widget.from == "main" && widget.type == "add"))
//           ? TextButton(
//         onPressed: () {
//           if (widget.from == "other") {
//             if (widget.type == "add") {
//               // add.otherPhotos.addAll(otherImgList);
//               // add.otherImageUrl.addAll(otherImgUrlList);
//               for (var element in mediaProvider!.mediaList) {
//                 if (element.isSelected) {
//                   add.addProvider!.otherPhotos.add(element.path!);
//                   add.addProvider!.otherImageUrl.add(element.image!);
//                 }
//               }
//             }
//             if (widget.type == "edit") {
//               edit.editProvider!.otherPhotos
//                   .addAll(mediaProvider!.otherImgList);
//               if (edit.editProvider!.showOtherImages.isNotEmpty) {
//                 if (mediaProvider!.otherImgList.isNotEmpty) {
//                   for (int i = 0;
//                   i < edit.editProvider!.showOtherImages.length;
//                   i++) {
//                     edit.editProvider!.showOtherImages.removeLast();
//                   }
//                 }
//               }
//               edit.editProvider!.showOtherImages
//                   .addAll(mediaProvider!.otherImgUrlList);
//             }
//           } else if (widget.from == 'variant') {
//             if (widget.type == "add") {
//               add.addProvider!.variationList[widget.pos].images =
//                   mediaProvider!.variantImgList;
//               add.addProvider!.variationList[widget.pos].imagesUrl =
//                   mediaProvider!.variantImgUrlList;
//               add.addProvider!.variationList[widget.pos]
//                   .imageRelativePath =
//                   mediaProvider!.variantImgRelativePath;
//             }
//             if (widget.type == "edit") {
//               edit.editProvider!.variationList[widget.pos].images =
//                   mediaProvider!.variantImgList;
//               edit.editProvider!.variationList[widget.pos].imagesUrl =
//                   mediaProvider!.variantImgUrlList;
//               edit.editProvider!.variationList[widget.pos]
//                   .imageRelativePath =
//                   mediaProvider!.variantImgRelativePath;
//             }
//           }
//           Routes.pop(context);
//         },
//         child: Text(
//           getTranslated(context, "Done")!,
//         ),
//       )
//           : Container()
//     ],
//   );
// }

  final ImagePicker _imagePicker = ImagePicker() ;
  List <XFile?> list  = [] ;
  Future<void> chooseImage(ImageSource source) async {
    XFile? image ;
    if(source == ImageSource.gallery){
       list = await _imagePicker.pickMultiImage(maxWidth:600,maxHeight:600);
    }else {
       image =  await _imagePicker.pickImage(source: source,maxWidth:600,maxHeight:600 );
       list.add(image);
    }

    if(list.isNotEmpty){
      uplaodeImageToServer() ;
    }

  }


  uplaodeImageToServer() async{
    var headers = {
      'Cookie': 'ci_session=3ca670457a58a29b557230b2f82b897ca54ca7e0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}upload_media'));
    request.fields.addAll({
      'seller_id': userId ?? '74'
    });

    for (var element in list) {

      request.files.add(await http.MultipartFile.fromPath('documents[]', element?.path ?? ''));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

    var result = await response.stream.bytesToString();
    var finalresult = jsonDecode(result);

    if(!(finalresult['error'])) {
      scrollLoadmore= true ;
      setState(() {});
      getMedia();
    }else{
      Fluttertoast.showToast(msg: finalresult['message']);
    }
    }
    else {
    print(response.reasonPhrase);
    }

  }

}
