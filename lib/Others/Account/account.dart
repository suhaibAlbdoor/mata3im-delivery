import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mata3im_delivery/Backend/controller/profile/profile_controller.dart';
import 'package:mata3im_delivery/Locale/locales.dart';
import 'package:mata3im_delivery/Others/MyProfile/my_profile.dart';
import 'package:mata3im_delivery/Routes/routes.dart';

class Account extends StatefulWidget {
  final String token;
  Account({@required this.token});
  @override
  _AccountState createState() => _AccountState();
}

class RestroOptions {
  String title;
  String subtitle;
  Icon icon;

  RestroOptions(this.title, this.subtitle, this.icon);
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context);

    List<RestroOptions> restroOptions = [
      RestroOptions(
        locale.support,
        locale.letUsKnow,
        Icon(
          Icons.mail,
          color: theme.primaryColor,
        ),
      ),
      RestroOptions(
        locale.changeLanguage,
        locale.changeTheLocationOfApp,
        Icon(
          Icons.language,
          color: theme.primaryColor,
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          locale.account,
          style: theme.textTheme.subtitle1,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding:
                EdgeInsets.only(top: 8, bottom: 16, right: 16, left: 16),
            tileColor: theme.backgroundColor,
            title: Text(
              ProfileController.profileModel.username,
              style: theme.textTheme.subtitle1.copyWith(
                height: 2,
              ),
            ),
            subtitle: GestureDetector(
              onTap: () {
                Get.to(MyProfile(token: widget.token));
              },
              child: Row(
                children: [
                  Text(
                    locale.viewProfile,
                    style: theme.textTheme.subtitle2
                        .copyWith(color: theme.hintColor),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: theme.primaryColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16),
              shrinkWrap: true,
              itemCount: restroOptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: index == 0
                      ? () {
                          //support
                        }
                      : index == 1
                          ? () {
                              Navigator.pushNamed(
                                  context, PageRoutes.languages);
                            }
                          : null,
                  leading: restroOptions[index].icon,
                  title: Text(
                    restroOptions[index].title,
                    style: theme.textTheme.subtitle2.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    restroOptions[index].subtitle,
                    style: theme.textTheme.subtitle2.copyWith(
                      color: theme.hintColor,
                      fontSize: 12,
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
