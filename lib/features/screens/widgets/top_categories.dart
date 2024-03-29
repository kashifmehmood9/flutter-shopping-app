import 'package:flutter_shopping_app/Constants/Constants.dart';
import 'package:flutter_shopping_app/features/Models/category_images.dart';
import 'package:flutter_shopping_app/features/screens/home_screen/categroy_deals_screen.dart';
import "package:flutter/material.dart";

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  List<CatergoryImages> getCategoryImages() {
    return GlobalVariables.categoryImages.map((e) {
      return CatergoryImages(imageSource: e["image"]!, imageTitle: e["title"]!);
    }).toList();
  }

  void navigateToCategory(String category, BuildContext context) {
    Navigator.pushNamed(context, CategoryDealsScreen.screenName,
        arguments: category);
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
          return GestureDetector(
            onTap: () => navigateToCategory(
                getCategoryImages()[index].imageTitle, context),
            child: Column(
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
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
