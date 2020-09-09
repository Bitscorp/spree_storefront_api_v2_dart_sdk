import 'package:spree_storefront_api_v2_dart_sdk/endpoints/authentication.dart';


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

    if(this.port == null) {
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

  Authentication authentication;

  Client(this.host);

  Authentication makeAuthentication() {
    return Authentication(this.host);
  }
}
