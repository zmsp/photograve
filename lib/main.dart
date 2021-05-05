import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:parallax_image/parallax_image.dart';
import 'package:sizer/sizer.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              child: MyHomePage(),
            ),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var imageData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    final jsonResult = json.decode(data);
    print(jsonResult);
    setState(() {
      imageData = jsonResult["home"];
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final imgurl in imageData)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: 20,
              child: new GestureDetector(
                onTap: () {
                  print('Tapped $imgurl');
                },
                child: new ParallaxImage(
                  extent: 500.0,
                  image: new NetworkImage(
                    imgurl,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "something just like this",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius:
                                  20.0, // has the effect of softening the shadow
                              spreadRadius:
                                  20, // has the effect of extending the shadow
                              // offset: Offset(
                              //   10.0, // horizontal, move right 10
                              //   10.0, // vertical, move down 10
                              // ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        '10-12-1921',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
