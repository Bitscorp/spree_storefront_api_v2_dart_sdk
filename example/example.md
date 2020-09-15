## Get list of the products

```
  var client = new Client(new HostConfig(host: 'localhost', port: 3000, scheme: 'http')); 

  var products = client.makeProducts();
  var resp = await products.list();
  # resp.success is going to have the list of the produts.
```
