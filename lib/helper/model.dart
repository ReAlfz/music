import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              'Music added',
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
      notifyListeners();
    } catch (e) {
      print('failed because $e');
    }
  }
}

class HeaderList {
  final int total;
  final List<ListArtist> artist;
  final List<Songs> songs;

  HeaderList({
    required this.total,
    required this.songs,
    required this.artist,
  });

  factory HeaderList.fromJson(Map<String, dynamic> json) => HeaderList(
    total: json['total data'],
    artist: List<ListArtist>.from(json['artist'].map((element) => ListArtist.fromJson(element))),
    songs: List<Songs>.from(json['songs'].map((element) => Songs.fromJson(element))),
  );
}

class ListArtist {
  final int id;
  final String name, imageUrl;
  final List<ArtistSongs> songs;

  ListArtist({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.songs,
  });

  factory ListArtist.fromJson(Map<String, dynamic> json) => ListArtist(
    id: json["id"],
    name: json["name"],
    imageUrl: json["image_url"],
    songs: List<ArtistSongs>.from(json['songs'].map((element) => ArtistSongs.fromJson(element)))
  );

  static Map<String, dynamic> toMap(Artist data) => {
    'id': data.id,
    'name': data.name,
    'image_url': data.imageUrl,
  };
}

class Artist {
  int id;
  String name, imageUrl;

  Artist({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    id: json["id"],
    name: json["name"],
    imageUrl: json["image_url"],
  );

  static Map<String, dynamic> toJson(Artist data) => {
    'id': data.id,
    'name': data.name,
    'image_url': data.imageUrl,
  };
}

class Songs {
  final int id, artistId;
  final String title, imageUrl, songsUrl;
  final Artist artist;

  Songs({
    required this.id,
    required this.artistId,
    required this.title,
    required this.imageUrl,
    required this.songsUrl,
    required this.artist,
  });

  factory Songs.fromJson(Map<String, dynamic> json) => Songs(
    id: json["id"],
    artistId: json["artist_id"],
    title: json["title"],
    imageUrl: json["image_url"],
    songsUrl: json["songs_url"],
    artist: Artist.fromJson(json['artist']),
  );

  static Map<String, dynamic> toMap(Songs data) => {
    'id': data.id,
    'artistId': data.artistId,
    'title': data.title,
    'image_url': data.imageUrl,
    'songs_url' : data.songsUrl,
    'artist': Artist.toJson(data.artist),
  };

  static String encodeData(List<Songs> data) => jsonEncode(
      data.map<Map<String, dynamic>> (
              (element) => Songs.toMap(element)
      ).toList()
  );

  static List<Songs> decodeData(String data) => (jsonDecode(data) as List<dynamic>).map<Songs>(
          (element) => Songs.fromJson(element)
  ).toList();
}

class ArtistSongs {
  final int id, artistId;
  final String title, imageUrl, songsUrl;

  ArtistSongs({
    required this.id,
    required this.artistId,
    required this.title,
    required this.imageUrl,
    required this.songsUrl,
  });

  factory ArtistSongs.fromJson(Map<String, dynamic> json) => ArtistSongs(
    id: json["id"],
    artistId: json["artist_id"],
    title: json["title"],
    imageUrl: json["image_url"],
    songsUrl: json["songs_url"],
  );
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