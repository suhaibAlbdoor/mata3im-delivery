import 'package:flutter/material.dart';
import 'package:mata3im_delivery/Backend/controller/streaming/stream_socket.dart';
import 'package:socket_io_common_client/socket_io_client.dart' as IO;

const String API_URL = "https://multi-rest2.herokuapp.com/api/v1/";

mixin Urls {
  static const String loginUrl = "${API_URL}loginDriver";
  static const String getOfflineUrl = "${API_URL}getOffline";
  static const String getOnlineUrl = "${API_URL}getOnline";
  static const String addLocationUrl = "${API_URL}updateLocation";
  static const String profileUrl = "${API_URL}profile";

  static const Map<String, String> authHeaders = {
    "Content-Type": "application/json",
  };
  static Map<String, String> signInMap(String email, String password) => {
        "email": email,
        "password": password,
      };
  static Map<String, dynamic> addLocation(List<num> coordinates) => {
        "coordinates": coordinates,
      };
  static Map<String, String> locationHeaders({@required final String token}) =>
      {"Content-Type": "application/json", "Authorization": "Bearer $token"};
  static Map<String, String> statusHeaders({@required final String token}) =>
      {"Authorization": "Bearer $token"};
  static String errorMessage = 'no';
  static connect(token) {
    socket = IO.io(
      'https://multi-rest2.herokuapp.com/order',
    );
    socket.connected
        ? print('you connected in order')
        : socket.on('connect', (_) {
            print('connectX happened');
            socket.emit('authenticate', {
              'token': token,
            });
          });
    print('auth in socket');
  }
}
