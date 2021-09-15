import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geocoder/geocoder.dart';
//

// const double CAMERA_ZOOM = 13;
// const double CAMERA_TILT = 0;
// const double CAMERA_BEARING = 30;
// const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
// const LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);
// class MapPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => MapPageState();
// }
// class MapPageState extends State<MapPage> {
//   Completer<GoogleMapController> _controller = Completer();
// // this set will hold my markers
//   Set<Marker> _markers = {};
// // this will hold the generated polylines
//   Set<Polyline> _polylines = {};
// // this will hold each polyline coordinate as Lat and Lng pairs
//   List<LatLng> polylineCoordinates = [];
// // this is the key object - the PolylinePoints
// // which generates every polyline between start and finish
//   PolylinePoints polylinePoints = PolylinePoints();
//   String googleAPIKey = "AIzaSyBZ80HMJwPDDbSjUzmGECamOZizoJcF2vU";
// // for my custom icons
//   BitmapDescriptor sourceIcon;
//   BitmapDescriptor destinationIcon;
//
//   @override
//   void initState() {
//     super.initState();
//     setSourceAndDestinationIcons();
//   }
//   void setSourceAndDestinationIcons() async {
//     sourceIcon =  BitmapDescriptor.defaultMarkerWithHue(5);
//     destinationIcon =  BitmapDescriptor.defaultMarkerWithHue(5);
//   }
//   @override
//   Widget build(BuildContext context) {
//     CameraPosition initialLocation = CameraPosition(
//         zoom: CAMERA_ZOOM,
//         bearing: CAMERA_BEARING,
//         tilt: CAMERA_TILT,
//         target: SOURCE_LOCATION
//     );
//     return GoogleMap(
//         myLocationEnabled: true,
//         compassEnabled: true,
//         tiltGesturesEnabled: false,
//         markers: _markers,
//         polylines: _polylines,
//         mapType: MapType.normal,
//         initialCameraPosition: initialLocation,
//         onMapCreated: onMapCreated
//     );
//   }
//   void onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//     setMapPins();
//     setPolylines();
//   }
//   void setMapPins() {
//     setState(() {
//       // source pin
//       _markers.add(Marker(
//           markerId: MarkerId('sourcePin'),
//           position: SOURCE_LOCATION,
//           icon: sourceIcon
//       ));
//       // destination pin
//       _markers.add(Marker(
//           markerId: MarkerId('destPin'),
//           position: DEST_LOCATION,
//           icon: destinationIcon
//       ));
//     });
//   }
//   setPolylines() async {
//     print("im in setPolylines");
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         googleAPIKey,
//         PointLatLng( SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude)
//        ,
//         PointLatLng( DEST_LOCATION.latitude, DEST_LOCATION.longitude)
//         ,
//         ) ;
//
//     if(result.points.isNotEmpty){
//       // loop through all PointLatLng points and convert them
//       // to a list of LatLng, required by the Polyline
//       print("result is not empty ${result.points}");
//       result.points.forEach((PointLatLng point){
//         polylineCoordinates.add(
//             LatLng(point.latitude, point.longitude));
//       });
//     }
//     setState(() {
//       // create a Polyline instance
//       // with an id, an RGB color and the list of LatLng pairs
//       Polyline polyline = Polyline(
//           polylineId: PolylineId('poly'),
//           color: Color.fromARGB(255, 40, 122, 198),
//           points: polylineCoordinates
//       );
//
//       // add the constructed polyline as a set of points
//       // to the polyline set, which will eventually
//       // end up showing up on the map
//       _polylines.add(polyline);
//     });
//   }
// }

