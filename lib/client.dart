import 'package:spree_storefront_api_v2_dart_sdk/endpoints/account.dart';
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/authentication.dart';
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/order.dart';
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/products.dart';

class HostConfig {
  String scheme;
  // required
  final String host;
  int port;

  // Example: scheme: 'http', host: 'localhost', port: 3000
  HostConfig({this.scheme, this.host, this.port}) {
    if (this.scheme == null) {
      this.scheme = 'http';
    }

    if (this.port == null) {
      if (this.scheme == 'http') {
        this.port = 80;
      } else {
        this.port = 443;
      }
    }
  }
}

class Client {
  final HostConfig host;

  Client(this.host);

  Authentication makeAuthentication() {
    return Authentication(this.host);
  }

  Products makeProducts() {
    return Products(this.host);
  }

  Order makeOrder() {
    return Order(this.host);
  }

  Account makeAccount() {
    return Account(this.host);
  }
}
