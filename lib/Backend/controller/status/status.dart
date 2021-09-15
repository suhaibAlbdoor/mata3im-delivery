import 'package:flutter/material.dart';
import 'package:mata3im_delivery/Backend/controller/urls.dart';
import 'package:http/http.dart' as http;

class StatusController {
  static Future changeStatus(
      {@required String token, @required bool online}) async {
    try {
      http.Response response = await http.post(
          online ? Urls.getOnlineUrl : Urls.getOfflineUrl,
          headers: Urls.statusHeaders(token: token));
      messageFunc(response, online);
    } catch (e) {
      print(e);
    }
  }

  static messageFunc(http.Response response, bool online) {
    switch (response.statusCode) {
      case 200:
        {
          online ? print('get online') : print('get offline');
          Urls.errorMessage = 'no';
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 201:
        {
          online ? print('get online') : print('get2 offline');
          Urls.errorMessage = 'no';
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 400:
        {
          Urls.errorMessage = 'phone Already In use';
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 401:
        {
          Urls.errorMessage = 'Invalid Email or Password';
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 404:
        {
          Urls.errorMessage = 'You did something NOT FOUND !';
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 500:
        {
          Urls.errorMessage =
              'Server Error : we have a problem just try again later';
          print(response.statusCode);
          print(response.body);
        }
        break;
      default:
        {
          Urls.errorMessage =
              'We have Unknown error just connect us later or feedback ${response.statusCode}';
          print(response.statusCode);
          print(response.body);
        }
    }
  }
}
