import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  String text = 'Tap to button to start exploring';
  String imgUrl = '';

  void _sendRecuest() async {
    Dio textDio = Dio();
    Dio imgDio = Dio();
    try {
      Response textResponse =
          await textDio.get('https://cat-fact.herokuapp.com/facts/random');

      Response imgResponse =
          await imgDio.get('https://dog.ceo/api/breeds/image/random');

      setState(() {
        text = textResponse.data['text'];
        imgUrl = imgResponse.data['message'];
      });
    } catch (e) {
      setState(() {
        text = 'Nothing found';
        imgUrl =
            'https://st3.depositphotos.com/3050385/17908/v/1600/depositphotos_179080780-stock-illustration-error-404-creative-illustration-dachshund.jpg';
      });
    }
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
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              _sendRecuest();
            },
            child: const Text('Explore now!'),
          ),
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20)),
            width: 300,
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 100),
          SizedBox(
            width: 300,
            height: 200,
            child: Image.network(imgUrl != ''
                ? imgUrl
                : 'https:\/\/images.dog.ceo\/breeds\/retriever-curly\/n02099429_2393.jpg'),
          )
        ]),
      ),
    );
  }
}
