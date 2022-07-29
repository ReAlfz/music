import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modul1/helper/model.dart';
import 'package:http/http.dart' as http;

class LibraryServices extends ChangeNotifier {
  List<Song> defaultList = [];

  void updateListener(Song user, BuildContext context) {
    if (!defaultList.any((element) => element.title.contains(user.title))) {
      try {
        defaultList.add(user);
        ShareInit().save('list', Song.encodeData(defaultList));

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

  void deleteListener(Song user, BuildContext context) {
    try {
      defaultList.remove(user);
      ShareInit().save('list', Song.encodeData(defaultList));
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
    final response = await http.get(Uri.parse('https://api.npoint.io/47a5b011dd89156251c5'));

    if (response.statusCode == 200) {
      return HeaderList.fromJson(jsonDecode(response.body));
    } else {
      return getData();
    }
  }

  // Future<Init> loading() async {
  //   final response = await http.get(
  //       Uri.parse(utf8.decode(base64Url.decode('aHR0cHM6Ly9hcGkubnBvaW50LmlvLzMwMDcxNjU1OThlOGEyMDdiYzNh')))
  //   );
  // }
}