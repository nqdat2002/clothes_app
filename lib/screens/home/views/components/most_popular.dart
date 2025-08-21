// import 'package:clothes_app/components/skleton/product/secondery_produts_skelton.dart';
import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:clothes_app/components/product/secondary_product_card.dart';
import 'package:clothes_app/models/product_model.dart';

class MostPopular extends StatefulWidget {
  const MostPopular({super.key, required this.mostPopular});

  final List<ProductModel> mostPopular;

  @override
  State<MostPopular> createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
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
            "Phổ biến nhất",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // const SeconderyProductsSkelton(),
        SizedBox(
          height: 114,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Find demoPopularProducts on models/ProductModel.dart
            itemCount: widget.mostPopular.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: defaultPadding,
                right:
                    index == widget.mostPopular.length - 1 ? defaultPadding : 0,
              ),
              child: SecondaryProductCard(
                image: widget.mostPopular[index].image,
                name: widget.mostPopular[index].name,
                description: widget.mostPopular[index].description,
                price: widget.mostPopular[index].price,
                // priceAfetDiscount: demoPopularProducts[index].priceAfetDiscount,
                discountpercent: widget.mostPopular[index].discountpercent,
                press: () {
                  Navigator.pushNamed(context, productDetailsScreenRoute,
                      arguments: <String, dynamic>{
                        "status": widget.mostPopular[index].status,
                        "productId": widget.mostPopular[index].productId,
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