class CategoryModel {
  final String title;
  final String? image, svgSrc;
  final List<CategoryModel>? subCategories;

  CategoryModel({
    required this.title,
    this.image,
    this.svgSrc,
    this.subCategories,
  });
}

final List<CategoryModel> demoCategories = [
  CategoryModel(
    title: "Đang giảm giá",
    svgSrc: "assets/icons/Sale.svg",
    subCategories: [
      CategoryModel(title: "Tất cả"),
      CategoryModel(title: "Hàng mới nhập"),
      CategoryModel(title: "Áo Khoác"),
      CategoryModel(title: "Váy"),
      CategoryModel(title: "Quần Jeans"),
    ],
  ),
  CategoryModel(
    title: "Nam & Nữ",
    svgSrc: "assets/icons/Man&Woman.svg",
    subCategories: [
      CategoryModel(title: "Tất cả"),
      CategoryModel(title: "Mới nhập về"),
      CategoryModel(title: "Áo Khoác"),
    ],
  ),
  CategoryModel(
    title: "Trẻ em",
    svgSrc: "assets/icons/Child.svg",
    subCategories: [
      CategoryModel(title: "Tất cả"),
      CategoryModel(title: "Mới nhập về"),
      CategoryModel(title: "Áo Khoác"),
    ],
  ),
  CategoryModel(
    title: "Phụ kiện",
    svgSrc: "assets/icons/Accessories.svg",
    subCategories: [
      CategoryModel(title: "Tất cả"),
      CategoryModel(title: "Mới nhập về"),
    ],
  ),
];
