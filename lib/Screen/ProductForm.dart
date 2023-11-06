import 'dart:convert';
import 'package:b2b/Constant/Constants.dart';
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

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({Key? key}) : super(key: key);

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  CategoryData? category;
  SubCategoryData? subCategory;

  List<CategoryData?> selectedCategory = [];
  List<SubCategoryData?> selectedSubCategory = [];

  void initState() {
    // TODO: implement initState
    super.initState();

    getuserId();
    getCategory();
    selectedCategory.add(category);
    selectedSubCategory.add(subCategory);
    allSubCategoryList.add(SubCategoryList);
    allProductList.add(productList);
    // getSubCategory();
    // getProductList();
  }
  Future<void> getuserId() async {

    final SharedPreferences sharedPreferences = await  SharedPreferences.getInstance();

    var idd  = sharedPreferences.getString('id');

    setState(() {
      userId=idd.toString();

      print('user id in form page page==========${userId}');
      print('user id in form page==========${userId.runtimeType}');
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

  getSubCategory( int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
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

      if(allSubCategoryList.isNotEmpty) {
        for (int i = 0; i < allSubCategoryList.length; i++) {
          if (i == index) {
            allSubCategoryList[index] = [];

          }
        }
        jsonResponse.data?.forEach((element) {
          allSubCategoryList[index].add(element);
        });
      }else {
        jsonResponse.data?.forEach((element) {
          allSubCategoryList[index].add(element);
        });
      }
      setState(() {
        getsubcategorymodel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  GetCategoryModel? getcategorymodel;

  getCategory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
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

      // String? category_id = jsonResponse.data?[0].id ?? "";
      // preferences.setString("category_id", category_id);
      setState(() {
        getcategorymodel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

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
  //   var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/B2B/seller/app/v1/api/get_product_list'));
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
  getProductList(int index) async {

    var param = {
      'cat_id': "${selectedCategory[index]?.id}",
      'sub_id': "${selectedSubCategory[index]?.id}"
    } ;

    apiBaseHelper.postAPICall(getProductListAPI, param).then((getData) {

      bool error = getData['error'];
      if(!error) {
        final jsonResponse =
        GetProductListModel.fromJson(getData);

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

  var selectedSateIndex;
  bool ? isProductSelected ;

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
      'sub_category_id': selectedSubCategory.map((subCategory) => subCategory?.id).join(', '),
      'category_id': selectedCategory.map((category) => category?.id).join(','),
      'product_id': productListTemp.join(',')
    } ;

    apiBaseHelper.postAPICall(getAddProductApi, param).then((getData) {

      bool error = getData['error'] ;
      String msg = getData['message'] ;

      if(!error){
        Fluttertoast.showToast(msg: msg);
        if(context.mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => B2BHome()));
      }else {
        Fluttertoast.showToast(msg: msg);
      }
    });


  }

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
            child: Center(child: CircularProgressIndicator())) : SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Purchase',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: colors.primary),),
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
                          child: Center(
                            child: const Text(
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
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: count,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 10, top: 15),
                        elevation: 4,
                        color: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        //alignment: Alignment.centerLeft,
                                        child: const Text(
                                          "Category Name",
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
                                                getSubCategory(index);
                                                //  getSubCategory();

                                                selectedCategory[index] =
                                                newValue!;
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(

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
                                                  child: Container(
                                                      child: Text(
                                                          item.name.toString())),
                                                );
                                              }).toList()
                                                  : allSubCategoryList[index]
                                                  .map((item) {
                                                return DropdownMenuItem(
                                                  value: item,
                                                  child: Container(
                                                      child: Text(
                                                          item.name.toString())),
                                                );
                                              }).toList(),
                                              onChanged:
                                                  (SubCategoryData? newValue) {
                                                setState(() {
                                                  selectedSubCategory[index] =
                                                  newValue!;
                                                  getProductList(index);
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
                                        title:productItem.isSelected ?? false ?  Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Container(

                                              padding: EdgeInsets.all(5),
                                              decoration:  BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.withOpacity(0.5)),
                                              child: Text(
                                                '${item}',
                                                style: const TextStyle(
                                                  color: colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ): Text(
                                          '${item}',
                                          style: const TextStyle(
                                            color: colors.black,
                                          ),
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
}
