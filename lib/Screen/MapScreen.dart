import 'dart:async';
import 'dart:math';
import 'package:b2b/Model/temp_model.dart';
import 'package:b2b/widgets/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Gogglemap extends StatefulWidget {
   Gogglemap({super.key,this.tempMode2});
 List <TempMode2>? tempMode2;

  @override
  State<Gogglemap> createState() => _GogglemapState();
}
class _GogglemapState extends State<Gogglemap> {
  late GoogleMapController mapController;


List  <Marker> list = [];

 List <String> lat = [];
 List <String> long = [];
 List <String> restoName = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddressFromLatLng();
    widget.tempMode2?.forEach((element) {
      element.temp?.forEach((element) {
        if(element.lat != '' && element.lang != '' )
        {
          lat.add(element.lat ?? "0.0");
          long.add(element.lang ?? "0.0");
        }
        restoName.add(element.storeName ?? "");
      });
    });

    for(int i =0; i<lat.length; i ++ ){
      list.add(Marker(
        markerId:  MarkerId('${i}'),
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
        List<Placemark> p = await placemarkFromCoordinates(
            currentLocation!.latitude, currentLocation!.longitude);
        Placemark place = p[0];
        setState(() {
          _currentAddress =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";

        });
      } catch (e) {
        print('errorrrrrrr ${e}');
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

  CameraTargetBounds _cameraTargetBounds = CameraTargetBounds(LatLngBounds(southwest: LatLng(0,0), northeast: LatLng(0,0)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text: "Near Sellers", isTrue: false),
      body:  homelat  == null ? const Center(child: CircularProgressIndicator())
          :GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(homelat, homeLong), // Initial map coordinates
          zoom: 14.0, // Initial zoom level
        ),
        onMapCreated: (controller) {

        /*  LatLng initialCameraPosition = const LatLng(40.7128, -74.0060); // Replace with your desired initial position
          CameraUpdate initialCameraUpdate = CameraUpdate.newLatLng(initialCameraPosition);
          controller.animateCamera(initialCameraUpdate);*/
          double minLat = double.infinity;
          double maxLat = -double.infinity;
          double minLng = double.infinity;
          double maxLng = -double.infinity;

          for (Marker marker in list) {
            final position = marker.position;
            minLat = min(minLat, position.latitude);
            maxLat = max(maxLat, position.latitude);
            minLng = min(minLng, position.longitude);
            maxLng = max(maxLng, position.longitude);
          }

          if (minLat != double.infinity && maxLat != -double.infinity && minLng != double.infinity && maxLng != -double.infinity) {
            LatLng southwest = LatLng(minLat, minLng);
            LatLng northeast = LatLng(maxLat, maxLng);
            LatLngBounds bounds = LatLngBounds(southwest: southwest, northeast: northeast);

            CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);

            LatLng center = LatLng(
              (bounds.northeast.latitude + bounds.southwest.latitude) ,
              (bounds.northeast.longitude + bounds.southwest.longitude) ,
            );

            CameraPosition cameraPosition = CameraPosition(
              target: center , // Center of the bounds
              //zoom: 14, // Adjust the zoom level as needed
            );

            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));// 50 is padding
            controller.animateCamera(cameraUpdate);
          }
          setState(() {
            mapController = controller;

          });
        },
        markers:Set<Marker>.of(list),
       // cameraTargetBounds: _cameraTargetBounds,

      ),
    );

      // GoogleMap(
      //   onMapCreated: (GoogleMapController controller){_controller.complete(controller);},
      //   initialCameraPosition: _kGoogle,
      //   markers:Set<Marker>.of(_list),
      //   myLocationEnabled: true,
      //
      // ),


  }
}