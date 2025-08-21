class ProductDetailVariant{
  final List<String> sizeIds;
  final List<String> colorIds;
  int currentQuantity;

  ProductDetailVariant({ required this.sizeIds, required this.colorIds, required this.currentQuantity});

  factory ProductDetailVariant.fromJson(Map<String, dynamic> json){
    return ProductDetailVariant(
      sizeIds: List<String>.from(json['sizeIds']),
      colorIds: List<String>.from(json['colorIds']),
      currentQuantity: json['currentQuantity']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'sizeIds': sizeIds,
      'colorIds': colorIds,
      'currentQuantity': currentQuantity
    };
  }

  static List<ProductDetailVariant> parseList(dynamic jsonList){
    if(jsonList == null || jsonList is! List || jsonList.isEmpty){
      return [];
    }
    return jsonList.map((json) => ProductDetailVariant.fromJson(json)).toList();
  }
}