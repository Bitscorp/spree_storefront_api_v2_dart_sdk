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
  final String purchasable;
  final String inStock;
  final String backorderable;
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
    return new ProductAttr(
      type: json['type'],
      id: json['id'],
    );
  }
}

class IProductsResult extends http.Data with http.JsonList {
  IProductsResult();

  factory IProductsResult.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('data')) {
      // nothing to return if we don't have anything in `data`
      return IProductsResult();
    }

    var result = IProductsResult()
      ..meta(json)
      ..data(json);
    return result;
  }

  @override
  data(Map<String, dynamic> json) {
    list = new List<ProductAttr>();
    if (json.containsKey('data')) {
      (json['data'] as List<Map<String, dynamic>>)
          .forEach((x) => list.add(ProductAttr.fromJson(x)));
    }

    return list;
  }
}

class Products extends http.Http {
  Products(HostConfig host) : super(host);

  Future<http.DataResponse<IProductsResult, http.ErrorResponse>> list(
      {http.Query query}) async {
    final resp = await spreeResponse('get', Routes.productsPath(),
        params: query?.params());

    var dataResponse = http.DataResponse<IProductsResult, http.ErrorResponse>(
        resp, (data) => IProductsResult.fromJson(data));
    return dataResponse;
  }
}
