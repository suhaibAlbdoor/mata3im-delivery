import 'package:flutter/material.dart';
import 'package:mata3im_delivery/Auth/SignIn/sign_in.dart';
import'package:splashscreen/splashscreen.dart';
class Splashscreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return Splashing();
  }
}
class Splashing extends State<Splashscreen>
{
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      useLoader: false,
      imageBackground:AssetImage("assets/ani.gif") ,
      seconds: 5,
      navigateAfterSeconds:SignInUI(),

      // backgroundColor: Colors.white,
      // styleTextUnderTheLoader: new TextStyle(),
      // photoSize: 100.0,
      // onClick: ()=>print(""),
      // loaderColor: Colors.red
    );
  }
}