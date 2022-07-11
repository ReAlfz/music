import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modul1/helper/model.dart';
import 'package:http/http.dart' as http;

class LibraryServices extends ChangeNotifier {
  List<Songs> defaultList = [];

  void updateListener(Songs user, BuildContext context) {
    if (!defaultList.any((element) => element.title.contains(user.title))) {
      try {
        defaultList.add(user);
        ShareInit().save('list', Songs.encodeData(defaultList));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 700),
            content: Text(
              'Music added to your library',
            ),
          ),
        );

        notifyListeners();
      } catch (e) {
        print('failed because $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 700),
          content: Text(
            'Music already added',
          ),
        ),
      );
    }
    print(defaultList.length);
  }

  void deleteListener(Songs user, BuildContext context) {
    try {
      defaultList.remove(user);
      ShareInit().save('list', Songs.encodeData(defaultList));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 700),
          content: Text(
            'Music remove from your library',
          ),
        ),
      );
      notifyListeners();
    } catch (e) {
      print('failed because $e');
    }
  }
}


class ApiClient {
  Future<HeaderList> getData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/load/songs'));

    if (response.statusCode == 200) {
      return HeaderList.fromJson(jsonDecode(response.body));
    } else {
      return getData();
    }
  }
}