import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modul1/detail.dart';
import 'package:modul1/helper/model.dart';
import 'package:modul1/helper/transition.dart';
import 'package:provider/provider.dart';

class Library extends StatefulWidget {
  final onNext;
  const Library({Key? key, required this.onNext}) : super(key: key);
  _Library createState() => _Library();
}

class _Library extends State<Library> {
  bool _searching = false;
  void _doSearching() => setState(() => _searching = !_searching);

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
            ),
        ),

        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: _doSearching,
                      icon: Icon(
                        Icons.search,
                        size: 27.5,
                        color: Colors.grey[200],
                      ),
                    ),
                  ),

                  AnimatedContainer(
                    width: _searching ? 0 : medias.size.width,
                    transform: Matrix4.translationValues(_searching ? medias.size.width : 0, 0, 0),
                    duration: const Duration(seconds: 1),
                    height: kToolbarHeight * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey[600]!,
                      ),
                    ),
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          prefixIcon: AnimatedOpacity(
                              duration: const Duration(seconds: 1),
                              opacity: _searching ? 0 : 1,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios),
                                onPressed: _doSearching,
                              )),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),

              FutureBuilder<List<User>>(
                future: load(),
                builder: (context, snapshot) {
                  return Consumer<LibraryServices>(
                    builder: (context, services, child) {
                      services.defaultList = snapshot.data ?? [];
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: services.defaultList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                  FadeTransitioned(page: Details(
                                    onNext: widget.onNext,
                                    index: index,
                                    listOther: services.defaultList,
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
                                        image: NetworkImage(services.defaultList[index].image),
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
                                              services.defaultList[index].title,
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
                                              services.defaultList[index].artist,
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
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        services.deleteListener(services.defaultList[index], context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<User>> load() async {
    try {
      return User.decodeData(await ShareInit().read('list'));
    } catch (e) {
      print('failed because $e');
      return [];
    }
  }
}