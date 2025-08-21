import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:clothes_app/components/product/product_card.dart';
import 'package:clothes_app/models/product_model.dart';

class BestSellers extends StatefulWidget {
  const BestSellers({
    super.key, required this.bestSellers,
  });

  final List<ProductModel> bestSellers;

  @override
  State<BestSellers> createState() => _BestSellersState();
}

class _BestSellersState extends State<BestSellers> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Bán chạy nhất",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // const ProductsSkelton(),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.bestSellers.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: defaultPadding,
                right: index == widget.bestSellers.length - 1
                    ? defaultPadding
                    : 0,
              ),
              child: ProductCard(
                image: widget.bestSellers[index].image,
                name: widget.bestSellers[index].name,
                description: widget.bestSellers[index].description,
                price: widget.bestSellers[index].price,
                // priceAfetDiscount:
                // demoBestSellersProducts[index].priceAfetDiscount,
                discountpercent: widget.bestSellers[index].discountpercent,
                press: () {
                  Navigator.pushNamed(context, productDetailsScreenRoute,
                      arguments: <String, dynamic>{
                        "status": widget.bestSellers[index].status,
                        "productId": widget.bestSellers[index].productId,
                      });
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}