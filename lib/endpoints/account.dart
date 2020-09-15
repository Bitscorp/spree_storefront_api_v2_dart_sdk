import 'package:spree_storefront_api_v2_dart_sdk/client.dart';
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/http.dart' as http;
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/routes.dart';

class AccountAttr extends http.Data {
  final String type;
  final int id;

  final String email;
  final double storeCredits;
  final int completedOrders;

  AccountAttr(
      {this.type,
      this.id,
      this.email,
      this.storeCredits,
      this.completedOrders});

  factory AccountAttr.fromJson(Map<String, dynamic> json) {
    var attrs = json['attributes'];
    return new AccountAttr(
      type: json['type'],
      id: int.parse(json['id']),
      email: attrs['email'],
      storeCredits: double.parse(attrs['store_credits']),
      completedOrders: int.parse(attrs['completed_orders']),
    );
  }
}

class AccountResult extends http.Data with http.JsonObject {
  AccountResult();

  factory AccountResult.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('data')) {
      // nothing to return if we don't have anything in `data`
      return AccountResult();
    }

    var result = AccountResult()..data(json);
    return result;
  }

  @override
  data(Map<String, dynamic> json) {
    if (json.containsKey('data')) {
      object = AccountResult.fromJson(json['data']);
    }
  }
}

class CreditCardAttr {
  final String type;
  final int id;
  final String ccType;
  final String lastDigits;
  final int month;
  final int year;
  final String name;
  final bool isDefault;

  CreditCardAttr(
      {this.type,
      this.id,
      this.ccType,
      this.lastDigits,
      this.month,
      this.year,
      this.name,
      this.isDefault});

  factory CreditCardAttr.fromJson(Map<String, dynamic> json) {
    var attrs = json['attributes'];
    return new CreditCardAttr(
      type: json['type'],
      id: int.parse(json['id']),
      name: attrs['name'],
      ccType: attrs['cc_type'],
      lastDigits: attrs['last_digits'],
      month: int.parse(attrs['month']),
      year: int.parse(attrs['display_price']),
      // TODO: verify boolean type on json parse from dynamic field.
      isDefault: attrs['default'],
    );
  }
}

class CreditCardResult extends http.Data with http.JsonObject {
  CreditCardResult();

  factory CreditCardResult.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('data')) {
      // nothing to return if we don't have anything in `data`
      return CreditCardResult();
    }

    var result = CreditCardResult()..data(json);
    return result;
  }

  @override
  data(Map<String, dynamic> json) {
    if (json.containsKey('data')) {
      object = CreditCardAttr.fromJson(json['data']);
    }
  }
}

class CreditCardsResult extends http.Data with http.JsonList {
  CreditCardsResult();

  factory CreditCardsResult.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('data')) {
      // nothing to return if we don't have anything in `data`
      return CreditCardsResult();
    }

    var result = CreditCardsResult()
      ..meta(json)
      ..data(json);
    return result;
  }

  @override
  data(Map<String, dynamic> json) {
    list = new List<CreditCardAttr>();

    if (json.containsKey('data')) {
      (json['data'] as List<dynamic>).forEach(
          (x) => list.add(CreditCardAttr.fromJson(x as Map<String, dynamic>)));
    }
  }
}

class OrderAttr {
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
        itemTotal: attrs['item_total'],
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

class OrdersResult extends http.Data with http.JsonList {
  OrdersResult();

  factory OrdersResult.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('data')) {
      // nothing to return if we don't have anything in `data`
      return OrdersResult();
    }

    var result = OrdersResult()
      ..meta(json)
      ..data(json);
    return result;
  }

  @override
  data(Map<String, dynamic> json) {
    list = new List<OrderAttr>();

    if (json.containsKey('data')) {
      (json['data'] as List<dynamic>).forEach(
          (x) => list.add(OrderAttr.fromJson(x as Map<String, dynamic>)));
    }
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
      object = OrderAttr.fromJson(json['data']);
    }
  }
}

class Account extends http.Http {
  Account(HostConfig host) : super(host);

  Future<http.DataResponse<AccountResult, http.ErrorResponse>> accountInfo(
      http.Token token,
      {http.Query query}) async {
    final resp = await spreeResponse('get', Routes.accountPath(),
        token: token, params: query?.params());

    var dataResponse = http.DataResponse<AccountResult, http.ErrorResponse>(
        resp, (data) => AccountResult.fromJson(data));
    return dataResponse;
  }

  Future<http.DataResponse<CreditCardsResult, http.ErrorResponse>>
      creditCardsList(http.Token token, {http.Query query}) async {
    final resp = await spreeResponse('get', Routes.accountCreditCardsPath(),
        token: token, params: query?.params());

    var dataResponse = http.DataResponse<CreditCardsResult, http.ErrorResponse>(
        resp, (data) => CreditCardsResult.fromJson(data));
    return dataResponse;
  }

  Future<http.DataResponse<CreditCardResult, http.ErrorResponse>>
      defaultCreditCard(http.Token token, {http.Query query}) async {
    final resp = await spreeResponse(
        'get', Routes.accountDefaultCreditCardPath(),
        token: token, params: query?.params());

    var dataResponse = http.DataResponse<CreditCardResult, http.ErrorResponse>(
        resp, (data) => CreditCardResult.fromJson(data));
    return dataResponse;
  }

  Future<http.DataResponse<OrdersResult, http.ErrorResponse>>
      completedOrdersList(http.Token token, {http.Query query}) async {
    final resp = await spreeResponse('get', Routes.accountCompletedOrdersPath(),
        token: token, params: query?.params());

    var dataResponse = http.DataResponse<OrdersResult, http.ErrorResponse>(
        resp, (data) => OrdersResult.fromJson(data));
    return dataResponse;
  }

  Future<http.DataResponse<OrderResult, http.ErrorResponse>> completedOrder(
      http.Token token, String orderNumber,
      {http.Query query}) async {
    final resp = await spreeResponse(
        'get', Routes.accountCompletedOrderPath(orderNumber),
        token: token, params: query?.params());

    var dataResponse = http.DataResponse<OrderResult, http.ErrorResponse>(
        resp, (data) => OrderResult.fromJson(data));
    return dataResponse;
  }
}
