import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  String text = "";
  String imgUrl = "";

  void _sendRecuest() async {
    Dio dio = Dio();
    Response response =
        await dio.get('https://cat-fact.herokuapp.com/facts/random');

    setState(() {
      text = response.data['text'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Dio App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: [
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              _sendRecuest();
            },
            child: const Text('Send Recuest'),
          ),
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20)),
            width: 300,
            child: Text(text),
          ),
          SizedBox(height: 100),
          // Image.network(imgUrl),
        ]),
      ),
    );
  }
}
