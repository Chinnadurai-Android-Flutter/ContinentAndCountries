import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'DetailPage.dart';
import 'DetailsView.dart';
import 'model/ModelResponse.dart';

class PlanetRow extends StatelessWidget {
  final ModelResponse modelResponse;

  final bool horizontal;
  final bool isfromMain;

  PlanetRow(this.modelResponse,
      {this.horizontal = true, this.isfromMain = true});

  @override
  Widget build(BuildContext context) {
    final planetThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      alignment: FractionalOffset.centerLeft,
      child: SvgPicture.network(
        modelResponse.flag,
        placeholderBuilder: (context) => CircularProgressIndicator(),
        height: 128.0,
      ),
    );

    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(
      color: Colors.blueGrey,
      fontSize: 10.0,
      decoration: TextDecoration.none,
      wordSpacing: 0.0,
    );
    final subHeaderTextStyle = regularTextStyle.copyWith(
      fontSize: 16.0,
      decoration: TextDecoration.none,
    );
    final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.blue,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    );

    Widget _planetValue({String value, String image}) {
      return new Row(children: <Widget>[
        new Image.asset(image, height: 12.0),
        new Container(width: 5.0),
        new Text(value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: regularTextStyle),
      ]);
    }

    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 2.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(modelResponse.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: headerTextStyle),
          new Container(height: 5.0),
          new Text(modelResponse.capital,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: subHeaderTextStyle),
          new Container(
              margin: new EdgeInsets.fromLTRB(0.0, 2.0, 2.0, 8.0),
              height: 2.0,
              width: 30.0,
              color: new Color(0xff00c6ff)),
          new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Flexible(
                  child: _planetValue(
                      value: modelResponse.demonym,
                      image: 'assets/img/earth.png'),
                  fit: FlexFit.tight,
                  flex: 1,
                ),
                new Flexible(
                  child: _planetValue(
                      value: modelResponse.region,
                      image: 'assets/img/ic_distance.png'),
                  fit: FlexFit.tight,
                  flex: 1,
                )
              ],
            ),
          ),
        ],
      ),
    );

    final planetCard = new Container(
      child: Card(
        elevation: 20.0,
        child: planetCardContent,
      ),
      height: 125.0,
      margin: new EdgeInsets.all(5.0),
    );
    return new GestureDetector(
        onTap: () {
          if (isfromMain) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(modelResponse)),
            );
          }
        },
        child: new Container(
          height: 120.0,
          margin: const EdgeInsets.symmetric(
            vertical: 1.0,
            horizontal: 10.0,
          ),
          child: new Stack(
            children: <Widget>[
//              planetThumbnail,
              planetCard,
            ],
          ),
        ));
  }
}
