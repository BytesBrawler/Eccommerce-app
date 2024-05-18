import 'package:amazon_clone/features/home/widgets/productView.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/products.dart';
import '../../product_details/screens.dart/product_details_screen.dart';
import '../services/home_service.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({
    super.key,
  });

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final HomeServices homeServices = HomeServices();
  List<Product>? products = [];

  @override
  void initState() {
    super.initState();

    getProducts();
  }

  getProducts() async {
    products = await homeServices.fetchAllProducts(context: context);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : GridView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: products!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ProductDetailScreen.routeName,
                    arguments: products![index],
                  );
                },
                child: ProductView(
                  product: products![index],
                ),
              );
            },
          );
  }
}
