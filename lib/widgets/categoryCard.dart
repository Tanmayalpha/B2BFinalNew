import 'package:b2b/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget categoryCard(BuildContext context,  String image, String title ){
  return Card(
    margin: const EdgeInsets.all(4),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3)),
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          // homeCategory?.data?[index].image == null
          image == ''
              ? const Text("-", style: TextStyle(color: colors.white),)
              : Image.network(
            image,
            height: MediaQuery.of(context).size.height/10,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8,
            ),
          ),
        ],
      ),
    ),
  );
}


Widget productsCard(
    {
  required BuildContext context,
  String? productName,
  String? businessName,
  String? storeName,
  String?textName,
  String?sub,
  String? image,
  String? address,
  String? title,
  required VoidCallback onTap}) {
  return Container(
    margin: const EdgeInsets.all(10),
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height / 4.2,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image ?? '',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 24, top: 25),
            child:  Text(
              productName ?? '',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: [
              Container(
              margin: const EdgeInsets.only(left: 24, top: 10),
              child: Row(
                children:  [
                  CircleAvatar(
                      backgroundColor: colors.primary,
                      radius: 10,
                      child: Icon(Icons.person_rounded,color: colors.white,size: 15,)),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("${storeName}" ?? ''),
                ],
              ),
            ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("(${''})",style: TextStyle(color: colors.black,fontWeight: FontWeight.bold),),
              )
            ],
          ),

          Container(
            margin: const EdgeInsets.only(left: 24, top: 5),
            child: Row(
              children:  [
                const CircleAvatar(
                  radius: 10,
                  backgroundColor: colors.primary,
                  child: Icon(
                    Icons.location_pin,size: 15,
                    color: colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    width: 180,
                    child: Text("${address}" ??"",overflow: TextOverflow.ellipsis,maxLines: 1,)),
              ],
            ),
          ),
          Container(
            margin:
            const EdgeInsets.only(left: 20, top: 5, right: 20),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.smart_display_rounded,
                        color: Colors.red,
                      ),
                    ),
                    Text("Watch Video")
                  ],
                ),
                Row(
                  children: const [
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.image,
                          color: colors.primary,
                        )),
                    Text("Broucher Image")
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 90,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(50)),
                      color: Colors.deepPurple),
                  child: Icon(
                    Icons.add_circle,size: 15,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)),
                      color: Colors.deepPurple),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 5, right: 5, top: 3, bottom: 3),
                    child: Icon(
                      Icons.message,size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(6)),
                      color: colors.secondary),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 5, right: 5, top: 3, bottom: 3),
                    child: Icon(
                      Icons.mail_outline,size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),

                Container(
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(50)),
                      color: colors.primary),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 5, right: 5, top: 3, bottom: 3),
                    child: Icon(
                      Icons.location_pin,size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),

                Container(
                  height: MediaQuery.of(context).size.height/20,
                  width: MediaQuery.of(context).size.width/3,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      border: Border.all(width: 2, color: Colors.grey),
                      color: colors.white),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    children:  [
                      Container(
                        height: 25,
                        width: 25,
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(50)),
                            color: textName == "" ?  colors.primary : colors.secondary),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 3, bottom: 3),
                          child: Icon(
                            Icons.description,size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      Container(
                        height: 25,
                        width: 25,
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(50)),
                          color: sub == 1 ? colors.primary : colors.secondary
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 3, bottom: 3),
                          child: Icon(
                            Icons.check_circle_outline,size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 25,
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(50)),
                           color:sub == 1 ? colors.primary : colors.secondary
                          ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 3, bottom: 3),
                          child: Icon(
                            Icons.verified_user,size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 50,
          ),
          InkWell(
            onTap: onTap,
            child: Center(
              child: Container(
                // margin:EdgeInsets.only(left: 24,top: 10),
                width: 220,
                height: 42,
                decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(10)),
                child:  Center(
                    child: Text(
                      title ?? '' ,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
        ],
      ),
    ),
  );
}



Widget supplierOrClientCard (
    {required BuildContext context,
    String? sellerName,
    String? image,
    String? productName, String? address, String? title, required VoidCallback onTap }) {
  return Container(
    margin: const EdgeInsets.all(20),
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height / 4.2,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  image ?? '',
                  fit: BoxFit.fill,
                ),
              ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 24, top: 25),
            child:  Text(
              productName ?? '',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 24, top: 10),
            child: Row(
              children:  [
                const Icon(Icons.person_rounded),
                const SizedBox(
                  width: 10,
                ),
                Text(sellerName ?? ''),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 24, top: 5),
            child: Row(
              children:  [
                const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(address ??""),
              ],
            ),
          ),
          Container(
            margin:
            const EdgeInsets.only(left: 20, top: 5, right: 20),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.smart_display_rounded,
                        color: Colors.red,
                      ),
                    ),
                    Text("Watch Video")
                  ],
                ),
                Row(
                  children: const [
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.image,
                          color: colors.primary,
                        )),
                    Text("Broucher Image")
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 90,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              children: [
                const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.indigoAccent,
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(6)),
                      color: Colors.deepPurple),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 5, right: 5, top: 3, bottom: 3),
                    child: Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(6)),
                      color: Colors.green),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 5, right: 5, top: 3, bottom: 3),
                    child: Icon(
                      Icons.mail_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
                const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.white,
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height/20,
                    width: MediaQuery.of(context).size.width/3,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        border: Border.all(width: 2, color: Colors.grey),
                        color: Colors.indigo),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: const [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor:
                          Colors.orangeAccent,
                          child: Icon(
                            Icons.description,
                            color: Colors.white,
                          ),
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.lightBlue,
                          child: Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                          ),
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.verified_user,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 50,
          ),
          InkWell(
            onTap: onTap,
            child: Center(
              child: Container(
                // margin:EdgeInsets.only(left: 24,top: 10),
                width: 220,
                height: 42,
                decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(10)),
                child:  Center(
                    child: Text(
                      title ?? '' ,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
        ],
      ),
    ),
  );
}