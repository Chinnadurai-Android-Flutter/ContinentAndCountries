import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PlanetRow.dart';
import 'model/ModelResponse.dart';

void main() => runApp(MyApp());

List<ModelResponse> responseListOriginal = List<ModelResponse>();
List<ModelResponse> responseList = List<ModelResponse>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ''),
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

  List<ModelResponse> originalValues() {
    return responseList;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final dio = new Dio(); // for http requests
  List names = new List(); // names we get from API
  List filteredNames = new List(); // names filtered by search text

  Widget appBarTitle = new Text(
    "Countries",
    style: new TextStyle(color: Colors.white),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  @override
  void initState() {
    responseList.clear();
    List<ModelResponse> responseListTemp = List<ModelResponse>();
    responseListTemp.clear();
    List tempList = new List();
    responseList.clear();
    DefaultAssetBundle.of(context)
        .loadString("assets/json/document.json")
        .then((onValue) {
      for (var name in json.decode(onValue)) {
        var tempModelValues = ModelResponse.fromJson(name);
        tempList.add(tempModelValues.name);
        responseListOriginal.add(tempModelValues);
      }

      setState(() {
        responseList = responseListOriginal;
      });
    }).catchError((onError) {
      print("Exception-> $onError");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: new Center(
              child: new Container(
            color: Colors.transparent,
            child: new CustomScrollView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              slivers: <Widget>[
                new SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  sliver: new SliverList(
                    delegate: new SliverChildBuilderDelegate(
                      (context, index) => new PlanetRow(responseList[index]),
                      childCount: responseList.length,
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[]);
  }

//To get json file form API
  Future fetchPost() async {
    print("sarted");
    List tempList = new List();
    List<ModelResponse> responseListTemp = List<ModelResponse>();
    responseList.clear();
    responseListTemp.clear();
    final response = await http.get('https://restcountries.eu/rest/v2/all');
    if (response.statusCode == 200) {
      for (var name in json.decode(response.body)) {
        var tempModelValues = ModelResponse.fromJson(name);
        tempList.add(tempModelValues.name);
        responseList.add(tempModelValues);
      }
      setState(() {
        responseList = responseListTemp;
      });
    } else {
      throw Exception('Failed to load post');
    }
  }


}
