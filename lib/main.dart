import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:modul1/helper/model.dart';
import 'package:modul1/views/account.dart';
import 'package:modul1/views/home.dart';
import 'package:modul1/views/library.dart';
import 'package:modul1/views/login.dart';
import 'package:modul1/views/search.dart';

import 'helper/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.getToken().then((value) => print(value));

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(MyApp());
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<Map<String, dynamic>>(
        future: alreadyLogin(context),
        builder: (context, condition) {
          switch (condition.connectionState) {
            case ConnectionState.done:
              if (condition.hasData) {
                return MyHomePage();
              } else {
                return Login();
              }
            default:
              return Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xff96979C), Color(0xff636669), Color(0xff25252D)],
                        stops: [0.2, 0.5, 0.8]
                    ),
                  ),
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/spotify.png'),
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> alreadyLogin(context) async {
    precacheImage(Image.asset('assets/spotify.png').image, context);
    Map<String, dynamic> data = jsonDecode(await ShareInit().read('user'));
    return data;
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  Widget build(BuildContext context) {
    var medias = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteCurrentIndex = !await _navigatorKeys[currentIndex].currentState!.maybePop();
        return isFirstRouteCurrentIndex;
      },

      child: Scaffold(
        body: Container(
          height: medias.size.height,
          width: medias.size.width,
          child: Stack(
            children: [
              createBody(0),
              createBody(1),
              createBody(2),
              createBody(3),
            ],
          )
        ),

        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Container(
            height: medias.size.height * 0.085,
            color: Colors.black.withOpacity(0.9),
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => changeIndex(0),
                  icon: Icon(
                    Icons.home,
                    size: 22.5,
                    color: (currentIndex == 0) ? Colors.white : Colors.grey,
                  ),
                ),

                IconButton(
                  onPressed: () => changeIndex(1),
                  icon: Icon(
                    Icons.search,
                    size: 22.5,
                    color: (currentIndex == 1) ? Colors.white : Colors.grey,
                  ),
                ),

                IconButton(
                  onPressed: () => changeIndex(2),
                  icon: Icon(
                    Icons.list,
                    size: 22.5,
                    color: (currentIndex == 2) ? Colors.white : Colors.grey,
                  ),
                ),

                IconButton(
                  onPressed: () => changeIndex(3),
                  icon: Icon(
                    Icons.person,
                    size: 22.5,
                    color: (currentIndex == 3) ? Colors.white : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createBody(int index) {
    return Offstage(
      offstage: currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (setting) {
          Widget page;
          switch (index) {
            case 1:
              page = Search(
                onNext: context,
              );
              break;

            case 2:
              page = Library(
                onNext: context,
              );
              break;

            case 3:
              page = Account(
                onNext: context,
              );
              break;

            default:
              page = Home(
                onNext: context,
              );
          }
          return MaterialPageRoute(builder: (context) => page);
        },
      ),
    );
  }
}