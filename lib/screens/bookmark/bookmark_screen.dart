import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:clothes_app/components/product/product_card.dart';
import 'package:clothes_app/models/product_model.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: defaultPadding,
                crossAxisSpacing: defaultPadding,
                childAspectRatio: 0.66,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ProductCard(
                    image: demoPopularProducts[index].image,
                    name: demoPopularProducts[index].name,
                    description: demoPopularProducts[index].description,
                    price: demoPopularProducts[index].price,
                    // priceAfetDiscount:
                    //     demoPopularProducts[index].priceAfetDiscount,
                    discountpercent: demoPopularProducts[index].discountpercent,
                    press: () {
                      Navigator.pushNamed(context, productDetailsScreenRoute);
                    },
                  );
                },
                childCount: demoPopularProducts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
