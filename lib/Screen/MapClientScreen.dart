import 'dart:async';
import 'package:b2b/Model/Get_cat_by_product_model.dart';
import 'package:b2b/Model/temp_model.dart';
import 'package:b2b/widgets/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Model/Get_client_model.dart';

class GoogleMapClient extends StatefulWidget {
  GoogleMapClient({super.key,this.model});
  List<dataListClient>? model;

  @override
  State<GoogleMapClient> createState() => _GoogleMapClientState();
}
class _GoogleMapClientState extends State<GoogleMapClient> {
  late GoogleMapController mapController;

  final Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(22.751247256865494, 75.89504445001252), // Replace with the coordinates of your placeMark
      infoWindow: InfoWindow(title: 'Vijay Nagar'),
    ),
  };
  List  <Marker> list = [];

  List <String> lat = [];
  List <String> long = [];
  List <String> restoName = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddressFromLatLng();
    widget.model?.first.vendorData?.forEach((element) {
     // print('${element.sellerInfo?.longitude}_________element.sellerInfo?.longitude');
      //print('${element.sellerInfo?.longitude}_________element.sellerInfo?.latitude');
        if(element.sellerInfo?.longitude != '' && element.sellerInfo?.latitude != '' )
        {
          lat.add(element.sellerInfo?.latitude ?? "0.0");
          long.add(element.sellerInfo?.longitude ?? "0.0");
        }
        restoName.add(element.sellerInfo?.username ?? "");

    });

    for(int i =0; i<lat.length;i ++ ){
      list.add(Marker(
        markerId: MarkerId('${i}'),
        position: LatLng(double.parse(lat[i]), double.parse(long[i])), // Replace with the coordinates of your placeMark
        infoWindow: InfoWindow(title: restoName[i]),
      ),);

    }
  }
  var homelat;
  var homeLong;
  String? _currentAddress;
  Position? currentLocation;
  _getAddressFromLatLng() async {
    await getUserCurrentLocation().then((_) async {
      try {
        print("Addressss function");
        List<Placemark> p = await placemarkFromCoordinates(
            currentLocation!.latitude, currentLocation!.longitude);
        Placemark place = p[0];
        setState(() {
          _currentAddress =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";

        });
      } catch (e) {

      }
    });
  }
  Future getUserCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      Fluttertoast.showToast(msg: "Permision is requiresd");
    } else if (status.isGranted) {
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .then((position) {
        if (mounted) {
          setState(() {
            currentLocation = position;
            homelat = currentLocation?.latitude;
            homeLong = currentLocation?.longitude;
          });
        }
      });


    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: customAppBar(context: context, text: "Near Sellers", isTrue: false),
      body:homelat == null ?Center(child: CircularProgressIndicator()): GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(homelat, homeLong), // Initial map coordinates
          zoom: 14.0, // Initial zoom level
        ),
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        markers:Set<Marker>.of(list),
      ),
    );

  }
}