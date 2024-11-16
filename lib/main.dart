import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahatma_gandhi_quotesimages_slides/page_viewimage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: PageViewimage(),
    );
  }
}
