import 'package:clothes_app/components/review_card.dart';
import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/models/product_detail_model.dart';
import 'package:clothes_app/models/product_detail_variant.dart';
import 'package:clothes_app/models/product_model.dart';
import 'package:clothes_app/routes/route_constants.dart';
import 'package:clothes_app/services/product_detail_service.dart';
import 'package:clothes_app/services/product_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:clothes_app/components/buy_full_ui_kit.dart';
import 'package:clothes_app/components/cart_button.dart';
import 'package:clothes_app/components/custom_modal_bottom_sheet.dart';
import 'package:clothes_app/components/product/product_card.dart';
import 'package:clothes_app/screens/product/views/product_returns_screen.dart';

import 'components/notify_me_card.dart';
import 'components/product_images.dart';
import 'components/product_info.dart';
import 'components/product_list_tile.dart';
import 'product_buy_now_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(
      {super.key, this.isProductAvailable = true, this.productId = ""});

  final bool isProductAvailable;
  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductModel pro = ProductModel(
      productId: "",
      image: "",
      name: "",
      description: "",
      price: 0,
      status: false);
  ProductDetailsModel proDetails = ProductDetailsModel(
      product: ProductModel(
          productId: "",
          image: "",
          name: "",
          description: "",
          price: 0,
          status: false),
      sizeId: "",
      colorId: "",
      quantity: 0);

  ProductDetailVariant proVariant = ProductDetailVariant(sizeIds: [], colorIds: [], currentQuantity: 0);

  ProductServices productServices = ProductServices();
  ProductDetailService productDetailService = ProductDetailService();

  Future<void> _fetchProduct() async {
    try {
      ProductModel fetchedProduct =
          await productServices.getOne(widget.productId);
      ProductDetailVariant fetchedProductVariant =
          await productDetailService.getOneVariant(widget.productId);
      setState(() {
        pro = fetchedProduct;
        proVariant = fetchedProductVariant;
      });
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching product: $error");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget.isProductAvailable
          ? CartButton(
              price: pro.price,
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: ProductBuyNowScreen(
                    product: pro,
                    productDetailVariant: proVariant,
                  ),
                );
              },
            )
          :

          /// If profuct is not available then show [NotifyMeCard]
          NotifyMeCard(
              isNotify: false,
              onChanged: (value) {},
            ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  // icon: SvgPicture.asset("assets/icons/Bookmark.svg",
                  //     color: Theme.of(context).textTheme.bodyLarge!.color),
                  icon: SvgPicture.asset(
                    "assets/icons/Bookmark.svg",
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.bodyLarge!.color!,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            ProductImages(
              images: [pro.image.toString(), pro.image.toString()],
            ),
            ProductInfo(
              name: pro.name,
              isAvailable: widget.isProductAvailable,
              description: pro.description,
              rating: 4.4,
              numOfReviews: 126,
            ),
            ProductListTile(
              svgSrc: "assets/icons/Product.svg",
              title: "Chi tiết sản phẩm",
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mô tả",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        Text(
                          pro.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        
                      ],
                    ),
                  ),
                );
              },
            ),
            ProductListTile(
              svgSrc: "assets/icons/Delivery.svg",
              title: "Thông tin vận chuyển",
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: const BuyFullKit(
                    images: ["assets/screens/Shipping information.png"],
                  ),
                );
              },
            ),
            ProductListTile(
              svgSrc: "assets/icons/Return.svg",
              title: "Trả hàng",
              isShowBottomBorder: true,
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: const ProductReturnsScreen(),
                );
              },
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: ReviewCard(
                  rating: 4.3,
                  numOfReviews: 128,
                  numOfFiveStar: 80,
                  numOfFourStar: 30,
                  numOfThreeStar: 5,
                  numOfTwoStar: 4,
                  numOfOneStar: 1,
                ),
              ),
            ),
            ProductListTile(
              svgSrc: "assets/icons/Chat.svg",
              title: "Đánh giá",
              isShowBottomBorder: true,
              press: () {
                Navigator.pushNamed(context, productReviewsScreenRoute);
              },
            ),
            SliverPadding(
              padding: const EdgeInsets.all(defaultPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Bạn cũng có thể biết",
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                        left: defaultPadding,
                        right: index == 4 ? defaultPadding : 0),
                    child: ProductCard(
                      image: productDemoImg2,
                      description: "Sleeveless Tiered Dobby Swing Dress",
                      name: "LIPSY LONDON",
                      price: 24.65,
                      priceAfetDiscount: index.isEven ? 20.99 : null,
                      discountpercent: index.isEven ? 25 : null,
                      press: () {},
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            )
          ],
        ),
      ),
    );
  }
}
