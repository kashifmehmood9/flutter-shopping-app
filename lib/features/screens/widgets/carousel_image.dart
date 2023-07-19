import 'package:flutter_shopping_app/Constants/Constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarousellImage extends StatelessWidget {
  const CarousellImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CarouselSlider(
        items: GlobalVariables.carouselImages.map((i) {
          return Builder(
            builder: (context) => Image.network(
              i,
              fit: BoxFit.cover,
            ),
          );
        }).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          // height: 200,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
        ),
      ),
    );
  }
}
