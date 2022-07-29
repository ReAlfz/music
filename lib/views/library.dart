import 'package:flutter/material.dart';
import 'package:modul1/detail.dart';
import 'package:modul1/helper/model.dart';
import 'package:modul1/helper/services.dart';
import 'package:modul1/helper/transition.dart';
import 'package:provider/provider.dart';

class Library extends StatefulWidget {
  final onNext;
  const Library({Key? key, required this.onNext}) : super(key: key);
  _Library createState() => _Library();
}

class _Library extends State<Library> {
  bool searchMode = false;
  String query = "";
  late TextEditingController _textEditingController = TextEditingController();

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
          child: Consumer<LibraryServices>(
            builder: (context, services, child) {
              List<Song> _list = (query.isEmpty)
                  ? services.defaultList
                  : services.defaultList.where(
                      (element) => element.title.toLowerCase().contains(query)
              ).toList();
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 12.5, bottom: 10),
                    height: medias.size.height * 0.1,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 500),
                            opacity: (searchMode) ? 0 : 1,
                            child: Text(
                              "Your Library",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            width: (searchMode) ? medias.size.width : 50,
                            height: 48,
                            curve: Curves.easeInOut,
                            child: (searchMode)
                                ? AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              alignment: Alignment.centerRight,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: (searchMode) ? Colors.grey[200] : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 9,
                                    fit: FlexFit.tight,
                                    child: TextField(
                                      textInputAction: TextInputAction.done,
                                      autofocus: false,
                                      controller: _textEditingController,
                                      onChanged: (String text) {
                                        setState(() {
                                          query = text.toLowerCase();
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Search video here...',
                                        hintStyle: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 1.5),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                        Icons.clear
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        searchMode = false;
                                        _textEditingController.clear();
                                        query = "";
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                                : AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              alignment: Alignment.centerRight,
                              height: 48,
                              decoration: BoxDecoration(
                                color: (searchMode) ? Colors.transparent : Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    searchMode = true;
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Divider(color: Colors.white70, height: 1.5),

                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(widget.onNext).push(
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
                                      image: NetworkImage(_list[index].image),
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
                                            _list[index].title,
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
                                            _list[index].artist,
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
                    ),
                  ),
                ],
              );
            },
          )
        ),
      ),
    );
  }
}