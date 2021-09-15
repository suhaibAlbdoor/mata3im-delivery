import 'package:flutter/material.dart';
import 'package:mata3im_delivery/Backend/models/delivery_model.dart';
import 'package:mata3im_delivery/Locale/locales.dart';
import 'package:mata3im_delivery/Others/Account/account.dart';
import 'package:mata3im_delivery/Others/Orders/order.dart';
import 'package:mata3im_delivery/Others/map.dart';

class AppNavigation extends StatefulWidget {
  final String token;
  final int id;
  final DeliveryModel deliveryModel;
  AppNavigation(
      {@required this.token, @required this.id, @required this.deliveryModel});
  @override
  _AppNavigationState createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _currentIndex = 0;

  List<Widget> _children = [];
  @override
  void initState() {
    super.initState();
    _children = [
      MapScreen(
        userCoordinates:
            widget.deliveryModel.orderInfo.userLocation.coordinates,
        restCoordinates: widget.deliveryModel.restaurantLocation,
      ),



      Orders(
        deliveryModel: widget.deliveryModel,
        token: widget.token,
        id: widget.id,
      ),
      Account(
        token: widget.token,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context);
    final List<BottomNavigationBarItem> _items = [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: locale.home,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.attach_money,
        ),
        label: "Orders",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.perm_identity,
        ),
        label: locale.account,
      ),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: IndexedStack(
        children: _children,
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        showSelectedLabels: true,
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: theme.hintColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
