import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:modul1/helper/services.dart';
import 'package:modul1/main.dart';
import 'package:modul1/views/sign.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('= ${message.notification?.body}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await launchUrl(Uri.parse('google.com'));
      print('A new onMessageOpenedApp event was published!');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var medias = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff96979C), Color(0xff636669), Color(0xff25252D)],
                  stops: [0.2, 0.5, 0.8]
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: medias.size.height * 0.6,
            child: Container(
              height: 200,
              width: 200,
              child: Image(
                image: AssetImage('assets/spotify.png'),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: medias.size.height * 0.425,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: medias.size.width * 0.020),
                    height: 60,
                    child: TextField(
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      controller: username,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                        hintText: 'Username',
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: medias.size.width * 0.020),
                    height: 60,
                    child: TextField(
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      controller: password,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                        hintText: 'Password',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: () async {
                      AuthServices services = AuthServices(FirebaseAuth.instance);
                      if (await services.logIn(email: username.text, password: password.text)) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => MyHomePage()
                            ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('email or password invalid'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: medias.size.width * 0.020),
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.25,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Sign())
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.25,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}