import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mata3im_delivery/Backend/controller/streaming/stream_socket.dart';
import 'package:mata3im_delivery/Backend/models/delivery_model.dart';
import 'package:mata3im_delivery/Others/DeliverymanOffline/deliveryman_offline.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class Orders extends StatefulWidget {
  final DeliveryModel deliveryModel;
  final String token;
  final int id;
  Orders(
      {@required this.deliveryModel, @required this.id, @required this.token});
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  _launchCaller(phone) async {
    final url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar('Can not call', 'Number may be wrong',
          backgroundColor: Colors.white);
      throw 'Could not launch $url';
    }
  }

  orderDelivered(orderId, restaurantId) {
    socket.connected
        ? socket.emit('order-delivered', {
            'orderId': orderId,
            'restaurantId': restaurantId,
          })
        : print('not connected');
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Order Delivery',
          style: theme.textTheme.subtitle1,
        ),
      ),
      body: ListView(
        children: [
          Image.asset(
            'assets/1.gif',
            width: 250,
            height: 250,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.deliveryModel.orderInfo.rests.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      widget.deliveryModel.orderInfo.rests[index].meals.length,
                  itemBuilder: (c, i) => Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Column(
                      children: [
                        ListTile(
                          tileColor: theme.scaffoldBackgroundColor,
                          title: Row(
                            children: [
                              Text(
                                'Order ${widget.deliveryModel.orderInfo.id}',
                                style: theme.textTheme.subtitle2.copyWith(
                                  fontSize: 11,
                                ),
                              ),
                              Spacer(
                                flex: 2,
                              ),
                              Text(
                                '${widget.deliveryModel.orderInfo.totalPrice} JOD',
                                style: theme.textTheme.subtitle2.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          trailing: RaisedButton(
                            onPressed: () {
                              orderDelivered(widget.deliveryModel.orderInfo.id,
                                  widget.deliveryModel.restaurant.id);
                              deliveryModel = null;
                              streamSocket.addResponse(null);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Data(
                                        id: widget.id, token: widget.token),
                                  ),
                                  (route) => false);
                            },
                            child: Text('Order delivered'),
                          ),
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Text(
                                'Restaurant Number ${widget.deliveryModel.restaurant.phone.isEmpty ? '' : widget.deliveryModel.restaurant.phone.first}',
                                style: theme.textTheme.subtitle2.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () {
                              _launchCaller(
                                  widget.deliveryModel.restaurant.phone.isEmpty
                                      ? ''
                                      : widget.deliveryModel.restaurant.phone
                                          .first);
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: theme.primaryColor,
                              child: Icon(
                                Icons.call,
                                color: theme.secondaryHeaderColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Text(
                                'Owner Number ${widget.deliveryModel.orderInfo.user.phone == null ? '' : widget.deliveryModel.orderInfo.user.phone}',
                                style: theme.textTheme.subtitle2.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () {
                              _launchCaller(widget
                                          .deliveryModel.orderInfo.user.phone ==
                                      null
                                  ? ''
                                  : widget.deliveryModel.orderInfo.user.phone);
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: theme.primaryColor,
                              child: Icon(
                                Icons.call,
                                color: theme.secondaryHeaderColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
