import 'package:spree_storefront_api_v2_dart_sdk/client.dart';
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/http.dart' as http;
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/routes.dart';

class ProductAttr extends http.Data {
  final String type;
  final int id;
  final String name;
  final String description;
  final double price;
  final String currency;
  final String displayPrice;
  final String availableOn;
  final String metaDescription;
  final String metaKeywords;
  final String updatedAt;
  final bool purchasable;
  final bool inStock;
  final bool backorderable;
  final String slug;

  ProductAttr(
      {this.type,
      this.id,
      this.name,
      this.description,
      this.price,
      this.currency,
      this.displayPrice,
      this.availableOn,
      this.metaDescription,
      this.metaKeywords,
      this.updatedAt,
      this.purchasable,
      this.inStock,
      this.backorderable,
      this.slug});

  factory ProductAttr.fromJson(Map<String, dynamic> json) {
    var attrs = json['attributes'];
    return new ProductAttr(
      type: json['type'],
      id: int.parse(json['id']),
      name: attrs['name'],
      description: attrs['description'],
      price: double.parse(attrs['price']),
      currency: attrs['currency'],
      displayPrice: attrs['display_price'],
      availableOn: attrs['available_on'],
      metaDescription: attrs['meta_description'],
      metaKeywords: attrs['meta_keywords'],
      updatedAt: attrs['updated_at'],
      purchasable: attrs['purchasable'],
      inStock: attrs['in_stock'],
      backorderable: attrs['backorderable'],
      slug: attrs['slug'],
    );
  }
}

class ProductsResult extends http.Data with http.JsonList {
  ProductsResult();

  factory ProductsResult.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('data')) {
      // nothing to return if we don't have anything in `data`
      return ProductsResult();
    }

    var result = ProductsResult()
      ..meta(json)
      ..data(json);
    return result;
  }

  @override
  data(Map<String, dynamic> json) {
    list = new List<ProductAttr>();

    if (json.containsKey('data')) {
      (json['data'] as List<dynamic>).forEach(
          (x) => list.add(ProductAttr.fromJson(x as Map<String, dynamic>)));
    }

    return list;
  }
}

class Products extends http.Http {
  Products(HostConfig host) : super(host);

  Future<http.DataResponse<ProductsResult, http.ErrorResponse>> list(
      {http.Query query}) async {
    final resp = await spreeResponse('get', Routes.productsPath(),
        params: query?.params());

    var dataResponse = http.DataResponse<ProductsResult, http.ErrorResponse>(
        resp, (data) => ProductsResult.fromJson(data));
    return dataResponse;
  }
}
