import 'dart:core';
import 'dart:core';

import 'package:flutter_shopping_app/features/Models/product.dart';
import 'package:flutter_shopping_app/features/screens/product_details/product_details.dart';
import 'package:flutter_shopping_app/features/services/home_services.dart';
import 'package:flutter_shopping_app/features/widgets/loader.dart';
import 'package:flutter/material.dart';

import '../../../Constants/Constants.dart';

class CategoryDealsScreen extends StatefulWidget {
  const CategoryDealsScreen({Key? key, required this.category})
      : super(key: key);
  final String category;
  static const String screenName = "/category-deals";
  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  final homeService = HomeServices();
  List<Product>? productlist;
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productlist =
        await homeService.fetchCategoryProducts(context, widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
        title: Text(
          widget.category,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: productlist == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Keep shopping for ${widget.category}",
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 15),
                    itemCount: productlist?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.4,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      Product product = productlist![index];
                      return GestureDetector(
                        onTap: () {
                          debugPrint("Product tapped");
                          Navigator.pushNamed(
                              context, ProductDetailsScreen.screenName,
                              arguments: product);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black12, width: 0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(product.images[0]),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                  left: 0, top: 5, right: 15),
                              child: Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
