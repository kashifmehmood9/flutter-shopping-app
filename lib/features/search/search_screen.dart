import 'package:flutter_shopping_app/features/screens/widgets/address_box.dart';
import 'package:flutter_shopping_app/features/services/search_services.dart';
import 'package:flutter_shopping_app/features/widgets/loader.dart';
import 'package:flutter_shopping_app/features/widgets/search_product.dart';
import 'package:flutter/material.dart';

import '../../Constants/Constants.dart';
import '../Models/product.dart';
import '../screens/product_details/product_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);
  static const String screenName = "/search-screen";
  final String searchQuery;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchService = SearchServices();

  List<Product>? listOfProducts;

  void fetchSearchString() async {
    listOfProducts =
        await searchService.searchProducts(context, widget.searchQuery);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchSearchString();
  }

  void navigateToSeachScreen(String query) {
    debugPrint("navigateToSeachScreen");
    Navigator.pushNamed(context, SearchScreen.screenName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSeachScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: "Search",
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 35,
                ),
              )
            ],
          ),
        ),
      ),
      body: listOfProducts == null
          ? Loader()
          : Column(
              children: [
                AddressBox(),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: listOfProducts?.length,
                    itemBuilder: (context, index) {
                      Product product = listOfProducts![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ProductDetailsScreen.screenName,
                              arguments: product);
                        },
                        child: SearchedProduct(
                          searchedProduct: product,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
