import 'dart:convert';
import 'dart:developer';
import 'package:b2b/Constant/Constants.dart';
import 'package:b2b/Model/get_purchased_product_response.dart';
import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/AuthView/register.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:b2b/apiServices/apiStrings.dart';
import 'package:b2b/widgets/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Api.path.dart';
import '../Model/GetCategoryModel.dart';
import '../Model/GetProductListModel.dart';
import '../Model/GetSubCategoryModel.dart';
import '../color.dart';

// CategoryData? category;
var cityId;

CategoryData? categoryData;
ProductList? productList;

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  CategoryData? category;
  SubCategoryData? subCategory;

  List<CategoryData?> selectedCategory = [];
  List<SubCategoryData?> selectedSubCategory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getuserId();

    // getSubCategory();
    // getProductList();
  }

  Future<void> getuserId() async {

    final SharedPreferences sharedPreferences = await  SharedPreferences.getInstance();

    var idd  = sharedPreferences.getString('id');

    setState(() {


      userId= idd.toString();
      getPurchasedProduct ();

    });
  }

  String? item;
  int count = 1;


  List <List<ProductList>> allProductList = [] ;
  List<SubCategoryData> SubCategoryList = [];
  List<ProductList> productList = [];
  List <List<SubCategoryData>> allSubCategoryList = [] ;

  List<int> intList = [];

  bool isSelected = false;

  var category_id;
  GetSubCategoryModel? getsubcategorymodel;
  GetCategoryModel? getcategorymodel;



  // Future<GetProductListModel> getProductlist()async{
  //
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var headers = {
  //     'Cookie': 'ci_session=310c9f1c033583ae8f5715b224bf87e9c89ed3a8'
  //   };
  //   categoryId=preferences.getString("category_id");
  //   subCategory_id=preferences.getString("subcat_id");
  //
  //
  //   var request = http.MultipartRequest('POST', Uri.parse('Https://b2bdiary.com/App/V1/Api/get_product_list'));
  //   request.fields.addAll({
  //     'category_id': categoryId.toString(),
  //     'sub_cat_id':subCategory_id.toString()
  //   });
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //   var data=jsonDecode(response.request.toString());
  //
  //   if(response.statusCode==200){
  //
  //     return GetProductListModel.fromJson(data);
  //
  //   }else{
  //     print("========= Response 404  =============================");
  //     return GetProductListModel.fromJson(data);
  //   }
  // }

  String? subCategory_id;
  String? product_id;
  GetProductListModel? getProductListModel;
  ProductList? _productList;
  //late List<String> productList;

  var selectedSateIndex;
  bool ? isProductSelected ;


  void _onItemTap(ProductList productList) {
    setState(() {
      //  productList = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        appBar: customAppBar(context: context, text: 'Product Form', isTrue: false),
        // appBar: AppBar(
        //   backgroundColor: colors.primary,
        //   title: Text("Product Form"),
        // ),
        body: getcategorymodel == null ? Container(
            height: MediaQuery.of(context).size.height,
            child: const Center(child: CircularProgressIndicator())) : SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Purchase',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: colors.primary),),
                    GestureDetector(
                      onTap: () {
                        // print(categoryId);
                        // print(subCategory_id);
                        //getProductList();
                        selectedCategory.add(category);
                        selectedSubCategory.add(subCategory);
                        allSubCategoryList.add(SubCategoryList);
                        allProductList.add(productList);

                        setState(() {
                          count = count + 1;
                        });
                      },
                      child: Container(
                        //  alignment: Alignment.center,
                        //  margin: const EdgeInsets.only(left: 240,),
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: const Center(
                            child: Text(
                              "+ Add",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
               // height: MediaQuery.of(context).size.height,
               // width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: count,
                    itemBuilder: (context, index) {
                      return Stack(

                        children: [
                          Card(
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 10, top: 15),
                            elevation: 4,
                            color: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              // height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(

                                        children: [
                                          const Text(
                                            "Category Name",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width /
                                                2.67,
                                            height: 35,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              // borderRadius: BorderRadius.circular(10),
                                              // border:,
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButtonFormField<CategoryData>(
                                                onTap: () {
                                                  // getSubCategory();
                                                },
                                                decoration: const InputDecoration(
                                                  contentPadding: EdgeInsets.only(
                                                      bottom: 13.5, left: 20),
                                                ),
                                                value: selectedCategory[index],
                                                // underline: Container(),
                                                isExpanded: true,
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                hint: Text(
                                                  "Category",
                                                  style: TextStyle(
                                                      color: Colors.grey[400],
                                                      fontSize: 13),
                                                ),
                                                items: getcategorymodel?.data
                                                    ?.map((item) {
                                                  return DropdownMenuItem(
                                                    value: item,
                                                    child:
                                                    Text(item.name.toString()),
                                                  );
                                                }).toList(),
                                                onChanged: (CategoryData? newValue) {
                                                  // getSubCategory();
                                                  setState(() {

                                                    //  getSubCategory();

                                                    selectedCategory[index] =
                                                    newValue!;

                                                    getSubCategory(index,isSecondTime: true);
                                                    selectedSubCategory[index] = subCategory ;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              "Subcategory Name",
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
                                            width: MediaQuery.of(context).size.width /
                                                2.67,
                                            height: 35,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              // borderRadius: BorderRadius.circular(10),
                                              // border:,
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: InkWell(
                                                onTap: () {
                                                  //  getProductList();
                                                  //   Future.delayed(
                                                  //       Duration(milliseconds: 0), () {
                                                  //     return getSubCategory();
                                                  //   });
                                                  // getSubCategory();
                                                },
                                                child: DropdownButtonFormField<
                                                    SubCategoryData>(
                                                  onTap: () {
                                                    // getSubCategory();
                                                  },
                                                  decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.only(
                                                        bottom: 13.5, left: 20),
                                                  ),
                                                  value: selectedSubCategory[index],
                                                  // underline: Container(),
                                                  isExpanded: true,
                                                  icon:
                                                  const Icon(Icons.keyboard_arrow_down),
                                                  hint: Text(
                                                    "Subcategory",
                                                    style: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontSize: 13),
                                                  ),
                                                  items: allSubCategoryList.isEmpty ? <SubCategoryData>[].map((item) {
                                                    return DropdownMenuItem(
                                                      value: item,
                                                      child: Text(
                                                          item.name.toString()),
                                                    );
                                                  }).toList()
                                                      : allSubCategoryList[index]
                                                      .map((item) {
                                                    return DropdownMenuItem(
                                                      value: item,
                                                      child: Text(
                                                          item.name.toString()),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (SubCategoryData? newValue) {
                                                    setState(() {
                                                      selectedSubCategory[index] =
                                                      newValue!;
                                                      getProductList(index,isSecondTime: true);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height / 5,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    // child: subCategory==null
                                    // ?SizedBox()
                                    // :
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount:
                                        allProductList[index].length ?? 0,
                                        itemBuilder: (context, i) {
                                          // for(var i=0;i<=index;i++)
                                          //   {
                                          //     item=getProductListModel!.data![index].name;
                                          //
                                          //   }
                                          item = allProductList[index].elementAt(i).name;

                                          var productItem = allProductList[index].elementAt(i) ;
                                          /* _productList =
                                            getProductListModel!.data![index];*/

                                          return ListTile(
                                            // tileColor: intList.contains(index) ? Colors.blue : null,
                                            title: productItem.isSelected ?? false ?
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration:  BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.withOpacity(0.5)),
                                                  child: Text(
                                                    '${item}',
                                                    style: TextStyle(
                                                      color: colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                                : Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Text(
                                                  '${item}',
                                                  style: TextStyle(
                                                    color: colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              setState(() {

                                                if(allProductList[index].elementAt(i).name == 'Select all' && !(allProductList[index].elementAt(i).isSelected ?? false)){
                                                  allProductList[index].forEach((element) {
                                                    element.isSelected = true ;
                                                  });
                                                }else {
                                                  allProductList[index].elementAt(i).isSelected =  ! (allProductList[index].elementAt(i).isSelected ?? false );
                                                  allProductList[index].elementAt(0).isSelected = false ;

                                                }




                                              });

                                            },
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5,
                              right: 0,

                              child: InkWell(
                                onTap: (){
                                  selectedCategory.removeAt(index);
                                  selectedSubCategory.removeAt(index);
                                  allSubCategoryList.removeAt(index);
                                  allProductList.removeAt(index);

                                  setState(() {
                                    count = count - 1;
                                  });
                                },
                                child: Container(decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15), color: Colors.red),child: const Icon(Icons.highlight_remove_outlined, color: colors.white,),),
                              ))
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: 40,
          width: 80,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: colors.primary,
            onPressed:() {
              // getSubCategory();
              // getCategory();
              if(selectedCategory.first == null || selectedSubCategory.first == null)
              {
                Fluttertoast.showToast(msg: "Category can't be null");
              }else {
                getSubmit();
              }
            },
            // isExtended: true,
            child: const Text(
              "Submit",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );


  }



  GetPurchasedProductResponse? purchasedProductResponse ;

  Future<void> getPurchasedProduct () async{

   var param = {
   'user_id': userId,
   } ;


   apiBaseHelper.postAPICall(getPurchasedProductListAPI, param).then((getData) {

     bool error = getData['error'];
     if(!error) {
       final jsonResponse =
       GetPurchasedProductResponse.fromJson(getData);

       purchasedProductResponse = jsonResponse ;

       for(int i=0; i<(jsonResponse.purchaesData?.length ?? 0); i++){

         selectedCategory.add(category);
         selectedSubCategory.add(subCategory);
         allSubCategoryList.add(SubCategoryList);
         allProductList.add(productList);

         count = jsonResponse.purchaesData?.length ?? 0 ;
       }
       getCategory();


     }else {
       getCategory();
     }

   });

 }

  getCategory() async {
    var headers = {
      'Cookie': 'ci_session=ea5681bb95a83750e0ee17de5e4aa2dca97184ef'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${ApiService.getCategory}'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =

      GetCategoryModel.fromJson(json.decode(finalResponse));
      if(allProductList.first.isEmpty) {
        for (int i = 0;
            i < (purchasedProductResponse?.purchaesData?.length ?? 0);
            i++) {
          jsonResponse.data?.forEach((element) {
            if (purchasedProductResponse?.purchaesData?[i].categoryId
                    .toString() ==
                element.id.toString()) {
              selectedCategory[i] = element;
              getSubCategory(i);
            }
            //
          });
        }
      }

      // String? category_id = jsonResponse.data?[0].id ?? "";
      // preferences.setString("category_id", category_id);
      setState(() {
        getcategorymodel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  getSubCategory( int index, {bool? isSecondTime }) async {
    var headers = {
      'Cookie': 'ci_session=2296e23bc97342ca9bd4e7b07616951c7d466d1e'
    };
    //   category_Id=preferences.getString("category_id");

    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getSubCategory}'));
    request.fields.addAll({
      'cat_id': "${selectedCategory[index]?.id}",
      // 'sub_id' : "${subCategory!.id.toString()}"
    });
    print("get subcategoryyyy parameter ${request.fields}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
      GetSubCategoryModel.fromJson(json.decode(finalResponse));

      if (allSubCategoryList.isNotEmpty) {
        for (int i = 0; i < allSubCategoryList.length; i++) {
          if (i == index) {
            allSubCategoryList[index] = [];
          }
        }
        jsonResponse.data?.forEach((element) {
          allSubCategoryList[index].add(element);
        });
      } else {
        jsonResponse.data?.forEach((element) {
          allSubCategoryList[index].add(element);
        });
      }
      if (!(isSecondTime ?? false)){
        for (int i = 0; i <
            (purchasedProductResponse?.purchaesData?.length ?? 0); i++) {
          jsonResponse.data?.forEach((element) {
            //  print('${element.id == purchasedProductResponse?.purchaesData?[i].subCategoryId}______________');
             print('${element.id}______elementId2________');
            if (element.id.toString().trim() ==
                purchasedProductResponse?.purchaesData?[i].subCategoryId
                    .toString().trim()) {
              print('${element.id}______elementId________');



              selectedSubCategory[i] = element;

            }
          });
          getProductList(i);
        }
    }else{
        //getProductList(index);
      }


      setState(() {
        getsubcategorymodel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  getProductList(int index, {bool? isSecondTime}) async {

    var param = {
      'cat_id': "${selectedCategory[index]?.id}",
      'sub_id': "${selectedSubCategory[index]?.id}"
    } ;

    apiBaseHelper.postAPICall(getProductListAPI, param).then((getData) {

      bool error = getData['error'];
      if(!error) {
        final jsonResponse =
        GetProductListModel.fromJson(getData);
      if(!(isSecondTime ?? false)) {
          for (int i = 0;
              i < (purchasedProductResponse?.purchaesData?.length ?? 0);
              i++) {
            jsonResponse.data?.forEach((element) {
              if (purchasedProductResponse?.purchaesData?[i].products
                      ?.toString()
                      .contains(element.name.toString()) ??
                  false) {
                element.isSelected = true;
              }
            });
          }
        }

        if(allProductList.isNotEmpty) {
          for (int i = 0; i < allProductList.length; i++) {
            if (i == index) {
              allProductList[index] = [];
            }
          }
          jsonResponse.data?.forEach((element) {
            allProductList[index].add(element);
          });
          allProductList[index].insert(0,ProductList(name: 'Select all'));
        }else {
          jsonResponse.data?.forEach((element) {
            allProductList[index].add(element);
          });
        }

        setState(() {

        });
      }else {}

    });
  }

  getSubmit() async {
    List <String> productListTemp = [] ;

    allProductList.forEach((element) {
      //isProductSelected = false ;

      if(element.isNotEmpty) {
        element.forEach((e) {
          // print('___________${element.length}__________');
          if (e.isSelected ?? false) {
            isProductSelected = true;
            productListTemp.add(e.name ?? '');
          }else {

          }
        });
      }else {
        productListTemp.add('ALL');
      }

      if (!(isProductSelected ?? false)) {
        productListTemp.add('ALL');
      }
    });



    var param = {
      'user_id': userId.toString(),
      'purchase_sub_id': selectedSubCategory.map((subCategory) => subCategory?.id).join(','),
      'purchase_cat_id': selectedCategory.map((category) => category?.id).join(','),
      'product_name': productListTemp.join(',')
    } ;
    print('______assdasdas____${param}_________');
    apiBaseHelper.postAPICall(updateProductApi, param).then((getData) {

      bool error = getData['error'] ;
      String msg = getData['message'] ;

      if(!error){
        Fluttertoast.showToast(msg: msg);
        if(context.mounted) Navigator.pop(context);
      }else {
        Fluttertoast.showToast(msg: msg);
      }
    });


  }
}
