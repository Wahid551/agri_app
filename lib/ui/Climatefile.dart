import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:weatherapp/utils/apifile.dart' as util;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:agri_app/utils/apifile.dart' as util;

class climate extends StatefulWidget {
  @override
  _climateState createState() => _climateState();
}

class _climateState extends State<climate> {
   String _cityEntered='';
  // void showStuff() async {
  //   Map data = await getweather(util.apiID, util.defaultCity);
  //   print(data.toString());
  // }

  Future _gotonextScreen(BuildContext context) async {
    Map? result = await Navigator.of(context)
        .push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return climateChange();
    }));
    if (result != null && result.containsKey('enter')) {
      setState(() {
        _cityEntered = result['enter'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Climate App'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _gotonextScreen(context);
              }),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/images/w.png'),
              height: 1200.0,
              width: 600.0,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: Text(
              '${_cityEntered =='' ? util.defaultCity : _cityEntered}',
              style: TextStyle(fontSize: 22.0, fontStyle: FontStyle.italic),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 250.0, 0.0, 0.0),
            child: updateTempWidget(
                '${_cityEntered=='' ? util.defaultCity : _cityEntered}'),
          ),
        ],
      ),
    );
  }

  Future<Map> getweather(String apiId, String city) async {
    var client = http.Client();
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiId&units=imperial';
    //http://api.openweathermap.org/data/2.5/weather?q=vehari&appid=157657201861bba079bb304fdd5d014e&units=imperial
    var url = Uri.parse(apiUrl);
    // http.Response response = await http.get(apiUrl);
    var response = await client.get(url);
    print(response.statusCode);
    return json.decode(response.body);
  }

  Widget updateTempWidget(String city) {
    return FutureBuilder(
        future: getweather(util.apiID, city =='' ? util.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map? content = snapshot.data;
            return Container(
              margin: EdgeInsets.fromLTRB(30.0, 250.0, 0.0, 0.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      content!['main']['temp'].toString() + "F",
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 49.9,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: ListTile(
                      title: Text(
                        "Humidity: ${content!['main']['humidity'].toString()}\n"
                        "Min: ${content!['main']['temp_min'].toString()} F\n"
                        "Max: ${content!['main']['temp_max'].toString()} F",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}

class climateChange extends StatefulWidget {
  @override
  _climateChangeState createState() => _climateChangeState();
}

class _climateChangeState extends State<climateChange> {
  var _cityFieldController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text('Change City'),
      ),
      body: Stack(
        children: [
          new Center(
            child: Image(
              image: AssetImage('assets/images/snow.jpg'),
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          new ListView(
            children: [
              new ListTile(
                title: new TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter City',
                  ),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                ),
              ),
              new ListTile(
                title: new FlatButton(
                  onPressed: () {
                    Navigator.pop(
                        context, {'enter': _cityFieldController.text});
                  },
                  textColor: Colors.black,
                  color: Colors.redAccent,
                  child: new Text(
                    'Press Enter',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// }
//
