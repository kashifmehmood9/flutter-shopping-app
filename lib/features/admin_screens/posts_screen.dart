import 'package:amazon_clone/features/admin_screens/add_product_screen.dart';
import 'package:amazon_clone/features/screens/widgets/single_product.dart';
import 'package:amazon_clone/features/widgets/loader.dart';
import 'package:flutter/material.dart';

import '../Models/product.dart';
import '../services/admin_services.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreen();
}

class _PostsScreen extends State<PostsScreen> {
  final adminServices = AdminServices();
  List<Product>? listOfProducts;
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  void fetchAllProducts() async {
    listOfProducts = await adminServices.getAllProducts(context);
    setState(() {});
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName)
        .then((_) => fetchAllProducts());
  }

  void deleteProduct(Product product) async {
    await adminServices.deleteProduct(context, product, () {
      listOfProducts?.remove(product);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return listOfProducts == null
        ? Loader()
        : Scaffold(
            body: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: listOfProducts!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final product = listOfProducts![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 139,
                        child: SingleProduct(image: product.images[0]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteProduct(product);
                            },
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      )
                    ],
                  );
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: navigateToAddProduct,
              tooltip: "Add a product",
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
