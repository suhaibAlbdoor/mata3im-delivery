import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mata3im_delivery/AppNavigation/app_navigation.dart';
import 'package:mata3im_delivery/Auth/SignIn/sign_in.dart';
import 'package:mata3im_delivery/Backend/controller/location/location.dart';
import 'package:mata3im_delivery/Backend/controller/profile/profile_controller.dart';
import 'package:mata3im_delivery/Backend/controller/status/status.dart';
import 'package:mata3im_delivery/Backend/controller/urls.dart';
import 'package:mata3im_delivery/Backend/database/database.dart';
import 'package:mata3im_delivery/Backend/models/delivery_model.dart';
import 'package:mata3im_delivery/Components/custom_button.dart';
import 'package:mata3im_delivery/Locale/locales.dart';
import 'package:get/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mata3im_delivery/Backend/controller/streaming/stream_socket.dart';
import 'package:socket_io_common_client/socket_io_client.dart' as IO;

class ChangeStatus extends StatefulWidget {
  final String token;
  final int id;
  ChangeStatus({@required this.token, @required this.id});
  @override
  _ChangeStatusState createState() => _ChangeStatusState();
}

class _ChangeStatusState extends State<ChangeStatus> {
  Position position;
  bool online = false;
  getProfile() async {
    await ProfileController.getProfile(token: widget.token);
    if (ProfileController.profileModel.onlineStatus == 'online') {
      connect();
      getOrder();
      await getLocation();
      setState(() {
        online = true;
      });
      // Get.to(Data(id: widget.id, token: widget.token));
    }
    setState(() {});
  }

  connect() {
    socket = IO.io(
      'https://multi-restaurants.herokuapp.com/order',
    );
    socket.connected
        ? print('you connected in order')
        : socket.on('connect', (_) {
            print('connect happened');
            socket.emit('authenticate', {
              'token': widget.token,
            });
          });
    print('auth in socket');
  }

  getOrder() {
    //connect();
    socket.on('get-order', (data) {
      print("1221 ${data}");
      data != null ? streamSocket.addResponse(data) : print('data is null');
    });
    print('online in get order');
  }

  getLocation() async {
    print("getting Location");
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Geolocator.openAppSettings();
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print('location: ${position.latitude} ${position.longitude}');
      List<num> coordinates = [position.longitude, position.latitude];
      await LocationController.addLocationToBackend(
          token: widget.token, coordinates: coordinates);
    }
    print("gotten Location");
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'Status',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 19, right: 17),
            child: InkWell(
              onTap: () async {
                await DataInLocal.saveInLocal(token: '0', id: null);
                await StatusController.changeStatus(
                    token: widget.token, online: false);
                Get.offAll(SignInUI());
              },
              child: Text(
                'Logout',
                style: TextStyle(color: theme.primaryColor, fontSize: 17),
              ),
            ),
          ),
        ],
      ),
      body: ProfileController.profileModel.onlineStatus == null
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(theme.primaryColor),
              ),
            )
          : Center(
              child: ProfileController.profileModel.onlineStatus == 'offline'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              online = !online;
                            });
                            try {
                              await EasyLoading.show(status: 'Loading');
                              await StatusController.changeStatus(
                                  token: widget.token, online: online);
                              await getLocation();
                              Urls.errorMessage == 'no' && online == true
                                  ? getOrder()
                                  : print('offline');
                              await EasyLoading.dismiss();
                              // Get.to(Data());
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: online == false
                                  ? Color(0xfff95424)
                                  : Color(0xff6ac932),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 100,
                            height: 30,
                            child: Center(
                              child: online == false
                                  ? Text(
                                      locale.goOnline,
                                      style: theme.textTheme.subtitle2.copyWith(
                                        fontSize: 12,
                                      ),
                                    )
                                  : Text(
                                      locale.goOffline,
                                      style: theme.textTheme.subtitle2.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        online
                            ? RaisedButton(
                                onPressed: () {
                                  Get.to(Data(
                                    id: widget.id,
                                    token: widget.token,
                                  ));
                                },
                                child: Text('Go data'),
                              )
                            : Text(''),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You are online wait for getting your location',
                          style: TextStyle(color: Colors.white),
                        ),
                        online
                            ? RaisedButton(
                                onPressed: () {
                                  Get.to(Data(
                                    id: widget.id,
                                    token: widget.token,
                                  ));
                                },
                                child: Text('Go data'),
                              )
                            : Text(''),
                      ],
                    ),
            ),
    );
  }
}

