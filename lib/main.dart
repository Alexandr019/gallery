import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    fetchimages();
  }

  List? data;

  Future<String> fetchimages() async {
    var jsondata = await http.get(Uri.parse(
        "https://api.unsplash.com/search/photos?per_page=30&client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9&query=nature"));

    setState(() {
      data = json.decode(jsondata.body)['results'];
    });

    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gallery',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: data == null
          ? CircularProgressIndicator()
          : Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  "Gallery Wallpapers",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              body: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5.0),
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          FullScreenWidget(
                            child: Hero(
                              tag: 'Gallery',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  data![index]["urls"]['small'],
                                  height: 125,
                                  width: 125,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 5.0),
                                  child: Text(
                                    "User: " + data![index]['user']['name'],
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 50.0),
                                  child: Text(
                                    data![index]['alt_description'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
    );
  }
}
