import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../controller/urls.dart';

class LocationController {
  static Future addLocationToBackend(
      {@required String token, @required List<num> coordinates}) async {
    final userData = json.encode(Urls.addLocation(coordinates));
    try {
      http.Response response = await http.post(
        Urls.addLocationUrl,
        headers: Urls.locationHeaders(token: token),
        body: userData,
      );
      messageFunc(response);
    } catch (e) {
      print(e);
    }
  }

  static messageFunc(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          Urls.errorMessage = 'no';
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 201:
        {
          Urls.errorMessage = 'no';
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 400:
        {
          Urls.errorMessage = "${response.body}";
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 401:
        {
          Urls.errorMessage = "${response.body}";
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 404:
        {
          Urls.errorMessage = "${response.body}";
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
