import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/models/product_detail_variant.dart';
import 'package:clothes_app/models/product_model.dart';
import 'package:clothes_app/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clothes_app/components/cart_button.dart';
import 'package:clothes_app/components/custom_modal_bottom_sheet.dart';
import 'package:clothes_app/components/network_image_with_loader.dart';
import 'package:clothes_app/screens/product/views/added_to_cart_message_screen.dart';
import 'package:clothes_app/screens/product/views/components/product_list_tile.dart';
import 'package:clothes_app/screens/product/views/location_permission_store_availability_screen.dart';
import 'package:clothes_app/screens/product/views/size_guide_screen.dart';
import 'components/product_quantity.dart';
import 'components/selected_colors.dart';
import 'components/selected_size.dart';
import 'components/unit_price.dart';

class ProductBuyNowScreen extends StatefulWidget {
  const ProductBuyNowScreen({super.key, required this.product, required this.productDetailVariant});
  final ProductModel product;
  final ProductDetailVariant productDetailVariant;
  
  @override
  State<ProductBuyNowScreen> createState() => _ProductBuyNowScreenState();
}

class _ProductBuyNowScreenState extends State<ProductBuyNowScreen> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int _currentQuantity = 1;
  final CartService cartService = CartService();

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
      // bottomNavigationBar: CartButton(
      //   price: widget.product.price * _currentQuantity,
      //   title: "Mua ngay",
      //   subTitle: "Tổng tiền",
      //   press: () {
      //     customModalBottomSheet(
      //       context,
      //       isDismissible: false,
      //       child: const AddedToCartMessageScreen(),
      //     );

      //     // fetch api to add product to cart
      //   },
      // ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.shopping_cart, color: Colors.red),
                label: const Text(
                  'Thêm vào giỏ',
                  style: TextStyle(color: Colors.red),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.red),
                ),
                onPressed: () async {
                  bool isAdded = await cartService.addtoCart(
                    widget.product.productId,
                    widget.productDetailVariant.sizeIds[_selectedSizeIndex],
                    widget.productDetailVariant.colorIds[_selectedColorIndex],
                    _currentQuantity,
                  );
                  customModalBottomSheet(
                    context,
                    isDismissible: false,
                    child: isAdded ? const AddedToCartMessageScreen(message: "Thêm vào giỏ hàng thành công") : const AddedToCartMessageScreen(message: "Thêm vào giỏ hàng thất bại"),
                  );
                  // fetch api to add product to cart
                },
                // child: const Text('Thêm vào giỏ'),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: CartButton(
                price: widget.product.price * _currentQuantity,
                title: "Mua ngay",
                subTitle: "Tổng tiền",
                press: () async {
                 
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2, vertical: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                Text(
                  widget.product.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                IconButton(
                  onPressed: () {},
                  icon: 
                    // SvgPicture.asset("assets/icons/Bookmark.svg",
                    //   color: Theme.of(context).textTheme.bodyLarge!.color),
                    SvgPicture.asset(
                      "assets/icons/Bookmark.svg",
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).textTheme.bodyLarge!.color!,
                        BlendMode.srcIn,
                      ),
                    ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: AspectRatio(
                      aspectRatio: 1.05,
                      child: NetworkImageWithLoader(widget.product.image),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: UnitPrice(
                            price: widget.product.price,
                            priceAfterDiscount: widget.product.price,
                          ),
                        ),
                        ProductQuantity(
                          numOfItem: _currentQuantity,
                          onIncrement: () {
                            setState(() {
                              _currentQuantity++;
                            });
                          },
                          onDecrement: () {
                            setState(() {
                              if (_currentQuantity > 1) {
                                _currentQuantity--;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Divider()),
                SliverToBoxAdapter(
                  child: SelectedColors(
                    colors: widget.productDetailVariant.colorIds.map((colorCode) => colorMap[colorCode]).whereType<Color>().toList(),
                    selectedColorIndex: _selectedColorIndex,
                    press: (value) {
                      setState(() {
                        _selectedColorIndex = value;
                      });
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: SelectedSize(
                    sizes: widget.productDetailVariant.sizeIds,
                    selectedIndex: _selectedSizeIndex,
                    press: (value) {
                      setState(() {
                        _selectedSizeIndex = value;
                      });
                    },
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  sliver: ProductListTile(
                    title: "Hướng dẫn chọn Size",
                    svgSrc: "assets/icons/Sizeguid.svg",
                    isShowBottomBorder: true,
                    press: () {
                      customModalBottomSheet(
                        context,
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: const SizeGuideScreen(),
                      );
                    },
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: defaultPadding / 2),
                        Text(
                          "Nhận hàng tài của hàng",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        const Text(
                            "Chọn kích thước để kiểm tra tình trạng còn hàng tại cửa hàng và tùy chọn nhận hàng tại cửa hàng.")
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  sliver: ProductListTile(
                    title: "Kiểm tra cửa hàng",
                    svgSrc: "assets/icons/Stores.svg",
                    isShowBottomBorder: true,
                    press: () {
                      customModalBottomSheet(
                        context,
                        height: MediaQuery.of(context).size.height * 0.92,
                        child: const LocationPermissonStoreAvailabilityScreen(),
                      );
                    },
                  ),
                ),
                const SliverToBoxAdapter(
                    child: SizedBox(height: defaultPadding))
              ],
            ),
          )
        ],
      ),
    );
  }
}
