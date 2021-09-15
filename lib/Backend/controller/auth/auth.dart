import 'package:flutter/cupertino.dart';
import 'package:mata3im_delivery/Backend/database/database.dart';
import 'package:mata3im_delivery/Backend/models/auth_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../controller/urls.dart';

class AuthController {
  static AuthModel _authModel = AuthModel();
  static AuthModel get authModel => _authModel;

  static Future authFunc({
    @required String password,
    @required String email,
  }) async {
    final userData = json.encode(Urls.signInMap(email, password));

    try {
      http.Response response = await http.post(
        Urls.loginUrl,
        headers: Urls.authHeaders,
        body: userData,
      );
      messageFunc(response, true);
    } catch (e) {
      print(e);
    }
  }

  static okay(http.Response response) {
    _authModel = authModelFromJson(response.body);
    print('login token is : ${_authModel.token}');
    DataInLocal.saveInLocal(token: _authModel.token, id: _authModel.driver.id);
    Urls.errorMessage = 'no';
  }

  static messageFunc(http.Response response, bool auth) {
    switch (response.statusCode) {
      case 200:
        {
          auth ? okay(response) : Urls.errorMessage = 'no';
          print(response.statusCode);
          print(response.body);
        }
        break;
      case 201:
        {
          auth ? okay(response) : Urls.errorMessage = 'no';
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
