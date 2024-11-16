import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahatma_gandhi_quotesimages_slides/appimages.dart';
import 'package:mahatma_gandhi_quotesimages_slides/display_images.dart';
import 'package:mahatma_gandhi_quotesimages_slides/indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PageViewimage extends StatefulWidget {
  const PageViewimage({super.key});

  @override
  State<PageViewimage> createState() => _PageViewimageState();
}

class _PageViewimageState extends State<PageViewimage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            elevation: 10.0,
            title: Text(
              "Quotes of Mahatma Gandhi",
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) =>
                [
                  PopupMenuItem(
                      height: 40,
                      value: 1,
                      child: Row(
                        children: [
                          Icon(
                            Icons.share,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Text("Share Images"),
                        ],
                      )),
                ],
                offset: Offset(30, 60),
                elevation: 1,
                onSelected: (value) {
                  if (value == 1) {
                    print("-------->> Share Images Clicked");
                    _shareImages();
                  }
                },
              )
            ],
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 430,
                  width: 390,
                  child: PageView.builder(
                      onPageChanged: (index) {
                        setState(() {
                          print("-------on change slideed");
                          print(index);
                          selectedIndex = index;
                        });
                      },
                      itemCount: appImages.length,
                      itemBuilder: (context, index) {
                        var _quotes = appImages[index];
                        var _scale = selectedIndex == index ? 1.10 : 0.3;
                        return TweenAnimationBuilder(
                            tween: Tween(begin: _scale, end: _scale),
                            duration: Duration(milliseconds: 300),
                            child: DisplayImages(appImages: _quotes),
                            builder: (context, value, child) {
                              return Transform.scale(
                                  scale: value,
                                  child: child);
                            });
                      }),
                ),
                // SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                        appImages.length,
                            (index) =>
                            Indicator(
                                isActive: selectedIndex == index ? true : false))
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _shareImages() async {
    ByteData byteData = await rootBundle.load(
        appImages[selectedIndex].imagePath);
    Uint8List imageBytes = byteData.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final imageFile = File('${tempDir.path}/shared_image.jpg');
    await imageFile.writeAsBytes(imageBytes);
    final xFile = XFile(imageFile.path, mimeType: "image/jpg");

    await Share.shareXFiles([xFile], text: 'image');
  }
}
