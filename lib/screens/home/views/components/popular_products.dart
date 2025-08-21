import 'package:clothes_app/components/product/product_card.dart';
import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/models/product_model.dart';
import 'package:clothes_app/routes/route_constants.dart';
import 'package:flutter/material.dart';

class PopularProducts extends StatefulWidget{
  const PopularProducts({super.key, required this.popularProducts});
  final List<ProductModel> popularProducts;

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
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
            "Những sản phẩm phổ biến",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // const ProductsSkelton(),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.popularProducts.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: defaultPadding,
                right: index == widget.popularProducts.length - 1
                    ? defaultPadding
                    : 0,
              ),
              child: ProductCard(
                image: widget.popularProducts[index].image,
                name: widget.popularProducts[index].name,
                description: widget.popularProducts[index].description,
                price: widget.popularProducts[index].price,
                // priceAfetDiscount: widget.popularProducts[index].priceAfetDiscount,
                discountpercent: widget.popularProducts[index].discountpercent,
                press: () {
                  Navigator.pushNamed(context, productDetailsScreenRoute,
                      arguments: <String, dynamic> {
                        "status": widget.popularProducts[index].status,
                        "productId": widget.popularProducts[index].productId,
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