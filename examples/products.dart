import 'package:spree_storefront_api_v2_dart_sdk/client.dart';

main() {
  var client =
      new Client(new HostConfig(host: 'localhost', port: 3000, scheme: 'http'));

  getProducts(client).whenComplete(() => print("PRODUCTS FINISHED"));
}

Future<void> getProducts(Client client) async {
  var products = client.makeProducts();
  var resp = await products.list();
  assert(resp.error == null);
  assert(resp.success != null);
}
