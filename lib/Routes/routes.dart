import 'package:flutter/material.dart';

import 'package:mata3im_delivery/Others/Account/account.dart';
import 'package:mata3im_delivery/Others/LanguageUI/languages.dart';
import 'package:mata3im_delivery/Others/MyProfile/my_profile.dart';

class PageRoutes {
  //static const String account = 'account';
  //static const String myProfile = 'myProfile';
  static const String languages = 'languages';

  Map<String, WidgetBuilder> routes() {
    return {
      // account: (context) => Account(),
      //myProfile: (context) => MyProfile(),
      languages: (context) => Languages(),
    };
  }
}