//
class MapScreen extends StatefulWidget {
  final List<num> restCoordinates, userCoordinates;
  MapScreen({
    @required this.restCoordinates,
    @required this.userCoordinates,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  StreamSubscription _locationSubscription;

  GoogleMapController mapController;
  double _originLatitude,
      _originLongitude,
      _destRestLatitude,
      _destRestLongitude,
      _destLatUser,
      _destLongUser;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polyLineMap = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKeyForIos = "AIzaSyDsKPjDgY1FOIWbNxeZK1_dK21ms8UTmDQ";
  String googleAPiKeyForAndroid = "AIzaSyBZ80HMJwPDDbSjUzmGECamOZizoJcF2vU";
  String _mapStyle;
  bool joinUser = false;
  bool stopTracking = false;
  Position position;
  String address2 = '';
  getCurrentLocationInit() async {
print("imm in initLocation");
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude);

    setState(() {
      _originLatitude = position.latitude;
      _originLongitude = position.longitude;
      _destRestLatitude = widget.restCoordinates[0];
      _destRestLongitude = widget.restCoordinates[1];
      _destLatUser = widget.userCoordinates[1];
      _destLongUser = widget.userCoordinates[0];
      print("DESTUSER::LAT${_destLatUser}......DELLLLST::LON ${_destLongUser}");
      print("restlat::LAT${_destRestLatitude}......rest::LON ${_destRestLongitude}");
      print("origin::LAT${_originLatitude}......origin::LON ${_originLongitude}");
 });

    if (mapController != null) {
      mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          new CameraPosition(
              bearing: MediaQuery.of(context).size.width * 0.7,
              target: LatLng(_originLatitude, _originLongitude),
              zoom: 19),
        ),


      );
    }
    await _addMarker(position, "origin", BitmapDescriptor.defaultMarker); // the driver
    await _addMarkerDest(LatLng(joinUser==false?_destRestLatitude:_destRestLongitude, joinUser==false?_destLatUser:_destLongUser), // resturant
      joinUser==false?"restDestination":"userDestination", BitmapDescriptor.defaultMarkerWithHue(joinUser==false?90:200),);
    // await _addMarkerDest(LatLng(_destLatUser, _destLongUser), "userDestination", //user
    //     BitmapDescriptor.defaultMarkerWithHue(200));
    await _getPolyline(joinUser == false ? Colors.red : Colors.green);
    // await _getPolyline(Colors.green,dest1: _destLatitude2,dest2: _destLongitude2);
  }

  void _currentLocation() async {
    var p;
    p = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    mapController.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: MediaQuery.of(context).size.width * 0.7,
        target: LatLng(p.latitude, p.longitude),
        zoom: 19.0,
      ),
    ));
  }

  void updateTracking(Position newLocalData) async{
    LatLng latLng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      MarkerId markerId = MarkerId("origin");
      Marker marker = Marker(
        markerId: markerId,
        rotation: newLocalData.heading,
        icon: BitmapDescriptor.defaultMarker,
        position: latLng,
      );
      markers[markerId] = marker;
    });

  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds:3),(){
      getCurrentLocationInit();
    });
    rootBundle.loadString('assets/mapstyle.txt').then((string) {
      _mapStyle = string;
    });

  }

  streamLocation() async {
    try {
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      _locationSubscription =
          Geolocator.getPositionStream().listen((Position newLocalData) async {
        setState(() {
          _originLatitude = newLocalData.latitude;
          _originLongitude = newLocalData.longitude;
        });
        if (mapController != null) {
          mapController.moveCamera(
            CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: MediaQuery.of(context).size.width * 0.7,
                  target: LatLng(_originLatitude, _originLongitude),
                  zoom: 19),
            ),
          );
           updateTracking(newLocalData);
          await _getPolyline(joinUser != false ? Colors.red : Colors.green);

        }
      });
    } catch (e) {
      print(e);
    }

  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _locationSubscription.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: _currentLocation,
          child: Icon(
            Icons.my_location,
            color: Colors.black,
          ),
        ),
        appBar: AppBar(
          title: Row(
            children: [
              Icon(
                Icons.location_on,
                color: theme.primaryColor,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                'Sending Order',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        body: _originLongitude == null
            ? Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(theme.primaryColor),
              ))
            : Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      bearing: MediaQuery.of(context).size.width * 0.7,
                      tilt: 45.0,
                      target: LatLng(_originLatitude, _originLongitude),
                      zoom: 19,
                    ),
                    myLocationEnabled: true,
                    tiltGesturesEnabled: true,
                    compassEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    myLocationButtonEnabled: false,
                    onMapCreated: _onMapCreated,
                    markers: Set<Marker>.of(markers.values),
                    polylines: Set<Polyline>.of(polyLineMap.values),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.61,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.19,
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor.withOpacity(0.85),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 25),
                        children: [
                          ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 52),
                            onTap: () async {
                              if (joinUser == false) {
                                setState(() {
                                  // _destRestLatitude = _destLatUser;
                                  // _destRestLongitude = _destLongUser;
                                  joinUser = true;
                                });
                                await _getPolyline(Colors.green);
                              } else {
                                setState(() {
                                  // _destRestLatitude = widget.restCoordinates[1];
                                  // _destRestLongitude =
                                  //     widget.restCoordinates[0];
                                  joinUser = false;
                                });
                                await _getPolyline(Colors.red);
                              }
                            },
                            title: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  joinUser == false
                                      ? 'Track customer'
                                      : 'Track Restaurant',
                                  style: theme.textTheme.subtitle2,
                                ),
                              ],
                            ),
                            subtitle: Text(
                              'Amman',
                              style: theme.textTheme.subtitle2.copyWith(
                                color: theme.hintColor,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 52),
                            onTap: () async {
                              if (stopTracking == false) {
                                setState(() {
                                  stopTracking = true;
                                });
                               await  streamLocation();
                              } else {
                                setState(() {
                                  stopTracking = false;
                                });
                                _locationSubscription.pause();
                               await  getCurrentLocationInit();
                              }
                              print(_locationSubscription?.isPaused);
                            },
                            title: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  stopTracking == false
                                      ? 'Start tracking'
                                      : 'Stop tracking',
                                  style: theme.textTheme.subtitle2,
                                ),
                              ],
                            ),
                            subtitle: Text(
                              'Amman , jordan',
                              style: theme.textTheme.subtitle2.copyWith(
                                color: theme.hintColor,
                                fontSize: 11,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
  }

  _addMarker(Position position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      rotation: position.heading,
      icon: descriptor,
      position: LatLng(position.latitude, position.longitude),
    );
    markers[markerId] = marker;
  }

  _addMarkerDest(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(Color color) {
    print("im in ");
    PolylineId id = PolylineId("id");
    Polyline polyline = Polyline(
      width: 3,
      polylineId: id,
      color: color,
      points: polylineCoordinates,
    );
    polyLineMap[id] = polyline;
    print("poliLine: ${polyLineMap[id]}");
    setState(() {});
  }

  _getPolyline(Color color) async {
    print("hello my User${joinUser}");

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Platform.isIOS ? googleAPiKeyForIos : googleAPiKeyForAndroid,
      PointLatLng(_originLatitude,_originLongitude),
      // PointLatLng(_destLatUser, _destLongUser),
      // PointLatLng(joinUser == false?_destLatUser:_destRestLatitude, joinUser == false?_destLongUser:_destRestLongitude),
      // PointLatLng(joinUser == false?31.9778:33.9778, joinUser == false? 35.9802:31.9898),
     // joinUser == false? PointLatLng(31.9778,  35.9802):
      joinUser == false? PointLatLng(_destRestLatitude,_destRestLongitude):PointLatLng(_destLatUser,_destLongUser),

      // PointLatLng(31.0114, 36.952)
      travelMode: TravelMode.driving,
    );
    print("sowhat${result.points}");
    if (result.points.isNotEmpty) {
      print(":im in");
      polylineCoordinates.isNotEmpty
          ? polylineCoordinates.clear()
          : print('list is empty');
      result.points.forEach((PointLatLng point) {
        print("no empty Coordinates");
        print("cv:${point.latitude} //// ${point.longitude}");
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine(color);
  }
}
// //
// // /* Map api keys */
// // // AIzaSyDsKPjDgY1FOIWbNxeZK1_dK21ms8UTmDQ apiKey for ios * maps *
// // // AIzaSyBZ80HMJwPDDbSjUzmGECamOZizoJcF2vU apiKey for android * maps *
