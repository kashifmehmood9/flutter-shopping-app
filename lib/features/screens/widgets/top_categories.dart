import 'package:amazon_clone/Constants/Constants.dart';
import 'package:amazon_clone/features/Models/category_images.dart';
import "package:flutter/material.dart";

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  List<CatergoryImages> getCategoryImages() {
    return GlobalVariables.categoryImages.map((e) {
      return CatergoryImages(imageSource: e["image"]!, imageTitle: e["title"]!);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 80,
        itemCount: getCategoryImages().length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    getCategoryImages()[index].imageSource,
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              Text(
                getCategoryImages()[index].imageTitle,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          );
        },
      ),
    );
  }
}
