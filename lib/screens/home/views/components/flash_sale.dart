import 'package:clothes_app/components/product/product_card.dart';
// import 'package:clothes_app/components/skleton/product/products_skelton.dart';
import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/models/product_model.dart';
import 'package:clothes_app/routes/route_constants.dart';

import 'package:flutter/material.dart';

import '/components/Banner/M/banner_m_with_counter.dart';

class FlashSale extends StatefulWidget {
  const FlashSale({super.key, required this.flashSaleProducts});

  final List<ProductModel> flashSaleProducts;

  @override
  State<FlashSale> createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // While loading show 👇
        // const BannerMWithCounterSkelton(),
        BannerMWithCounter(
          duration: const Duration(hours: 8),
          text: "\n \n \n",
          press: () {},
        ),
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Siêu giảm giá",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // const ProductsSkelton(),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Find demoFlashSaleProducts on models/ProductModel.dart
            itemCount: widget.flashSaleProducts.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: defaultPadding,
                right: index == widget.flashSaleProducts.length - 1
                    ? defaultPadding
                    : 0,
              ),
              child: ProductCard(
                image: widget.flashSaleProducts[index].image,
                name: widget.flashSaleProducts[index].name,
                description: widget.flashSaleProducts[index].description,
                price: widget.flashSaleProducts[index].price,
                // priceAfetDiscount:
                //     demoFlashSaleProducts[index].priceAfetDiscount,
                discountpercent: widget.flashSaleProducts[index].discountpercent,
                press: () {
                  Navigator.pushNamed(context, productDetailsScreenRoute,
                      arguments: <String, dynamic>{
                        "status": widget.flashSaleProducts[index].status,
                        "productId": widget.flashSaleProducts[index].productId,
                      });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}