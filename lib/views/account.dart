import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modul1/helper/model.dart';
import 'package:modul1/views/login.dart';

class Account extends StatefulWidget {
  final onNext;
  const Account({Key? key, required this.onNext}) : super(key: key);
  _Account createState() => _Account();
}

class _Account extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(
          child: InkWell(
            onTap: () async {
              FirebaseAuth.instance.signOut();
              Navigator.of(widget.onNext).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => Login()
              ), (route) => false,
              );
            },

            child: Text(
              'Log out',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
      ),
    );
  }
}