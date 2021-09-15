import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:mata3im_delivery/Auth/SignIn/sign_in.dart';
import 'package:mata3im_delivery/Backend/controller/profile/profile_controller.dart';
import 'package:mata3im_delivery/Backend/controller/status/status.dart';
import 'package:mata3im_delivery/Backend/database/database.dart';
import 'package:mata3im_delivery/Locale/locales.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  final String token;
  MyProfile({@required this.token});
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Spacer(),
            Text(
              locale.myProfile,
              style: theme.textTheme.subtitle2.copyWith(fontSize: 18),
            ),
            Spacer(),
            GestureDetector(
              onTap: () async {
                await DataInLocal.saveInLocal(token: '0', id: null);
                await StatusController.changeStatus(
                    token: widget.token, online: false);
                Get.offAll(SignInUI());
              },
              child: Text(locale.logout,
                  style: theme.textTheme.subtitle2.copyWith(
                    fontSize: 18,
                    color: theme.primaryColor,
                  )),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.sp,
                  children: [
                    Icon(
                      Icons.person_pin_rounded,
                      color: theme.primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      locale.personalDetails,
                      style: theme.textTheme.subtitle1.copyWith(
                          color: theme.secondaryHeaderColor, fontSize: 18.5),
                    )
                  ],
                ),
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 68),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    locale.fullName,
                    style: theme.textTheme.subtitle2.copyWith(
                      color: theme.hintColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                subtitle: Text(
                  ProfileController.profileModel.username,
                  style: theme.textTheme.subtitle2,
                ),
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 68),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    locale.emailAddress,
                    style: theme.textTheme.subtitle2.copyWith(
                      color: theme.hintColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                subtitle: Text(
                  ProfileController.profileModel.email,
                  style: theme.textTheme.subtitle2,
                ),
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 68),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    locale.phoneNumber,
                    style: theme.textTheme.subtitle2.copyWith(
                      color: theme.hintColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                subtitle: Text(
                  ProfileController.profileModel.phone,
                  style: theme.textTheme.subtitle2,
                ),
              ),
              Spacer(),
              Container(
                color: theme.backgroundColor,
                height: 15,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.sp,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: theme.primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      locale.document,
                      style: theme.textTheme.subtitle1.copyWith(
                          color: theme.secondaryHeaderColor, fontSize: 18),
                    ),
                  ],
                ),
              ),
              // ListTile(
              //   contentPadding:
              //       EdgeInsets.only(left: 64, bottom: 16, top: 8, right: 24),
              //   title: Row(
              //     children: [
              //       Text(locale.governmentId + '\n',
              //           style: theme.textTheme.subtitle2),
              //       Spacer(),
              //       Text(
              //         locale.uploadNow + '\n',
              //         style: theme.textTheme.subtitle2
              //             .copyWith(color: theme.primaryColor),
              //       ),
              //     ],
              //   ),
              //   subtitle: Text(
              //     'VoterIDcard.jpg',
              //     style: theme.textTheme.subtitle2
              //         .copyWith(fontSize: 13, color: theme.hintColor),
              //   ),
              // ),
              // ListTile(
              //   contentPadding:
              //       EdgeInsets.only(left: 64, bottom: 16, top: 0, right: 24),
              //   title: Row(
              //     children: [
              //       Text(locale.drivingLicense + '\n',
              //           style: theme.textTheme.subtitle2),
              //       Spacer(),
              //       Text(
              //         locale.uploadNow + '\n',
              //         style: theme.textTheme.subtitle2
              //             .copyWith(color: theme.primaryColor),
              //       ),
              //     ],
              //   ),
              //   subtitle: Text(
              //     'drivinglicense.jpg',
              //     style: theme.textTheme.subtitle2
              //         .copyWith(fontSize: 13, color: theme.hintColor),
              //   ),
              // ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
