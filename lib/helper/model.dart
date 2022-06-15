import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LibraryServices extends ChangeNotifier {
  List<User> defaultList = [];

  void updateListener(User user, BuildContext context) {
    if (!defaultList.any((element) => element.title.contains(user.title))) {
      try {
        defaultList.add(user);
        ShareInit().save('list', User.encodeData(defaultList));
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

  void deleteListener(User user, BuildContext context) {
    try {
      defaultList.remove(user);
      ShareInit().save('list', User.encodeData(defaultList));
      notifyListeners();
    } catch (e) {
      print('failed because $e');
    }
  }
}

class User {
  final String title, artist, image, url;

  User({
    required this.image,
    required this.artist,
    required this.title,
    required this.url,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    image: json['image'],
    artist: json['artist'],
    title: json['title'],
    url: json['url'],
  );

  static Map<String, dynamic> toMap(User data) => {
    'title': data.title,
    'artist' : data.artist,
    'image' : data.image,
    'url' : data.url,
  };

  static String encodeData(List<User> data) => jsonEncode(
    data.map<Map<String, dynamic>> (
        (element) => User.toMap(element)
    ).toList()
  );

  static List<User> decodeData(String data) => (jsonDecode(data) as List<dynamic>).map<User>(
          (element) => User.fromJson(element)
  ).toList();
}

class ShareInit {
  read(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    return jsonDecode(_prefs.getString(key) ?? '');
  }

  save(String key, value) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.setString(key, jsonEncode(value));
  }

  remove(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.remove(key);
  }
}

class HeaderList {
  bool update;
  List<Album> album;
  List<User> listSong;

  HeaderList({
    required this.update,
    required this.listSong,
    required this.album,
  });

  factory HeaderList.fromJson(Map<String, dynamic> json) => HeaderList(
    update: json['update'],
    listSong: List<User>.from(json['songs'].map((element) => User.fromJson(element))),
    album: List<Album>.from(json['albums'].map((element) => Album.fromJson(element))),
  );
}

class Album {
  String title, image;
  List<User> list;

  Album({
    required this.title,
    required this.image,
    required this.list,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    title: json['title'],
    image: json['image'],
    list: List<User>.from(json['list'].map((element) => User.fromJson(element))),
  );
}