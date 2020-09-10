import 'package:spree_storefront_api_v2_dart_sdk/client.dart';
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/http.dart' as http;
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/routes.dart';

class OrderAttr extends http.Data {
  final String type;
  final int id;
  final String number;
  final String itemTotal;
  final String total;
  final String shipTotal;
  final String adjustmentTotal;
  final String includedTaxTotal;
  final String additionalTaxTotal;
  final String displayAdditionalTaxTotal;
  final String displayIncludedTaxTotal;
  final String taxTotal;
  final String currency;
  final String state;
  final String token;
  final String email;
  final String displayItemTotal;
  final String displayShipTotal;
  final String displayAdjustmentTotal;
  final String displayTaxTotal;
  final String promoTotal;
  final String displayPromoTotal;
  final int itemCount;
  final String specialInstructions;
  final String displayTotal;
  final String createdAt;
  final String updatedAt;
  final String completedAt;

  OrderAttr(
      {this.type,
      this.id,
      this.number,
      this.itemTotal,
      this.total,
      this.shipTotal,
      this.adjustmentTotal,
      this.includedTaxTotal,
      this.additionalTaxTotal,
      this.displayAdditionalTaxTotal,
      this.displayIncludedTaxTotal,
      this.taxTotal,
      this.currency,
      this.state,
      this.token,
      this.email,
      this.displayItemTotal,
      this.displayShipTotal,
      this.displayAdjustmentTotal,
      this.displayTaxTotal,
      this.promoTotal,
      this.displayPromoTotal,
      this.itemCount,
      this.specialInstructions,
      this.displayTotal,
      this.createdAt,
      this.updatedAt,
      this.completedAt});

  factory OrderAttr.fromJson(Map<String, dynamic> json) {
    var attrs = json['attributes'];
    return new OrderAttr(
        type: json['type'],
        id: int.parse(json['id']),
        number: attrs['number'],
        itemTotal: attrs['itemTotal'],
        total: attrs['total'],
        shipTotal: attrs['ship_total'],
        adjustmentTotal: attrs['adjustment_total'],
        includedTaxTotal: attrs['included_tax_total'],
        additionalTaxTotal: attrs['additional_tax_total'],
        displayAdditionalTaxTotal: attrs['display_additional_tax_total'],
        displayIncludedTaxTotal: attrs['display_included_tax_total'],
        taxTotal: attrs['tax_total'],
        currency: attrs['currency'],
        state: attrs['state'],
        token: attrs['token'],
        email: attrs['email'],
        displayItemTotal: attrs['display_item_total'],
        displayShipTotal: attrs['display_ship_total'],
        displayAdjustmentTotal: attrs['display_adjustment_total'],
        displayTaxTotal: attrs['display_tax_total'],
        promoTotal: attrs['promo_total'],
        displayPromoTotal: attrs['display_promo_total'],
        itemCount: int.parse(attrs['item_count']),
        specialInstructions: attrs['special_instructions'],
        displayTotal: attrs['display_total'],
        createdAt: attrs['created_at'],
        updatedAt: attrs['updated_at'],
        completedAt: attrs['completed_at']);
  }
}

class OrderResult extends http.Data with http.JsonObject {
  OrderResult();

  factory OrderResult.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('data')) {
      // nothing to return if we don't have anything in `data`
      return OrderResult();
    }

    var result = OrderResult()..data(json);
    return result;
  }

  @override
  data(Map<String, dynamic> json) {
    if (json.containsKey('data')) {
      object = OrderResult.fromJson(json['data']);
    }
  }
}

class Order extends http.Http {
  Order(HostConfig host) : super(host);

  Future<http.DataResponse<OrderResult, http.ErrorResponse>> status(
      http.Token token, String orderNumber,
      {http.Query query}) async {
    final resp = await spreeResponse('get', Routes.orderStatusPath(orderNumber),
        token: token, params: query?.params());

    var dataResponse = http.DataResponse<OrderResult, http.ErrorResponse>(
        resp, (data) => OrderResult.fromJson(data));
    return dataResponse;
  }
}
