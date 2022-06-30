import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:modul1/helper/model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth;
  AuthServices(this._firebaseAuth);

  Future<bool> logIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.message ?? "Unknow error");
      return false;
    }
  }

  Future<bool> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.message ?? "Unknow error");
      return false;
    }
  }
}

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000',
      contentType: "application/json",
      responseType: ResponseType.json,
    )
  );

  Future<HeaderList> getDatas() async {
    Response data = await _dio.get('/api/load/songs');
    return HeaderList.fromJson(data.data);
  }

  // Future<HeaderList> getDatas() async {
  //   final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/load/songs'));
  //
  //   try {
  //     return HeaderList.fromJson(jsonDecode(response.body));
  //   } catch (e) {
  //     print(e.toString());
  //     return HeaderList(total: 0, songs: [], artist: []);
  //   }
  // }
}