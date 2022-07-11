import 'package:flutter/material.dart';
import 'package:modul1/helper/services.dart';
import 'package:modul1/views/home.dart';
import 'package:modul1/views/library.dart';
import 'package:modul1/views/search.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LibraryServices>(
      create: (context) => LibraryServices(),
      child: MaterialApp(
        title: 'Spotify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  Widget build(BuildContext context) {
    var medias = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteCurrentIndex = !await _navigatorKeys[currentIndex].currentState!.maybePop();
        return isFirstRouteCurrentIndex;
      },

      child: Scaffold(
        body: Container(
          height: medias.size.height,
          width: medias.size.width,
          child: Stack(
            children: [
              createBody(0),
              createBody(1),
              createBody(2),
            ],
          )
        ),

        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Container(
            height: medias.size.height * 0.085,
            color: Colors.black.withOpacity(0.9),
            padding: EdgeInsets.symmetric(horizontal: medias.size.width * 0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => changeIndex(0),
                  icon: Icon(
                    Icons.home,
                    size: 22.5,
                    color: (currentIndex == 0) ? Colors.white : Colors.grey,
                  ),
                ),

                IconButton(
                  onPressed: () => changeIndex(1),
                  icon: Icon(
                    Icons.search,
                    size: 22.5,
                    color: (currentIndex == 1) ? Colors.white : Colors.grey,
                  ),
                ),

                IconButton(
                  onPressed: () => changeIndex(2),
                  icon: Icon(
                    Icons.list,
                    size: 22.5,
                    color: (currentIndex == 2) ? Colors.white : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createBody(int index) {
    return Offstage(
      offstage: currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (setting) {
          Widget page;
          switch (index) {
            case 1:
              page = Search(
                onNext: context,
              );
              break;

            case 2:
              page = Library(
                onNext: context,
              );
              break;

            default:
              page = Home(
                onNext: context,
              );
          }
          return MaterialPageRoute(builder: (context) => page);
        },
      ),
    );
  }
}