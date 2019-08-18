import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'Separator.dart';
import 'Style.dart';

class DetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget with PreferredSizeWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: buildAppBar(context),
        body: new Container(
          constraints: new BoxConstraints.expand(),
          color: new Color(0xFF736AB7),
          child: new Stack(
            children: <Widget>[
              planetThumbnail,
              _getGradient(),
              _getContent(),
              _getToolbar(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new BackButton(color: Colors.white),
    );
  }

  Container _getContent() {
    final _overviewTitle = "Overview".toUpperCase();
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
//          new PlanetSummary(planet,
//            horizontal: false,
//          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  _overviewTitle,
                  style: Style.headerTextStyle,
                ),
                new Separator(),
                new Text("Description", style: Style.commonTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final planetThumbnail = new Container(
    margin: new EdgeInsets.symmetric(vertical: 10.0),
    alignment: FractionalOffset.centerLeft,
    child: new Hero(
      tag: "planet-hero- assets/img/ic_distance.png",
      child: CachedNetworkImage(
        imageUrl:
            "https://cdn4.iconfinder.com/data/icons/world-flags-circular/1000/Flag_of_The_United_Nations_-_Circle-512.png",
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.assistant_photo),
      ),
    ),
  );

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[new Color(0x00736AB7), new Color(0xFF736AB7)],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: Text(
        "Detials View",
        style: new TextStyle(color: Colors.white),
      ),
    );
  }
}
