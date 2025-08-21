import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/models/product_model.dart';
import 'package:clothes_app/screens/loading_screen.dart';
import 'package:clothes_app/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:clothes_app/components/Banner/S/banner_s_style_1.dart';
import 'package:clothes_app/components/Banner/S/banner_s_style_5.dart';
import 'components/best_sellers.dart';
import 'components/flash_sale.dart';
import 'components/most_popular.dart';
import 'components/offer_carousel_and_categories.dart';
import 'components/popular_products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductServices productServices = ProductServices();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<ProductModel>>(
          future: productServices.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingScreen());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Không tìm thấy Sản phẩm.'));
            }
            List<ProductModel> products = snapshot.data!;
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: OffersCarouselAndCategories()),
                SliverToBoxAdapter(
                  child: PopularProducts(
                    popularProducts: products,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding * 1.5),
                  sliver: SliverToBoxAdapter(
                      child: FlashSale(
                    flashSaleProducts: products,
                  )),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      BannerSStyle1(
                        title: "New \narrival",
                        subtitle: "SPECIAL OFFER",
                        discountParcent: 50,
                        press: () {
                          // Navigator.pushNamed(context, onSaleScreenRoute);
                        },
                      ),
                      const SizedBox(height: defaultPadding / 4),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: BestSellers(bestSellers: products,)),
                SliverToBoxAdapter(child: MostPopular(mostPopular: products)),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: defaultPadding * 1.5),
                      const SizedBox(height: defaultPadding / 4),
                      BannerSStyle5(
                        title: "Black \nfriday",
                        subtitle: "50% Off",
                        bottomText: "Collection".toUpperCase(),
                        press: () {
                          // Navigator.pushNamed(context, onSaleScreenRoute);
                        },
                      ),
                      const SizedBox(height: defaultPadding / 4),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: BestSellers(bestSellers: products)),

              ],
            );
          },
        ),
      ),
    );
  }
}
