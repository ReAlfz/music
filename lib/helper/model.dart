import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}

class HeaderList {
  List<Album> album;
  List<User> listSong;

  HeaderList({
    required this.listSong,
    required this.album,
  });

  factory HeaderList.fromJson(Map<String, dynamic> json) => HeaderList(
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

class ShareInit {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    // print(jsonEncode(value));
    prefs.setString(key, jsonEncode(value));
  }

  remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}