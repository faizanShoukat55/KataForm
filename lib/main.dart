import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:katta_form/ui/screens/animals_list/animal_detail/animal_family/animal_family_view_model.dart';
import 'package:katta_form/ui/screens/animals_list/animal_detail/animal_gallery/animal_gallery_view_model.dart';
import 'package:katta_form/ui/screens/animals_list/animal_detail/animal_health/animal_health_view_model.dart';
import 'package:katta_form/ui/screens/animals_list/animal_detail/animal_milk/animal_milk_view_model.dart';
import 'package:katta_form/ui/screens/animals_list/animal_detail/animal_note/animal_note_view_model.dart';
import 'package:katta_form/ui/screens/animals_list/animal_detail/animal_weight/animal_weight_view_model.dart';
import 'package:katta_form/ui/screens/authentication/login/login_screen.dart';
import 'package:katta_form/ui/screens/splash/splash_screen.dart';

import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'locator.dart';

Logger logger = Logger();

class MySocket {
  static IO.Socket? _socket;

  static _init() async {
    // var socket = io.connect('xxx.xxx.xxx.xxx:8000', {
    //   transports: ['polling']
    // });


    _socket = IO.io(
        // 'http://3.139.144.196:8001?token=$jwt',
        'ws://23.166.144.102:92/api/MyService?param=12242381225',
        IO.OptionBuilder()
            // .setTimeout(30000)
            // .enableAutoConnect()
            // .enableMultiplex()
            // // .setTransports(["websocket"])
            // // .setTransports(["polling"])
            // .setReconnectionAttempts(200)
            // .setReconnectionDelay(5000)
            .build());

    _socket?.onConnect((_) {
      print('connect');
      Fluttertoast.showToast(msg: "Web Socket Connected");
    });

    _socket?.onConnectError((data) {
      Fluttertoast.showToast(msg: "${data.toString()}");
      print('error Code : ${data.hashCode}');
      print('error : ${data.toString()}');
    });
    // event
    _socket?.on('receive', (data) {
      print("Socket Data Event :" + data.toString());
    });
    _socket?.onDisconnect(
        (_) => Fluttertoast.showToast(msg: "Web Socket disconnected"));
    _socket?.on('fromServer', (_) => print(_));

    return _socket!;
  }

  static getSocket() {
    if (_socket != null) {
      return _socket!;
    }
    return _init();
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// For to mood off landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      // ignore: prefer_const_constructors
      // designSize: Size(414, 896),
      designSize: Size(414, 896),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AnimalHealthViewModel()),
          ChangeNotifierProvider(create: (context) => AnimalNoteViewModel()),
          ChangeNotifierProvider(create: (context) => AnimalGalleryViewModel()),
          ChangeNotifierProvider(create: (context) => AnimalFamilyViewModel()),
          ChangeNotifierProvider(create: (context) => AnimalWeightViewModel()),
          // ChangeNotifierProvider(create: (context) => AnimalWeightViewModel(null)),
          ChangeNotifierProvider(create: (context) => AnimalMilkViewModel()),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Channab',
          // home: SplashScreen(),
          home: LoginScreen(),
        ),
      ),
    );
  }
}
