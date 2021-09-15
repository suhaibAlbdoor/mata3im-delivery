import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mata3im_delivery/Others/SplashScreen.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mata3im_delivery/Backend/controller/urls.dart';
import 'package:mata3im_delivery/Backend/database/database.dart';
import 'package:mata3im_delivery/Theme/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth/SignIn/sign_in.dart';
import 'Backend/controller/status/status.dart';
import 'Backend/controller/streaming/stream_socket.dart';
import 'Locale/language_cubit.dart';
import 'Locale/locales.dart';
import 'Others/map.dart';
import 'Routes/routes.dart';
import 'package:get/get.dart';


void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String locale = prefs.getString('locale');
  FlutterError.onError = (FlutterErrorDetails details) async {
    FlutterError.dumpErrorToConsole(details);
    if (Platform.isIOS) {
      if (kReleaseMode) exit(0);
      if (kDebugMode) exit(0);
    } else {
      if (kReleaseMode) SystemNavigator.pop();
      if (kDebugMode) SystemNavigator.pop();
    }
  };
  runZonedGuarded(
    () async {
      await SentryFlutter.init(
        (options) {
          options.dsn =
              'https://a5f1f6a765b44734bf217166a1fc7e31@o530326.ingest.sentry.io/5649751';
        },
      );
      runApp(MultiBlocProvider(providers: [
        BlocProvider(create: (context) => LanguageCubit(locale)),
      ], child: Mata3im()));
    },
    (exception, stackTrace) async {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    },
  );
}

class Mata3im extends StatefulWidget {
  @override
  _Mata3imState createState() => _Mata3imState();
}

class _Mata3imState extends State<Mata3im> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    streamSocket.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    print(
        "LifecycleWatcherState#didChangeAppLifecycleState state=${state.toString()}");
    if (state == AppLifecycleState.inactive) {
      var readToken = await DataInLocal.readTokenFromLocal();
      socket?.disconnect();
      await StatusController.changeStatus(token: readToken, online: false);
    }
    if (state == AppLifecycleState.paused) {
      var readToken = await DataInLocal.readTokenFromLocal();
      socket?.disconnect();
      await StatusController.changeStatus(token: readToken, online: false);
    }
    if (state == AppLifecycleState.resumed) {
      var readToken = await DataInLocal.readTokenFromLocal();
      print("calling connect when resuming");
      Urls.connect(readToken);
      await StatusController.changeStatus(token: readToken, online: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(builder: (context, locale) {
      return GetMaterialApp(
        builder: EasyLoading.init(),
        navigatorObservers: [SentryNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('ar'),
          const Locale('pt'),
          const Locale('fr'),
          const Locale('id'),
          const Locale('es'),
        ],
        locale: locale,
        home: Splashscreen(),
        // home:MapScreen(),
        theme: appTheme,
        routes: PageRoutes().routes(),
      );
    });
  }
}
