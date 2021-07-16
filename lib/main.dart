import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Globals gb = Globals();
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(
          title: gb.title,
        )); //HiligaynonPage(title: 'Flutter Demo ListView with Button'));
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final List<String> list = List.generate(
      10,
      (index) =>
          '${(index + 1).toString().padLeft(3, '0')}          ${songTitle(index + 1)}');
  @override
  FotterButton createState() => FotterButton();
}

class HiligaynonPage extends StatefulWidget {
  HiligaynonPage({Key? key, required this.title}) : super(key: key);
  final String title;
  final List<String> list = List.generate(
      10,
      (index) =>
          '${(index + 1).toString().padLeft(3, '0')}          ${songTitle(index + 1)}');
  @override
  HiligaynonTblOfContents createState() => HiligaynonTblOfContents();
}

class EnglishPage extends StatefulWidget {
  EnglishPage({Key? key, required this.title}) : super(key: key);

  final String title;
  final List<String> list = List.generate(
      10,
      (index) =>
          '${(index + 1).toString().padLeft(3, '0')}          ${songTitle(index + 1)}');
  @override
  EnglishTblOfContents createState() => EnglishTblOfContents();
}

class SongDetail {
  String strTitle;
  var isFavorite = false;

  SongDetail(this.strTitle, this.isFavorite);
}

class Empty {
  Empty();
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.close),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  String selectedResult = '';

  @override
  Widget buildResults(BuildContext contect) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> songTitle;
  Search(this.songTitle);
  List<String> recentList = ["Text 4", "Text 3"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList.addAll(songTitle.where(
            (element) => element.contains(query),
          ));
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              suggestionList[index],
            ),
            onTap: () {
              selectedResult = suggestionList[index];
              showResults(context);
            },
          );
        });
  }
}

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings"),
      ),
      drawer: Container(
        child: Text("setings"),
      ),
    );
  }
}

int songNum = 0;
String title = "";

class EnglishTblOfContents extends State<EnglishPage> {
  List<dynamic> arrSongList = List.generate(600, (index) {
    if (index % 2 != 0) {
      return new SongDetail(songTitle(index), false);
    } else
      return new Empty();
  });
  var gb = Globals();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: arrSongList.length,
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            onTap: () {
              int n = index;
              gb.number(n);
              gb.title = songTitle(n);
              // String t = arrSongList[index].strTitle;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LyricPage(
                            songNumber: n,
                            songTitle: songTitle(n),
                          )));
            },
            child: (index % 2 != 0)
                ? Container(
                    height: 45.0,
                    decoration: BoxDecoration(),
                    child: new Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                child: Text(
                                  (index).toString().padLeft(3, '0') +
                                      "         " +
                                      arrSongList[index].strTitle,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 1,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0))),
                              ),
                              new GestureDetector(
                                onTap: () {
                                  setState(() {
                                    arrSongList[index].isFavorite =
                                        !arrSongList[index].isFavorite;
                                  });
                                  print('clicked on heart ' +
                                      arrSongList[index].strTitle);
                                },
                                child: new Container(
                                    margin: const EdgeInsets.all(0.0),
                                    child: new Icon(
                                      arrSongList[index].isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 30.0,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
                : Container(
                    child: null,
                  ),
          );
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(items: [],);
      // child: ElevatedButton(
      //   onPressed: () {},
      //   child: const Text('Bottom Button!', style: TextStyle(fontSize: 20)),
      // ),
    );
  }
}

