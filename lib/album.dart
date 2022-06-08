import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modul1/helper/model.dart';

class SideDetail extends StatefulWidget {
  final List<User> list;
  final String image, title;
  final onNext;
  const SideDetail({Key? key, this.onNext, required this.image, required this.list, required this.title}) : super(key: key);

  _sideDetail createState() => _sideDetail();
}

class _sideDetail extends State<SideDetail> {
  final _scrollControl = ScrollController();

  @override
  Widget build(BuildContext context) {
    var medias = MediaQuery.of(context);
    List<User> _list = widget.list;
    return Container(
      width: medias.size.width,
      height: medias.size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff96979C), Color(0xff636669), Color(0xff25252D)],
              stops: [0.2, 0.5, 0.8]
          )
      ),
      child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollControl,
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppbarDelegates(
                  medias: medias,
                  title: widget.title,
                  image: widget.image,
                ),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                        (context, index) {
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
                                  Icons.favorite_border_outlined,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: _list.length
                ),
              ),
            ],
          ),

          Positioned(
            top: getPositionedPlayButton(medias),
            right: 25,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                shape: BoxShape.circle,
              ),
              height: 70,
              width: 70,
              child: Icon(
                Icons.play_arrow,
                size: 35,
                color: Colors.black,
              ),
            ),
          ),
        ],
      )
    );
  }

  double getPositionedPlayButton(MediaQueryData medias) {
    _scrollControl.addListener(() {
      setState(() {

      });
    });
    double position = medias.size.height * 0.4;
    if (_scrollControl.hasClients) {
      double offset = _scrollControl.offset;
      bool isFinals = offset > position + (medias.size.height * 0.115 - 65 / 2 - 90);
      if (!isFinals) {
        position = position - offset;
      } else {
        position = medias.size.height * 0.115 - 65 / 2;
      }
    }
    return position;
  }
}

class SliverAppbarDelegates extends SliverPersistentHeaderDelegate {
  final MediaQueryData medias;
  final image, title;
  SliverAppbarDelegates({
    required this.medias,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final maxRatio = shrinkOffset / maxExtent;
    bool animatedImageAlbum = maxRatio >= 0.25;
    bool animateAlbumToZero = maxRatio > 0.585;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: (animateAlbumToZero) ? Colors.grey : Colors.transparent,
          padding: EdgeInsets.only(
            top: medias.padding.top + medias.size.height * 0.05,
            left: 10,
            right: 10,
            bottom: 50,
          ),
          child: AnimatedOpacity(
            opacity: (animateAlbumToZero)
                ? 0
                : (animatedImageAlbum)
                  ? 1 - maxRatio
                  : 1,
            duration: Duration(milliseconds: 100),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ),

        Positioned(
          left: 10,
          bottom: 15,
          child: AnimatedOpacity(
            opacity: (animateAlbumToZero)
                ? 0
                : (animatedImageAlbum)
                  ? 1 - maxRatio
                  : 1,
            duration: Duration(milliseconds: 50),
            child: Text(
              '$title Album',
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),

        Positioned(
          top: medias.viewPadding.top + 5,
          left: 5,
          right: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),

              AnimatedOpacity(
                opacity: (animateAlbumToZero)
                    ? (animatedImageAlbum)
                      ? 1
                      : 1 - maxRatio
                    : 0,
                duration: Duration(milliseconds: 100),
                child: Center(
                  child: Text(
                    '$title Album',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),

              Container(
                width: 40,
              ),
            ],
          )
        ),
      ],
    );
  }

  @override
  double get maxExtent => medias.size.height * 0.45;
  @override
  double get minExtent => medias.size.height * 0.115;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}