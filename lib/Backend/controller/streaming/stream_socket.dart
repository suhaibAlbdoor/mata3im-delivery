import 'package:mata3im_delivery/Backend/models/delivery_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_common_client/socket_io_client.dart' as IO;

class StreamSocket {
  final _socketResponse = BehaviorSubject<Map<String, dynamic>>();

  addResponse(Map<String, dynamic> deliveryModel) {
    _socketResponse.sink.add(deliveryModel);
  }
  Stream<Map<String, dynamic>> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();

IO.Socket socket;

DeliveryModel deliveryModel;
