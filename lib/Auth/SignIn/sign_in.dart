import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mata3im_delivery/Backend/controller/auth/auth.dart';
import 'package:mata3im_delivery/Backend/controller/urls.dart';
import 'package:mata3im_delivery/Backend/database/database.dart';
import 'package:mata3im_delivery/Components/custom_button.dart';
import 'package:mata3im_delivery/Components/dialogs.dart';
import 'package:mata3im_delivery/Components/entry_field.dart';
import 'package:mata3im_delivery/Locale/locales.dart';
import 'package:mata3im_delivery/Others/DeliverymanOffline/deliveryman_offline.dart';
import 'package:get/get.dart';

class SignInUI extends StatefulWidget {
  @override
  _SignInUIState createState() => _SignInUIState();
}

class _SignInUIState extends State<SignInUI> {
  String email, password;
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    DataInLocal.useValueToNavigate(context);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Image.asset(
              "assets/appIcon.png",
              fit: BoxFit.fill,
              scale: 2,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.backgroundColor.withOpacity(0.4),
                    theme.backgroundColor,
                  ],
                  stops: [0.0, 0.3],
                ),
              ),
            ),
            PositionedDirectional(
              top: 200,
              start: 100,
              end: 100,
              child: Text(
                'Mata3im',
                style: theme.textTheme.headline4.copyWith(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            PositionedDirectional(
                top: 250,
                bottom: 0,
                start: 0,
                end: 0,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EntryField(
                          labelFieldPadding: EdgeInsets.zero,
                          hintText: 'Your e-mail',
                          hintColor: theme.hintColor,
                          onChange: (String val) {
                            email = val;
                          },
                          validation: (val) {
                            if (val.isEmpty) return 'fill the filed';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        EntryField(
                          labelFieldPadding: EdgeInsets.zero,
                          hintText: locale.password,
                          hintColor: theme.hintColor,
                          validation: (val) {
                            if (val.isEmpty) return 'fill the filed';
                            return null;
                          },
                          onChange: (String val) {
                            password = val;
                          },
                        ),
                        CustomButton(
                          onTap: () async {
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => SignUpUI()));
                            await EasyLoading.show(status: 'Loading');
                            await AuthController.authFunc(
                                password: password, email: email);
                            Urls.errorMessage == 'no'
                                ? Get.to(ChangeStatus(
                                    token: AuthController.authModel.token,
                                    id: AuthController.authModel.driver.id,
                                  ))
                                : errorWhileOperation(
                                    Urls.errorMessage, context, 'Try again');
                            await EasyLoading.dismiss();
                          },
                          label: locale.signIn,
                          labelStyle:
                              theme.textTheme.headline4.copyWith(fontSize: 20),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
