class Routes {
  static final String hostname = 'api/v2/storefront';

  static String productsPath() => '$hostname/products';
  static String productPath(String id) => '$hostname/products/$id';
  static String taxonsPath() => '$hostname/taxons';
  static String taxonPath(String id) => '$hostname/taxons/$id';
  static String countriesPath() => '$hostname/countries';
  static String countryPath(String iso) => '$hostname/countries/$iso';
  static String cartPath() => '$hostname/cart';
  static String cartAddItemPath() => '$hostname/cart/add_item';
  static String cartRemoveItemPath(String id) =>
      '$hostname/cart/remove_line_item/$id';
  static String cartEmptyPath() => '$hostname/cart/empty';
  static String cartSetItemQuantity() => '$hostname/cart/set_quantity';
  static String cartApplyCodePath() => '$hostname/cart/apply_coupon_code';
  static String cartRemoveCodePath({String code}) =>
      '$hostname/cart/remove_coupon_code/$code';
  static String cartEstimateShippingMethodsPath() =>
      '$hostname/cart/estimate_shipping_rates';
  static String checkoutPath() => '$hostname/checkout';
  static String checkoutNextPath() => '$hostname/checkout/next';
  static String checkoutAdvancePath() => '$hostname/checkout/advance';
  static String checkoutCompletePath() => '$hostname/checkout/complete';
  static String checkoutAddStoreCreditsPath() =>
      '$hostname/checkout/add_store_credit';
  static String checkoutRemoveStoreCreditsPath() =>
      '$hostname/checkout/remove_store_credit';
  static String checkoutPaymentMethodsPath() =>
      '$hostname/checkout/payment_methods';
  static String checkoutShippingMethodsPath() =>
      '$hostname/checkout/shipping_rates';
  static String oauthTokenPath() => 'spree_oauth/token';
  static String accountPath() => '$hostname/account';
  static String accountConfirmPath(String confirmationToken) =>
      '$hostname/account_confirmations/$confirmationToken';
  static String accountCreditCardsPath() => '$hostname/account/credit_cards';
  static String accountDefaultCreditCardPath() =>
      '$hostname/account/credit_cards/default';
  static String accountCompletedOrdersPath() => '$hostname/account/orders';
  static String accountCompletedOrderPath(String orderNumber) =>
      '$hostname/account/orders/$orderNumber';
  static String orderStatusPath(String orderNumber) =>
      '$hostname/order_status/$orderNumber';
}
