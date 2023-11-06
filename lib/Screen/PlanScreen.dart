import 'dart:convert';

import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/apiServices/apiBasehelper.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../Api.path.dart';
import '../Model/PlansModel.dart';
import '../color.dart';
import '../widgets/Appbar.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}
ApiBaseHelper apiBaseHelper=ApiBaseHelper();
class _PlanScreenState extends State<PlanScreen> {
  @override


  Razorpay? _razorpay;
  int? pricerazorpayy;
  @override
  void initState() {
    // TODO: implement initState
    getPlanDetail();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  // List<DataListPlan>  getPlan = [];


  PlansModel? plansModel;
  getPlanDetail() async {
    var headers = {
      'Cookie': 'ci_session=434027e3658c98f6bd1d5717d757ed6bb45592d4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}plans'));
    request.headers.addAll(headers);
    request.fields.addAll({
      'user_id': userId.toString()
    });
    print('____sdcsdsf______${request.fields}_________');
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       var result = await response.stream.bytesToString();
       var finalResult = PlansModel.fromJson(jsonDecode(result));
       setState(() {
         plansModel = finalResult;
       });
       for(var i=0;i<plansModel!.data!.length;i++){
       }
    }
    else {
    print(response.reasonPhrase);
    }

  }

  getplanPurchaseSuccessApi() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? userId = preferences.getString('userId');
    // String? role = preferences.getString('roll');
    var headers = {
      'Cookie': 'ci_session=ea151b5bcdbac5bedcb5f7c9ab074e9316352d04'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}subscription'));
    request.fields.addAll({
      'plan_id':id,
      'user_id': userId.toString(),
    });
    print('_____fields_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      final finalResult = json.decode(result);
      Fluttertoast.showToast(msg: finalResult['message'],backgroundColor: colors.secondary);

      setState(() {

      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BHome()));
    }
    else {
      print(response.reasonPhrase);
    }
  }
  String id = '';
  void openCheckout(amount) async {
    double res = double.parse(amount.toString());
    pricerazorpayy= int.parse(res.toStringAsFixed(0)) * 100;
    print("checking razorpay price ${pricerazorpayy.toString()}");

    print("checking razorpay price ${pricerazorpayy.toString()}");
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "${pricerazorpayy}",
      'name': 'B2B',
      'image':'assets/splash/splashimages.png',
      'description': 'B2B',
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }
  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Subscription added successfully",backgroundColor: colors.secondary);
     getplanPurchaseSuccessApi();
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }
  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment cancelled by user",backgroundColor: colors.secondary);
    // setSnackbar("ERROR", context);
    // setSnackbar("Payment cancelled by user", context);
  }
  void _handleExternalWallet(ExternalWalletResponse response) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Subscription Plan", isTrue: true, ),
      body: Column(
        children: [
          plansModel == null  || plansModel == ""?Center(child: CircularProgressIndicator()):
          Container(
            height: MediaQuery.of(context).size.height/1.2,
            width: double.infinity,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: plansModel!.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      if(plansModel!.data![index].isPurchased ?? false){
                        Fluttertoast.showToast(msg: "You all ready purchased plan",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor:colors.secondary,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }else{
                        openCheckout(plansModel!.data![index].price);
                        id =plansModel!.data![index].id ?? '' ;
                      }
                    },
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              elevation: 5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: MediaQuery.of(context).size.width/1.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("Images/plan.jpg"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child:  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 200,),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${plansModel!.data![index].title}",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: colors.black),
                                          ),
                                        ),
                                           SizedBox(height: 20,),
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text("₹ ${plansModel!.data![index].price}",style: TextStyle(color: colors.primary,fontWeight: FontWeight.bold,fontSize: 20,decoration: TextDecoration.lineThrough,
                                                 decorationThickness: 2, ),),
                                               SizedBox(height: 5,),
                                               Text("₹ ${plansModel!.data![index].sellingPrice}",style: TextStyle(color: colors.primary,fontWeight: FontWeight.bold,fontSize: 20,
                                                 decorationThickness: 2,),),
                                             ],
                                           ),
                                        SizedBox(height: 20,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 30),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                   Image.asset("Images/rightcheck.png",height: 20,width: 20,),
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    "${plansModel!.data![index].planCat}",
                                                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20,color: colors.black.withOpacity(0.5)),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 100,left: 20,top: 20),
                                                child: MySeparator(),
                                              ),
                                              SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Image.asset("Images/rightcheck.png",height: 20,width: 20,),
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    "${plansModel!.data![index].subCat}",
                                                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20,color: colors.black.withOpacity(0.5)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5,),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 100,left: 20,top: 10),
                                                child: MySeparator(),
                                              ),
                                              SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Image.asset("Images/rightcheck.png",height: 20,width: 20,),
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    "${plansModel!.data![index].benifits} Contacts",
                                                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20,color: colors.black.withOpacity(0.5)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        //
                                        // SizedBox(height: 8),
                                        // Text( "${plansModel!.data![index].duration} Days",style: TextStyle(color: colors.black),),
                                        // SizedBox(height: 8),
                                        // Text( "${plansModel!.data![index].description}"),
                                        // SizedBox(height: 8),

                                        SizedBox(height: 80),
                                        plansModel!.data![index].isPurchased == true ? Padding(
                                          padding: const EdgeInsets.only(left: 50,right: 20),
                                          child: Container(
                                            height: 50,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  stops: [0.1, 0.7,],
                                                  colors: [
                                                    colors.primary,
                                                    colors.primary

                                                  ],
                                                ),
                                                //color: colors.secondary,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(child: Text("Purchased",style: TextStyle(color: colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
                                          ),
                                        ):Padding(
                                          padding: const EdgeInsets.only(left: 50,right: 20),
                                          child: Container(
                                            height: 50,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  stops: [0.1, 0.7,],
                                                  colors: [
                                                    colors.primary,
                                                    colors.primary

                                                  ],
                                                ),
                                                //color: colors.secondary,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(child: Text("Buy Now",style: TextStyle(color: colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),


                          ),
                        )
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

}
class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.grey})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
