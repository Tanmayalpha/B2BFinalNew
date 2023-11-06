import 'package:flutter/material.dart';
class FurnitureDescription extends StatefulWidget {
  const FurnitureDescription({Key? key, this.image, this.loc, this.price, this.product_name}) : super(key: key);
  final  String? image,loc,price,product_name;

  @override
  State<FurnitureDescription> createState() => _FurnitureDescriptionState();
}

class _FurnitureDescriptionState extends State<FurnitureDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.red[300] ,
        title:Text("Product Detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              child: Image.asset(widget.image.toString(),
                fit: BoxFit.contain,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10,),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox( height:10),
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(widget.product_name.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),),
                      ),
                      SizedBox( height:6),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child:Row(
                          children: [
                            Icon(Icons.currency_rupee_rounded,size: 15,
                              weight:800,
                              color: Colors.black,),
                            Text(widget.price.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),),
                          ],
                        ),

                      ),
                      SizedBox( height:6),
                      Container(
                        margin: EdgeInsets.only(left: 19),
                        alignment: Alignment.centerLeft,
                        child: Text("From: ${widget.loc.toString()}",
                          style: TextStyle(fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),),
                      ),
                      SizedBox( height:10),
                      Center(
                        // alignment: Alignment.centerLeft,
                        // margin: EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            SizedBox( width:21),

                            ElevatedButton(
                              onPressed: () {},

                              child: Row(
                                children: [
                                  Icon(Icons.chat_outlined,size: 15,
                                      weight:800,
                                      color:  Color(0xffE57373)),
                                  SizedBox( width:6),
                                  Text("Message Us", style:TextStyle(fontSize: 14,
                                      color:  Color(0xffE57373))),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                  width: 1.5,
                                  color: Color(0xffE57373),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft:Radius.circular(30),bottomLeft:Radius.circular(30)),
                                ),),
                            ),

                            SizedBox( width:6),
                            ElevatedButton(
                              onPressed: () {},

                              child: Row(
                                children: [
                                  Icon(Icons.call,size: 15,
                                    weight:800,
                                    color: Colors.white,),
                                  SizedBox( width:6),
                                  Text("Call Us", style:TextStyle(fontSize: 16,)),
                                  SizedBox( width:40),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[300],

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight:Radius.circular(30))
                                  )),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromRGBO(118, 120, 122, 0.5),
                    width: 1.0,
                  ),
                  bottom: BorderSide(
                    color: Color.fromRGBO(118, 120, 122, 0.5),
                    width: 1.0,
                  ),
                ),
              ),
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,


                  color: Color.fromRGBO(118, 120, 122, 0.3),
                  alignment: Alignment.centerLeft,

                  child: Padding(
                    padding: const EdgeInsets.only(left: 21.0),
                    child: Text(
                      'Product Description',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: DataTable(
                dividerThickness: 0,
                columnSpacing:50 ,
                headingRowHeight: 0,

                columns: const [
                  DataColumn(
                    label: Text(''),
                  ),

                  DataColumn(
                      label: Text('')),

                ],
                rows: [

                  DataRow(cells: [
                    DataCell(Text('Product Name',
                      style: TextStyle(fontWeight: FontWeight.normal,
                          color:Colors.grey.shade600,
                          fontSize:14),)),
                    DataCell(Text(widget.product_name.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold,
                          color:Colors.black,
                          fontSize:14),)),
                  ]),
                  DataRow(
                      color: MaterialStateProperty.all(Color.fromRGBO(118, 120, 122, 0.1),),
                      cells: [
                        DataCell(Text('Material',
                          style: TextStyle(fontWeight: FontWeight.normal,
                              color:Colors.grey.shade600,
                              fontSize:14),)),
                        DataCell(Text('Wooden',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color:Colors.black,
                              fontSize:14),)),
                      ]),
                  DataRow(cells: [
                    DataCell(Text('Seating Capacity',
                      style: TextStyle(fontWeight: FontWeight.normal,
                          color:Colors.grey.shade600,
                          fontSize:14),)),
                    DataCell(Text('8',
                      style: TextStyle(fontWeight: FontWeight.bold,
                          color:Colors.black,
                          fontSize:14),)),
                  ]),
                  DataRow(
                      color: MaterialStateProperty.all(Color.fromRGBO(118, 120, 122, 0.1),),
                      cells: [
                        DataCell(Text('Usage/Aplication',
                          style: TextStyle(fontWeight: FontWeight.normal,
                              color:Colors.grey.shade600,
                              fontSize:14),)),
                        DataCell(Text('School and Office',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color:Colors.black,
                              fontSize:14),)),
                      ]),
                  DataRow(cells: [
                    DataCell(Text('Country of Origin',
                      style: TextStyle(fontWeight: FontWeight.normal,
                          color:Colors.grey.shade600,
                          fontSize:14),)),
                    DataCell(Text('Made in India',
                      style: TextStyle(fontWeight: FontWeight.bold,
                          color:Colors.black,
                          fontSize:14),)),
                  ]),
                ],
              ),
            ),

            Container(
                margin: EdgeInsets.all(16),
                child:Text(
                  "Our Comprehensive and innovative range of products is designed to enhance comfort and we are provide best quality products at a good price.",
                  style: TextStyle(fontWeight: FontWeight.normal,
                      color:Colors.black,
                      fontSize:16),
                )
            ),
            Center(
              child: Row(
                children: [
                  SizedBox( width:30),

                  ElevatedButton(
                    onPressed: () {},

                    child: Row(
                      children: [
                        Icon(Icons.chat_outlined,size: 15,
                            weight:800,
                            color:  Color(0xffE57373)),
                        SizedBox( width:6),
                        Text("Message Us", style:TextStyle(fontSize: 14,
                            color:  Color(0xffE57373))),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        width: 1.5,
                        color: Color(0xffE57373),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(30),bottomLeft:Radius.circular(30)),
                      ),),
                  ),

                  SizedBox( width:6),
                  ElevatedButton(
                    onPressed: () {},

                    child: Row(
                      children: [
                        Icon(Icons.call,size: 15,
                          weight:800,
                          color: Colors.white,),
                        SizedBox( width:6),
                        Text("Call Us", style:TextStyle(fontSize: 16,)),
                        SizedBox( width:40),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[300],

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight:Radius.circular(30))
                        )),
                  ),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
