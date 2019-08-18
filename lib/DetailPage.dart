import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'PlanetRow.dart';
import 'Separator.dart';
import 'Style.dart';
import 'model/Currencies.dart';
import 'model/Languages.dart';
import 'model/ModelResponse.dart';
import 'package:intl/intl.dart';
import 'package:rating_bar/rating_bar.dart';

class DetailPage extends StatelessWidget {
  List<ModelResponse> responseList = new List<ModelResponse>();
  final ModelResponse modelResponse;

  DetailPage(this.modelResponse);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: buildAppBar(context),
        body: new Container(
          constraints: new BoxConstraints.expand(),
          color: Colors.white,
          child: new Stack(
            children: <Widget>[
              _getContent(),
            ],
          ),
        ),
      ),
    );
  }

  void feedBacksAlert(BuildContext context) {
    var alertDialog = Alert();

    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.red,
      ),
    );
    alertDialog = Alert(
      context: context,
      type: AlertType.success,
      style: alertStyle,
      title: "Feedbacks",
      desc: "This application is more awesome with your feedback",
      content: RatingBar(
        filledIcon: Icons.star,
        emptyIcon: Icons.star_border,
        halfFilledIcon: Icons.star_half,
        isHalfAllowed: true,
        filledColor: Colors.blue,
        emptyColor: Colors.redAccent,
        halfFilledColor: Colors.grey,
        size: 48,
      ),
      buttons: [
        DialogButton(
          child: Text(
            "SUBMIT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => {_dismissDialog(context)},
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    );
    alertDialog.show();
  }

  _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }

  void submitButtonClick(Alert alertDialog) {
    if (alertDialog != null) {}
  }

  Container _getContent() {
    final formatter = new NumberFormat("#,###");

    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 32.0),
        children: <Widget>[
          _getGradient(),
          new PlanetRow(
            modelResponse,
            isfromMain: false,
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(15.0, 5.5, 15.0, 30.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _planetValue(
                    value:
                        "Population - ${formatter.format(modelResponse.population)}",
                    image: 'assets/img/mars.png'),
                _planetValue(
                    value: "Region - ${modelResponse.region}",
                    image: 'assets/img/mars.png'),
                _planetValue(
                    value: "Sub Region - ${modelResponse.subregion}",
                    image: 'assets/img/mars.png'),
                _planetValue(
                    value: "Native Name - ${modelResponse.nativeName}",
                    image: 'assets/img/mars.png'),
                currenciesListValues(),
                borderListValues(),
                timeZonesListValues(),
                languagesListValues(),
                callingCodeListValues(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _planetValue({String value, String image}) {
    return new Card(
      elevation: 5.0,
      child: new Column(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.fromLTRB(10.5, 10.5, 0.0, 10.5),
            child: Row(children: <Widget>[
              new Container(
                  margin: new EdgeInsets.fromLTRB(15.0, 5.5, 5.0, 0.0),
                  child: Image.asset(
                    image,
                    width: 30.0,
                    height: 30.0,
                  )),
              new Container(width: 1.0),
              new Text(value,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Style.commonTextStyle),
            ]),
          ),
          new Container(
            child: SeparatorDetails(),
          ),
        ],
      ),
    );
  }

  Widget borderListValues() {
    if (modelResponse.borders.length != null &&
        modelResponse.borders.length > 0) {
      var name = "Border country";
      if (modelResponse.borders.length >= 2) {
        name = "Border countries";
      }

      return new Container(
        padding: new EdgeInsets.all(10.5),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Style.commonDetailsTextStyle),
            new Container(
              height: 60.0,
              child: ListView(
                padding: EdgeInsets.all(2.0),
                scrollDirection: Axis.horizontal,
                children: modelResponse.borders
                    .map((data) => borderCountries(data))
                    .toList(),
              ),
            ),
          ],
        ),
      );
    } else {
      return new Container();
    }
  }

  Container borderCountries(String countryCode) {
//    if (responseList != null)
//      for (var countryDetails in responseList) {
//        if (countryCode.compareTo(countryDetails.cioc) != null) {
//          countryCode = countryDetails.name;
//        }
//      }

    Text childValues;
    if (countryCode != null) {
      if (responseList != null)
        for (var countryDetails in responseList) {
          if (countryCode.compareTo(countryDetails.cioc) != null) {
            countryCode = countryDetails.name;
          }
        }
      childValues = new Text("$countryCode ",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Style.currencyTextColor);
    }

    return new Container(
      margin: new EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
      alignment: Alignment.center,
      child: childValues,
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.red),
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
          color: Colors.transparent),
      padding: new EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
    );
  }

  Widget currenciesListValues() {
    if (modelResponse.currencies != null &&
        modelResponse.currencies.length > 0) {
      var name = "Currency";

      return new Card(
          elevation: 10.0,
          child: new Container(
            padding: new EdgeInsets.all(10.5),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Style.commonDetailsTextStyle),
                new Container(
                  height: 30.0,
                  child: ListView(
                    padding: EdgeInsets.all(2.0),
                    scrollDirection: Axis.horizontal,
                    children: modelResponse.currencies
                        .map((data) => currencyText(data))
                        .toList(),
                  ),
                ),
              ],
            ),
          ));
    } else {
      return new Container();
    }
  }

  Container currencyText(Currencies currencies) {
    Text child;
    if (currencies.symbol != null) {
      child = new Text("${currencies.symbol} ${currencies.name} ",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Style.currencyTextColor);
    } else {
      child = new Text("${currencies.name}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Style.currencyTextColor);
    }
    return new Container(child: child);
  }

  Container _getGradient() {
    return new Container(
      child: Container(
        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: Container(
          alignment: Alignment.center,
          child: SvgPicture.network(
            modelResponse.flag,
            placeholderBuilder: (context) => CircularProgressIndicator(),
            height: 130.0,
          ),
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[Colors.grey, Colors.white],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Widget timeZonesListValues() {
    if (modelResponse.timezones != null && modelResponse.timezones.length > 0) {
      var name = "Time Zone";
      if (modelResponse.timezones.length >= 2) name = "Time Zones";
      return new Container(
        padding: new EdgeInsets.all(10.5),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Style.commonDetailsTextStyle),
            new Container(
              height: 60.0,
              child: ListView(
                padding: EdgeInsets.all(2.0),
                scrollDirection: Axis.horizontal,
                children: modelResponse.timezones
                    .map((data) => CircleAvatar(
                          minRadius: 30.0,
                          backgroundColor: Colors.red,
                          child: Text(data,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                              )),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      );
    } else {
      return new Container();
    }
  }

  Widget languagesListValues() {
    if (modelResponse.languages != null && modelResponse.languages.length > 0) {
      var name = "Language";
      if (modelResponse.languages.length >= 2) name = "Languages";
      return new Container(
        padding: new EdgeInsets.all(10.5),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Style.commonDetailsTextStyle),
            new Container(
              height: 60.0,
              child: ListView(
                padding: EdgeInsets.all(5.0),
                scrollDirection: Axis.horizontal,
                children: modelResponse.languages
                    .map((data) => languageText(data))
                    .toList(),
              ),
            ),
          ],
        ),
      );
    } else {
      return new Container();
    }
  }

  Container languageText(Languages languages) {
    Text childValues;
    if (languages.name != null) {
      childValues = new Text("${languages.name} ",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Style.currencyTextColor);
    }

    return new Container(
      margin: new EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
      alignment: Alignment.center,
      child: childValues,
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.red),
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
          color: Colors.transparent),
      padding: new EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
    );
  }

  Widget callingCodeListValues() {
    print("cioc ${modelResponse.cioc}");
    if (modelResponse.callingCodes != null &&
        modelResponse.callingCodes.length > 0) {
      var name = "Calling Code";
      if (modelResponse.callingCodes.length >= 2) name = "Calling Codes";
      return new Container(
        padding: new EdgeInsets.all(10.5),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Style.commonDetailsTextStyle),
            new Container(
              height: 60.0,
              child: ListView(
                padding: EdgeInsets.all(2.0),
                scrollDirection: Axis.horizontal,
                children: modelResponse.callingCodes
                    .map((data) => CircleAvatar(
                          minRadius: 30.0,
                          backgroundColor: Colors.red,
                          child: Text("+$data",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              )),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      );
    } else {
      return new Container();
    }
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      backgroundColor: Colors.red,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, false),
      ),
      title: Text(
        "${modelResponse.name}",
        style: new TextStyle(color: Colors.white),
      ),
    );
  }
}
