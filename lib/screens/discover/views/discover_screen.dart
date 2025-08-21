import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/models/category_model.dart';
import 'package:clothes_app/models/product_model.dart';
import 'package:clothes_app/screens/search/views/components/search_form.dart';
import 'package:flutter/material.dart';

import 'components/expansion_category.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String keyword = "default_keyword";

  List<CategoryModel> filteredCategories = demoCategories;
  List<ProductModel> filteredProducts  = [];
  void showSearchKeyWord() {
    setState(() {
      filteredCategories = demoCategories.where((category) {
        return category.title.toLowerCase().contains(keyword.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: SearchForm(
                    onTabFilter: showSearchKeyWord,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Vui lòng nhập từ khóa";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        keyword = value!;
                      });
                    })),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: Text(
                "Phân loại",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            // While loading use 👇
            // const Expanded(
            //   child: DiscoverCategoriesSkelton(),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: demoCategories.length,
                itemBuilder: (context, index) => ExpansionCategory(
                  svgSrc: demoCategories[index].svgSrc!,
                  title: demoCategories[index].title,
                  subCategory: demoCategories[index].subCategories!,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: Text(
                "Kết quả tìm kiếm",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Expanded(
              child: filteredCategories.isEmpty
                  ? const Center(
                      child: Text(
                        "Không tìm thấy kết quả phù hợp.",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) => ExpansionCategory(
                        svgSrc: filteredCategories[index].svgSrc!,
                        title: filteredCategories[index].title,
                        subCategory: filteredCategories[index].subCategories!,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