class Data extends StatefulWidget {
  final String token;
  final int id;
  Data({@required this.id, @required this.token});
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  bool loading = true;
  getOrder() {
    socket.on('get-order', (data) {
      print("1221 ${data}");
      data != null ? streamSocket.addResponse(data) : print('data is null');
    });
    print('online in get order');
  }

  acceptOrder(orderId, restaurantId) {
    socket.connected
        ? socket.emit('accept-order', {
            'orderId': orderId,
            'restaurantId': restaurantId,
          })
        : print('not connected');
  }

  load() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    load();
    getOrder();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Items',
          style: TextStyle(
            color: theme.primaryColor,
          ),
        ),
      ),
      body: StreamBuilder(
        builder: (c, AsyncSnapshot<Map<String, dynamic>> snapshot) {

          if (!snapshot.hasData) {
            return Center(
              child: loading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(theme.primaryColor),
                    )
                  : Text(
                      'There\'s nothing here right now check it later',
                      style: TextStyle(color: Colors.white),
                    ),
            );
          }

          deliveryModel = DeliveryModel.fromJson(snapshot.data);
          return Column(

            children: [
  Text(deliveryModel.restaurant.name,style: TextStyle(color: Colors.white,fontSize: 16.0),)      ,
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 16, left: 3),
                child: Column(

                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.orderedItems,
                          style: theme.textTheme.subtitle2.copyWith(
                            color: theme.hintColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Qnt.',
                          style: theme.textTheme.subtitle2.copyWith(
                            color: theme.hintColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          locale.amount,
                          style: theme.textTheme.subtitle2.copyWith(
                            color: theme.hintColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListView.builder(
                itemCount: deliveryModel.orderInfo.rests.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (c, i) => ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (c, index) {
                   print("release!: ${deliveryModel.orderInfo.rests[i].meals.length}");
                   print("index = $i");
                   print("Name of Item${deliveryModel.meals[index].name}");
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 16, right: 16, left: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(deliveryModel.meals[index].name,
                              style: theme.textTheme.subtitle2),
                          Spacer(
                            flex: 3,
                          ),
                          Text(
                              deliveryModel
                                  .orderInfo.rests[i].meals[index].quantity
                                  .toString(),
                              style: theme.textTheme.subtitle2),
                          Spacer(
                            flex: 4,
                          ),
                          Text(
                              "${deliveryModel.orderInfo.rests[i].meals[index].price}"
                                  .toString(),
                              style: theme.textTheme.subtitle2),
                        ],
                      ),
                    );
                  },
                  itemCount: deliveryModel.orderInfo.rests[i].meals.length,
                ),
              ),
              Divider(
                thickness: 0.2,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      'Total Price',
                      style: theme.textTheme.subtitle2.copyWith(
                        fontSize: 18,
                        color: theme.hintColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '\$ ${deliveryModel.orderInfo.price}',
                      style: theme.textTheme.subtitle2
                          .copyWith(fontSize: 18, color: theme.primaryColor),
                    )
                  ],
                ),
              ),
              Spacer(),
              CustomButton(
                label: 'Accept Order',
                onTap: () {
                  acceptOrder(
                      deliveryModel.orderInfo.id, deliveryModel.restaurant.id);
                  // orderDelivered(
                  //     deliveryModel.orderInfo.id, deliveryModel.restaurant.id);
                  Get.to(
                    AppNavigation(
                        token: widget.token,
                        id: widget.id,
                        deliveryModel: deliveryModel),
                  );
                },
              ),
            ],
          );
        },
        stream: streamSocket.getResponse,
      ),
    );
  }
}
