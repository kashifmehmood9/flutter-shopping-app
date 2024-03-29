import 'package:flutter_shopping_app/common/custom_button.dart';
import 'package:flutter_shopping_app/features/address/screens/address_screen.dart';
import 'package:flutter_shopping_app/features/cart/widgets/cart_product.dart';
import 'package:flutter_shopping_app/features/cart/widgets/cart_subtotal.dart';
import 'package:flutter_shopping_app/features/providers/user_provider.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import '../../../Constants/Constants.dart';
import '../../screens/widgets/address_box.dart';
import '../../search/search_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSeachScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.screenName, arguments: query);
  }

  void navigateToAddressScreen(double sum) {
    Navigator.pushNamed(context, AddressScreen.screenName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().get();
    double sum = 0;
    user.cart.map((e) => sum += e.product.price * e.quantity).toList();
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
      body: user.cart.isEmpty
          ? Center(child: Text("Cart is empty"))
          : Column(
              children: [
                AddressBox(),
                CartSubtotal(),
                CustomButton(
                  text: "Proceed to Buy ${user.cart.length} Item(s)",
                  onTap: () => navigateToAddressScreen(sum),
                  color: Colors.yellow,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  color: Colors.black12.withOpacity(0.08),
                  height: 1,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: user.cart.length,
                    itemBuilder: (context, index) {
                      return CartProduct(index: index);
                    },
                  ),
                )
              ],
            ),
    );
  }
}
