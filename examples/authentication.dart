import 'package:spree_storefront_api_v2_dart_sdk/client.dart';
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/authentication.dart';

main() {
  var client =
      new Client(new HostConfig(host: 'localhost', port: 3000, scheme: 'http'));

  getUser(client).whenComplete(() => print("AUTH FINISHED"));
}

Future<void> getUser(Client client) async {
  var auth = client.makeAuthentication();
  var resp =
      await auth.getToken(new AuthTokenAttr("spree@example.com", "123456"));
  assert(resp.error == null);
  assert(resp.success != null);
  assert(resp.success.accessToken.isNotEmpty);
}
