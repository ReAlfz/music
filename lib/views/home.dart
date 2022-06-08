import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modul1/album.dart';
import 'package:modul1/detail.dart';
import 'package:modul1/helper/model.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final onNext;
  const Home({Key? key, required this.onNext}) : super(key: key);
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  late String name;
  Future<HeaderList> load() async {
    final response = await http.get(Uri.parse('https://api.npoint.io/47a5b011dd89156251c5'));
    try {
      var maps = jsonDecode(await ShareInit().read('user'));
      name = maps['nama'];
    } catch (e) {
      print(e);
    }

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return HeaderList.fromJson(jsonData);
    } else {
      return load();
    }
  }

  @override
  Widget build(BuildContext context) {
    var medias = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: medias.size.width,
        height: medias.size.height,
        padding: EdgeInsets.fromLTRB(10, medias.viewPadding.top, 10, 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff96979C), Color(0xff636669), Color(0xff25252D)],
            stops: [0.2, 0.5, 0.8]
          )
        ),
        child: SingleChildScrollView(
          child: FutureBuilder<HeaderList>(
            future: load(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Album> _list = snapshot.data!.album;
                List<User> listOther = snapshot.data!.listSong;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Text(
                              'Welcome back!',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 23,
                                height: 1,
                                color: Colors.white70,
                              ),
                            ),
                          ),

                          Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Text(
                              'name',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 23,
                                height: 1,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(color: Colors.white70, height: 1.5),

                    Padding(
                      padding: EdgeInsets.only(bottom: 15, top: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Recommeded Album',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      height: medias.size.height * 0.3,
                      width: medias.size.width,
                      margin: EdgeInsets.only(bottom: 20),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return AspectRatio(
                            aspectRatio: 29 / 30,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => SideDetail(
                                  onNext: widget.onNext,
                                  title: _list[index].title,
                                  image: _list[index].image,
                                  list: _list[index].list,
                                )),
                              ),

                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                ),
                                child: Column(
                                  children: [
                                    Flexible(
                                      flex: 8,
                                      fit: FlexFit.tight,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        ),
                                        child: Image(
                                          image: NetworkImage(_list[index].image),
                                          width: medias.size.width,
                                          height: medias.size.height,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 12.5, bottom: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            _list[index].title,
                                            style: TextStyle(
                                              fontSize: 18,
                                              letterSpacing: 1,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Container(
                      width: medias.size.width,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: listOther.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
                            padding: EdgeInsets.only(right: 15),
                            height: medias.size.height * 0.12,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(listOther[index].image),
                                      height: medias.size.height,
                                      width: medias.size.width,
                                    ),
                                  ),
                                ),

                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 7,
                                  child: Column(
                                    children: [
                                      Flexible(
                                        fit: FlexFit.tight,
                                        flex: 5,
                                        child: Container(
                                          alignment: Alignment.bottomLeft,
                                          padding: EdgeInsets.only(bottom: 5, left: 12.5),
                                          child: Text(
                                            listOther[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Flexible(
                                        fit: FlexFit.tight,
                                        flex: 5,
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(top: 5, left: 12.5),
                                          child: Text(
                                            listOther[index].artist,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 1,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.favorite_border_outlined,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  width: medias.size.width,
                  height: medias.size.height,
                  child: Center(
                    child: Text('loading...'),
                  ),
                );
              }
            },
          ),
        )
      ),
    );
  }
}