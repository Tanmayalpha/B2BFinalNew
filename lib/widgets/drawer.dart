// import 'dart:convert';
// import 'package:b2b/Screen/Add_Product.dart';
// import 'package:b2b/Screen/FAQ.dart';
// import 'package:b2b/Screen/HomeScreen.dart';
// import 'package:b2b/Screen/PrivacyPolicy.dart';
// import 'package:b2b/Screen/login.dart';
// import 'package:b2b/Screen/myProfile.dart';
// import 'package:b2b/color.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../Constant/Constants.dart';
// import '../Model/DeleteAccountModel.dart';
// import '../Screen/AllCommunity.dart';
// import '../Screen/PlanScreen.dart';
// import '../Screen/get_product_screen.dart';
// import '../apiServices/apiBasehelper.dart';
//
// getDrawer(BuildContext context, String name, String email, String profile) {
//   return Container(
//     color: Colors.white,
//     width: MediaQuery.of(context).size.width/1.3,
//     child: ListView(
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           height: 120,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [colors.primary, colors.primary],
//             ),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             // main
//             children: [
//               Image.network("${profile}"),
//               //  CircleAvatar(
//               //   radius: 40,
//               //   backgroundImage: NetworkImage(
//               //     profile,
//               //   ),
//               // ),
//               const SizedBox(
//                 width: 10,
//               ),
//               // userModel == null || userModel!.data == null
//               //     ? SizedBox.shrink()
//               //     :
//               InkWell(
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
//                 },
//                 child: Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Row(
//                         children:  [
//                           Text(
//                             name,
//                             style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           const Icon(Icons.edit,color: colors.white,size: 15,),
//                           SizedBox(
//                             height: 3,
//                           ),
//                         ],
//                       ),
//                        SizedBox(
//                         width: 150,
//                         child: Text(
//                           email,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 13),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 2,
//                       ),
//                       /*getprofile?.user?.userData?.first.placeName == null ? Text("Vijay Nagar",style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 13,
//                           fontWeight: FontWeight.normal),) : Text("${getprofile?.user?.userData?.first.placeName}",style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 13,
//                           fontWeight: FontWeight.normal),
//                       )*/
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [
//                 colors.white,
//                 colors.primary,
//               ],
//             ),
//           ),
//           // child: ListTile(
//           //   leading: Container(
//           //     decoration: BoxDecoration(
//           //         color: Colors.white,
//           //         borderRadius: BorderRadius.circular(50)),
//           //     child: const Icon(Icons.person)
//           //   ),
//           //   title: const Text(
//           //     ' My Profile',
//           //   ),
//           //   onTap: () {
//           //     Navigator.push(context, MaterialPageRoute(builder: (Context) => Container()));
//           //     // Navigator.push(
//           //     //   context,
//           //     //   MaterialPageRoute(builder: (context) => HomeScreen()),
//           //     // );
//           //   },
//           // ),
//         ),
//         ListTile(
//           leading: const Icon(Icons.home),
//           title: const Text(
//             'Home',
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => B2BHome()),
//             );
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.add),
//           title: const Text(
//             'Add Product',
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => AddProduct()),
//             );
//           },
//         ),
//
//         ListTile(
//           leading: const Icon(Icons.add_shopping_cart),
//           title: const Text(
//             'Product List',
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => GetProductScreen()),
//             );
//           },
//         ),
//         ListTile(
//           leading: Image.asset("Images/plans.png",height: 25,width: 20 ,color: Colors.grey,),
//           title: const Text(
//             'Plans',
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => PlanScreen()),
//             );
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.info),
//           title: const Text(
//             'Terms &Conditions',
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Container()),
//             );
//           },
//         ),
//         ListTile(
//           leading: Image.asset("Images/community.png",height: 30,width: 20 ,color: Colors.grey,),
//           title: const Text(
//             'Community',
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => AllCommunity()),
//             );
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.info_outline_rounded),
//           title: const Text(
//             'Privacy Policy',
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => PrivacyPolicy()),
//             );
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.chat),
//           title: const Text(
//             'FAQ',
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => FAQ()),
//             );
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.share),
//           title: const Text(
//             'Share App',
//           ),
//           onTap: () {
//             //share();
//             //   Navigator.push(
//             //     context,
//             //     MaterialPageRoute(builder: (context) => HomeScreen()),
//             //   );
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.delete),
//           title: const Text(
//             'Delete Account',
//           ),
//           onTap: () {
//             // deleteAccount();
//             //share();
//             //   Navigator.push(
//             //     context,
//             //     MaterialPageRoute(builder: (context) => HomeScreen()),
//             //   );
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.logout),
//           title: const Text(
//             'Sign Out',
//           ),
//           onTap: () async {
//             showDialog(
//                 context: context,
//                 barrierDismissible: false,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Text("Confirm Sign out"),
//                     content: const Text("Are  sure to sign out from app now?"),
//                     actions: <Widget>[
//                       ElevatedButton(
//                         style:
//                         ElevatedButton.styleFrom(primary: colors.primary),
//                         child: const Text("YES"),
//                         onPressed: () async {
//                           SharedPreferences prefs =
//                           await SharedPreferences.getInstance();
//                             prefs.clear();
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LoginPage()),
//                           );
//                         },
//                       ),
//                       ElevatedButton(
//                         style:
//                         ElevatedButton.styleFrom(primary: colors.primary),
//                         child: const Text("NO"),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ],
//                   );
//                 });
//           },
//         ),
//       ],
//     ),
//   );
// }
//
// // Future<DeleteAccountModel?> deleteAccount() async {
// //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
// //   var sessionId= sharedPreferences.getString('id');
// //   var header = headers;
// //   var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/B2B/seller/app/v1/api/delete_account'));
// //   request.fields.addAll({
// //     'user_id': '${sessionId}'
// //   });
// //   print("User id in delet account ${request.fields}");
// //   request.headers.addAll(header);
// //   http.StreamedResponse response = await request.send();
// //   if (response.statusCode == 200) {
// //     print("responseeeee ${response}");
// //     final str = await response.stream.bytesToString();
// //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
// //     var data  = DeleteAccountModel.fromJson(json.decode(str));
// //     setSnackbar(data.message.toString());
// //     return DeleteAccountModel.fromJson(json.decode(str));
// //   } else {
// //     return null;
// //   }
// // }
//
// // deleteAccountDailog() async {
// //   await dialogAnimate(context,
// //       StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
// //         return StatefulBuilder(
// //             builder: (BuildContext context, StateSetter setStater) {
// //               return AlertDialog(
// //                 shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.all(Radius.circular(5.0))),
// //                 content: Text(
// //                     "Are you you want to delete account",
// //                     style: TextStyle(color: Colors.black)
// //                 ),
// //                 actions: <Widget>[
// //                   TextButton(
// //                       child: Text(
// //                           "No",
// //                           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
// //                       ),
// //                       onPressed: () {
// //                         Navigator.of(context).pop(false);
// //                       }),
// //                   TextButton(
// //                       child: Text(
// //                           "Yes",
// //                           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
// //                       ),
// //                       onPressed: () {
// //                         deleteAccount();
// //                       })
// //                 ],
// //               );
// //             });
// //       }));
// // }