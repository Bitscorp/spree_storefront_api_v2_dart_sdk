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
  final bool default_;

  CreditCardAttr(
      {this.type,
      this.id,
      this.ccType,
      this.lastDigits,
      this.month,
      this.year,
      this.name,
      this.default_});

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
      default_: attrs['default'],
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
}
