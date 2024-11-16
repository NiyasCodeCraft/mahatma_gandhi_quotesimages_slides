import 'package:flutter/material.dart';
import 'package:mahatma_gandhi_quotesimages_slides/appimages.dart';

class DisplayImages extends StatefulWidget {
  final AppImages appImages;

  const DisplayImages({super.key, required this.appImages});

  @override
  State<DisplayImages> createState() => _DisplayImagesState();
}

class _DisplayImagesState extends State<DisplayImages> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(45),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
            image:
                DecorationImage(image: AssetImage(widget.appImages.imagePath),fit: BoxFit.cover)),
      ),
    );
  }
}
