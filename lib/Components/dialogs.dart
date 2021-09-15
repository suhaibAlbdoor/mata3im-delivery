import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> errorWhileOperation(
    errorMessage, BuildContext context, buttonText) {
  return showCupertinoDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('What Happen ?'),
            content: Text(
              errorMessage.toString(),
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  buttonText,
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              // FlatButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   child: Text(
              //     'Tell us',
              //     style: TextStyle(color: Colors.blueAccent),
              //   ),
              // ),
            ],
          ));
}
