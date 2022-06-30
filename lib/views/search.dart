import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modul1/detail.dart';
import 'package:modul1/helper/model.dart';
import 'package:modul1/helper/services.dart';
import 'package:modul1/helper/transition.dart';

class Search extends StatefulWidget {
  final onNext;
  const Search({Key? key, required this.onNext}) : super(key: key);
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  String query = '';
  TextEditingController _controller = TextEditingController();

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
              Container(
                height: medias.size.height * 0.1,
                padding: EdgeInsets.only(top: 12.5, bottom: 10),
                child: Container(
                  height: 50,
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
                        icon: Icon(
                          (query.isEmpty) ? Icons.search : Icons.clear,
                          color: Colors.black,
                        ),
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
              ),

              Divider(color: Colors.white70, height: 1.5),

              Padding(
                padding: EdgeInsets.only(top: 15),
                child: FutureBuilder<HeaderList>(
                  future: DioClient().getDatas(),
                  builder: (context, snapshot) {
                    HeaderList? init = snapshot.data;
                    List<Songs> list = (query.isNotEmpty) ? init!.songs.where(
                            (element) => element.title.toLowerCase().contains(query)
                    ).toList() : [];

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(widget.onNext).push(
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
                                      image: NetworkImage(list[index].imageUrl),
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
                                            list[index].title,
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