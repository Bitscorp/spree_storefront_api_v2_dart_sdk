import 'package:flutter_test/flutter_test.dart';
import 'package:spree_storefront_api_v2_dart_sdk/client.dart';
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/authentication.dart';

const EMAIL = 'spree@example.com';
const PASSWORD = '123456';

void main() {
  // should have up and running rails server
  var client =
      new Client(new HostConfig(host: 'localhost', port: 3000, scheme: 'http'));

  testAuthentication(client);
  testProducts(client);
}

void testProducts(Client client) {
  var products = client.makeProducts();

  test(
      'products should return list of products, ensure to have at least one item in DB',
      () async {
    var func = () async {
      var resp = await products.list();

      expect(resp.error, isNull);
      expect(resp.success, isNotNull);
      expect(resp.success.list.length, greaterThanOrEqualTo(1));
    };

    await func();
  });
}

void testAuthentication(Client client) {
  var authentication = client.makeAuthentication();

  test('authentication get token request', () async {
    var func = () async {
      var resp =
          await authentication.getToken(new AuthTokenAttr(EMAIL, PASSWORD));

      expect(resp.error, isNull);
      expect(resp.success, isNotNull);
      expect(resp.success.accessToken, isNotEmpty);
    };

    await func();
  });
}
