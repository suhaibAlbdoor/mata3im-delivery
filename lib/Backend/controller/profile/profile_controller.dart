import 'package:flutter/material.dart';
import 'package:mata3im_delivery/Backend/controller/urls.dart';
import 'package:http/http.dart' as http;
import '../../models/profile_model.dart';

class ProfileController {
  static ProfileModel _profileModel = ProfileModel();
  static ProfileModel get profileModel => _profileModel;

  static Future getProfile({@required String token}) async {
    try {
      http.Response response = await http.get(Urls.profileUrl,
          headers: Urls.statusHeaders(token: token));
      messageFunc(response);
    } catch (e) {
      print(e);
    }
  }

  static messageFunc(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          _profileModel = profileModelFromJson(response.body);
          Urls.errorMessage = 'no';
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 201:
        {
          _profileModel = profileModelFromJson(response.body);
          Urls.errorMessage = 'no';
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 400:
        {
          Urls.errorMessage = response.body;
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 401:
        {
          Urls.errorMessage = response.body;
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 404:
        {
          Urls.errorMessage = response.body;
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
