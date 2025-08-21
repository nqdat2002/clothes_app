import 'package:clothes_app/helpers/constants.dart';
import 'package:flutter/material.dart';

class ProductReturnsScreen extends StatelessWidget {
  const ProductReturnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: defaultPadding),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                    child: BackButton(),
                  ),
                  Text(
                    "Return",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Text(
                "Trả hàng và đổi hàng trả trước miễn phí cho các đơn hàng được vận chuyển. Được hoàn tiền nhanh hơn với dịch vụ trả hàng trực tuyến dễ dàng và in nhãn trả hàng trả trước MIỄN PHÍ! Trả lại hoặc đổi bất kỳ hàng hóa chưa sử dụng hoặc bị lỗi nào qua đường bưu điện hoặc tại một trong các địa điểm cửa hàng của chúng tôi tại Việt Nam. Các mặt hàng được sản xuất theo đơn đặt hàng không thể hủy, đổi hoặc trả lại.",
              ),
            )
          ],
        ),
      ),
    );
  }
}
