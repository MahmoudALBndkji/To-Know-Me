import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:To_Know_Me/layout/cubit/cubit.dart';
import 'package:To_Know_Me/layout/cubit/states.dart';
import 'package:To_Know_Me/layout/social_layout.dart';
import 'package:To_Know_Me/modules/login/cubit/cubit.dart';
import 'package:To_Know_Me/modules/login/login_screen.dart';
import 'package:To_Know_Me/modules/onBoarding_page/OnBoardingPage.dart';
import 'package:To_Know_Me/shared/bloc_observer.dart';
import 'package:To_Know_Me/shared/components/components.dart';
import 'package:To_Know_Me/shared/components/constants.dart';
import 'package:To_Know_Me/shared/helper_function.dart';
import 'package:To_Know_Me/shared/network/local/cache_helper.dart';
import 'package:To_Know_Me/shared/styles/themes.dart';
import 'package:social_share/social_share.dart';

// type this method is ( BackgroundMessageHandler )
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(message.data.toString());
  showToast(message: "on background message", state: ToastStates.SUCCESS);
}

void main() async {
  SocialShare.checkInstalledAppsForShare();
  // if main is (async) we used this for check for All
  // in Method is executed and Then Run This Application
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // change This Variable when make two themes for app
  bool isDark = true;
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: isDark ? HexColor('333739') : Color(0xFFBDBDBD),
    ),
  );

  var token = await FirebaseMessaging.instance.getToken();
  print('token : $token');

  FirebaseMessaging messaging = FirebaseMessaging.instance;


// Final Added This Lines For Testing
// NotificationSettings settings = await messaging.requestPermission(
//   alert: true,
//   announcement: false,
//   badge: true,
//   carPlay: false,
//   criticalAlert: false,
//   provisional: false,
//   sound: true,
// );

// print('User granted permission: ${settings.authorizationStatus}');

  // Foreground Messages
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    showToast(message: "on message", state: ToastStates.SUCCESS);
  });

  // Foreground Messages when click on notification Open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
    showToast(message: "on message opened app", state: ToastStates.SUCCESS);
  });

  //  Background Messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Handling Custom Show Er ror
  customError();

  // For Prevent Screen Rotation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  if (onBoarding != null) {
    if (uId != null)
      widget = SocialLayout();
    else
      widget = LoginScreen();
  } else {
    print("Go To The OnBoarding Page");
    widget = OnBoardingPage();
  }

  runApp(
    MyApp(
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialLoginCubit(),
        ),
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts()
            ..getAllUsers(),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: startWidget,
          );
        },
      ),
    );
  }
}
