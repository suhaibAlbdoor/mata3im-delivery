import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mata3im_delivery/Others/DeliverymanOffline/deliveryman_offline.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class DataInLocal {
  static Future<void> saveInLocal(
      {@required String token, @required int id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key = 'token';
    final String value = token;
    final String eKey = 'id';
    final int eValue = id;
    prefs.setString(key, value);
    prefs.setInt(eKey, eValue);
    print('value was stored');
  }

  static Future<void> saveLocationInLocal(
      {@required double lat,
      @required double long,
      @required String city,
      @required String country,
      @required String iso,
      @required String subLocality,
      String address}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String latKey = 'lat';
    final String longKey = 'long';
    final String cityKey = 'city';
    final String countryKey = 'country';
    final String isoKey = 'iso';
    final String subLocalityKey = 'sub';
    final String addressKey = 'address';
    final double latitude = lat;
    final double longitude = long;
    final String cityV = city;
    final String countryV = country;
    final String subLocalityV = subLocality;
    final String isoV = iso;
    final String addressV = address;
    prefs.setDouble(latKey, latitude);
    prefs.setDouble(longKey, longitude);
    prefs.setString(cityKey, cityV);
    prefs.setString(countryKey, countryV);
    prefs.setString(subLocalityKey, subLocalityV);
    prefs.setString(isoKey, isoV);
    address == null
        ? print('no address to save')
        : prefs.setString(addressKey, addressV);
    print('location lat, long, city, country and sub was stored');
  }

  static Future<String> readTokenFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key = 'token';
    final String value = prefs.get(key) ?? '0';
    print('reading from local , token is : $value ');
    return value;
  }

  static Future<dynamic> readValueFromLocal(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String keyOnLocal = key;
    final dynamic value = prefs.get(keyOnLocal) ?? '0';
    print('reading from local , $key is : $value ');
    return value;
  }

  static Future<void> useValueToNavigate(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key = 'token';
    final String value = prefs.get(key) ?? '0';
    final String eKey = 'id';
    final int eValue = prefs.get(eKey) ?? null;
    if (value != '0' && eValue != null) {
      Get.offAll(ChangeStatus(
        token: value,
        id: eValue,
      ));
      print('token in database is : $value');
    }
  }
}
