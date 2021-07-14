import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: MyHomePage(title: 'Flutter Demo ListView with Button'));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final List<String> list = List.generate(10, (index) => 'Text $index');
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class SongDetail {
  String strTitle;
  var isFavorite = false;

  SongDetail(this.strTitle, this.isFavorite);
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

class _MyHomePageState extends State<MyHomePage> {
  List<SongDetail> arrSongList = [
    new SongDetail("O Worship the Lord", false),
    new SongDetail("Simbahon naton si Ginoong Jesu-Cristo", false),
    new SongDetail("strTitle3", true),
    new SongDetail("strTitle3", true),
  ];
  @override
  Widget build(BuildContext context) {
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
              String t = arrSongList[index].strTitle;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LyricPage(
                            songNumber: n,
                            songTitle: t,
                          )));
            },
            child: Container(
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
                              (index + 1).toString().padLeft(3, '0') +
                                  "       " +
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
                )),
          );
        },
      ),
    );
  }
}

class LyricPage extends StatefulWidget {
  LyricPage({Key? key, required this.songNumber, required this.songTitle})
      : super(key: key);
  final String songTitle;
  final int songNumber;
  @override
  LyricPageState createState() => LyricPageState();
}

class LyricPageState extends State<LyricPage> {
  lyricsOfSong(int num) {
    switch (num) {
      case 1:
        return "dasd";
      case 2:
        return "";
      default:
        return "dasfagsdgaa";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.songTitle),
        ),
        body: Center(
          child: Text(lyricsOfSong(widget.songNumber + 1)),
          // child: TextButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   child: Text('back'),
          // ),
        ));
  }
}
