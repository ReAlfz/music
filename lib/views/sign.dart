import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/services.dart';

class Sign extends StatefulWidget {
  _Sign createState() => _Sign();
}

class _Sign extends State<Sign> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

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
                stops: [0.2, 0.5, 0.8],
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
                      services.signUp(email: username.text, password: password.text);
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
                          'Sign up',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
}