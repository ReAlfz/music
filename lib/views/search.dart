import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modul1/detail.dart';
import 'package:modul1/helper/model.dart';
import 'package:http/http.dart' as http;
import 'package:modul1/helper/transition.dart';

class Search extends StatefulWidget {
  final onNext;
  const Search({Key? key, required this.onNext}) : super(key: key);
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  String query = '';
  TextEditingController _controller = TextEditingController();
  Future<HeaderList> load() async {
    final response = await http.get(Uri.parse('https://api.npoint.io/47a5b011dd89156251c5'));
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12.5),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  autofocus: false,
                  controller: _controller,
                  onChanged: (String text) {
                    setState(() {
                      query = text.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Search video here...',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 1.5),
                    suffixIcon: IconButton(
                      icon: Icon( (query.isEmpty) ? Icons.search : Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        setState(() {
                          query = '';
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 15),
                child: FutureBuilder<HeaderList>(
                  future: load(),
                  builder: (context, snapshot) {
                    HeaderList? init = snapshot.data;
                    List<User> list = (query.isNotEmpty) ? init!.listSong.where(
                            (element) => element.artist.contains(query.toLowerCase()) || element.title.contains(query.toLowerCase())
                    ).toList() : [];

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                FadeTransitioned(page: Details(
                                  onNext: widget.onNext,
                                  index: index,
                                  listOther: list,
                                ))
                            );
                          },

                          child: Container(
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
                                      image: NetworkImage(list[index].image),
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
                                            list[index].title,
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
                                            list[index].artist,
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
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}