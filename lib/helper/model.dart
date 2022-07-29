import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Init {
  final bool appmode;
  final String data, admob_Banner, admob_Native, admob_Interstitial;
  final int ad_Option, interstitial_Interval, native_Count;

  Init({
    required this.appmode,
    required this.data,
    required this.ad_Option,
    required this.admob_Banner,
    required this.admob_Native,
    required this.admob_Interstitial,
    required this.interstitial_Interval,
    required this.native_Count,
  });

  factory Init.fromJson(Map<String, dynamic> json) => Init(
    appmode: json["appmode"],
    data: json["data"],
    ad_Option: json["ad_option"],
    admob_Banner: json["admob_banner"],
    admob_Native: json["admob_native"],
    admob_Interstitial: json["admob_interstitial"],
    interstitial_Interval: json["interstitial_interval"],
    native_Count: json["Native_count"],
  );
}

class HeaderList {
  final bool update;
  final List<Album> albums;
  final List<Song> songs;

  HeaderList({
    required this.update,
    required this.songs,
    required this.albums,
  });

  factory HeaderList.fromJson(Map<String, dynamic> json) => HeaderList(
    update: json['update'],
    albums: List<Album>.from(json['albums'].map((element) => Album.fromJson(element))),
    songs: List<Song>.from(json['songs'].map((element) => Song.fromJson(element))),
  );
}

class Album {
  final String image, title;
  final List<Song> list;

  Album({
    required this.title,
    required this.image,
    required this.list,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    title: json["title"],
    image: json["image"],
    list: List<Song>.from(json["list"].map((element) => Song.fromJson(element))),
  );
}

class Song {
  final String title, image, artist, url;

  Song({
    required this.title,
    required this.image,
    required this.artist,
    required this.url,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
    title: json["title"],
    image: json["image"],
    artist: json["artist"],
    url: json["url"],
  );

  static Map<String, dynamic> toMap(Song songs) => {
    "title": songs.title,
    "image": songs.image,
    "artist": songs.artist,
    "url": songs.url,
  };

  static String encodeData(List<Song> songs) => jsonEncode(
    songs.map<Map<String, dynamic>>((element) => Song.toMap(element)).toList()
  );

  static List<Song> decodeData(String songs) => (jsonDecode(songs) as List<dynamic>).map<Song>(
          (element) => Song.fromJson(element)).toList();
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