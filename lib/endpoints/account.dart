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
}
