import 'package:flutter_shopping_app/features/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';

import '../../Models/product.dart';
import '../../services/home_services.dart';
import '../../widgets/loader.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  final service = HomeServices();
  Product? product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealsOfTheDay();
  }

  void fetchDealsOfTheDay() async {
    product = await service.fetchDealsOfTheDay(context);
    setState(() {});
  }

  void navigateToDetailsScreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.screenName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : SingleChildScrollView(
                child: GestureDetector(
                  onTap: navigateToDetailsScreen,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 10,
                        ),
                        child: const Text(
                          "Deal of the day",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(product!.images[0]),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 15),
                        child: const Text(
                          "\$99",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding:
                            const EdgeInsets.only(left: 15, top: 5, right: 40),
                        child: const Text(
                          "Kashif",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.images
                              .map(
                                (e) => Image.network(
                                  e,
                                  fit: BoxFit.fitWidth,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 15, top: 15, bottom: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "All Deals",
                          style: TextStyle(color: Colors.cyan[800]),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