class FotterButton extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);

    List<PersistentBottomNavBarItem> _navBarsItems() {
      var gb = Globals();
      return [
        PersistentBottomNavBarItem(
          icon: Text(
            "Hil",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.blue.shade900,
                fontSize: 18,
                fontStyle: FontStyle.italic),
          ),
          title: (gb.title),
        ),
        PersistentBottomNavBarItem(
          icon: Text(
            "En",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.blue.shade900,
                fontSize: 18,
                fontStyle: FontStyle.italic),
          ),
          title: (gb.title),
        ),
      ];
    }

    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    var gb = Globals();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search(widget.list));
              },
              icon: Icon(Icons.search),
            ),
          ],
          centerTitle: true,
          title: Text(widget.title),
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
              print("pressed");
            },
            icon: Icon(Icons.menu),
          ),
        ),
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: [
            (gb.pageFlag == false)
                ? HiligaynonPage(title: 'SDA Hymnal (Hiligaynon)')
                : LyricPage(songNumber: gb.songNum, songTitle: gb.title),
            (gb.pageFlag == false)
                ? EnglishPage(title: 'SDA Hymnal')
                : LyricPage(songNumber: gb.songNum - 1, songTitle: gb.title),
          ],
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style1, // Choose the nav bar style with this property.
        ),
        drawer: Drawer(
          child: Text("settings"),
        ));
  }
}

class HiligaynonTblOfContents extends State<HiligaynonPage> {
  List<dynamic> arrSongList = List.generate(600, (index) {
    if (index % 2 == 0) {
      return new SongDetail(songTitle(index), false);
    } else
      return new Empty();
  });

  @override
  Widget build(BuildContext context) {
    var gb = Globals();
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(widget.list));
            },
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: arrSongList.length,
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            onTap: () {
              int n = index;
              gb.number(n);
              gb.title = songTitle(n);
              // String t = arrSongList[index].strTitle;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LyricPage(
                            songNumber: n,
                            songTitle: songTitle(n),
                          )));
            },
            child: ((index % 2 == 0) && (index != 0))
                ? Container(
                    height: 45.0,
                    decoration: BoxDecoration(),
                    child: new Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                child: Text(
                                  (index).toString().padLeft(3, '0') +
                                      "         " +
                                      arrSongList[index].strTitle,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 1,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0))),
                              ),
                              new GestureDetector(
                                onTap: () {
                                  setState(() {
                                    arrSongList[index].isFavorite =
                                        !arrSongList[index].isFavorite;
                                  });
                                  print('clicked on heart ' +
                                      arrSongList[index].strTitle);
                                },
                                child: new Container(
                                    margin: const EdgeInsets.all(0.0),
                                    child: new Icon(
                                      arrSongList[index].isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 30.0,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
                : Container(
                    child: null,
                  ),
          );
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(items: [],);
      // child: ElevatedButton(
      //   onPressed: () {},
      //   child: const Text('Bottom Button!', style: TextStyle(fontSize: 20)),
      // ),
    );
  }
}

// class LyricPage extends StatefulWidget {
//   LyricPage({Key? key, required this.songNumber, required this.songTitle})
//       : super(key: key);
//   final String songTitle;
//   final int songNumber;
//   @override
//   LyricPageState createState() => LyricPageState();
// }

songTitle(int num) {
  switch (num) {
    case 1:
      return "Euno";
    case 2:
      return "Hdos";
    default:
      return "Assign title to this Number";
  }
}

class LyricPage extends StatelessWidget {
  const LyricPage({Key? key, required this.songNumber, required this.songTitle})
      : super(key: key);
  final String songTitle;
  final int songNumber;

  lyricsOfSong(int num) {
    switch (num) {
      case 1:
        return "EOne";
      case 2:
        return "HTwo";
      default:
        return "zero";
    }
  }

  @override
  Widget build(BuildContext context) {
    var gb = Globals();
    gb.pageFlag = true;
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songNumber.toString().padLeft(3, '0') + "         " + songTitle,
              style: TextStyle(
                color: Colors.blue.shade800,
                fontWeight: FontWeight.w900,
                fontFamily: 'Old English',
                letterSpacing: 0.75,
                fontSize: 20,
              ),
            ),
            Container(
              padding: EdgeInsets.all(25),
              child: Center(
                child: Text(lyricsOfSong(songNumber)),
              ),
            )
          ],
        ));
  }
}
