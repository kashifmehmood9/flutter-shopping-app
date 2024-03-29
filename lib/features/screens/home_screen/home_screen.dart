import 'package:flutter_shopping_app/features/screens/widgets/address_box.dart';
import 'package:flutter_shopping_app/features/screens/widgets/carousel_image.dart';
import 'package:flutter_shopping_app/features/screens/widgets/deal_of_the_day.dart';
import 'package:flutter_shopping_app/features/screens/widgets/top_categories.dart';
import "package:flutter/material.dart";
import 'package:flutter_shopping_app/features/search/search_screen.dart';
import '../../../Constants/Constants.dart';
import '../../services/search_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSeachScreen(String query) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            const SizedBox(
              height: 10,
            ),
            const TopCategories(),
            const SizedBox(
              height: 10,
            ),
            const CarousellImage(),
            const SizedBox(
              height: 10,
            ),
            const DealOfTheDay()
          ],
        ),
      ),
    );
  }
}
