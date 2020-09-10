import 'dart:convert';

import 'package:spree_storefront_api_v2_dart_sdk/client.dart';
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/http.dart' as http;
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/routes.dart';

class AuthTokenAttr {
  final String username;
  final String password;

  const AuthTokenAttr(this.username, this.password);
}

class RefreshTokenAttr {
  final String refreshToken;

  const RefreshTokenAttr(this.refreshToken);
}

class OAuthTokenResult extends http.Data {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;
  final int createdAt;

  OAuthTokenResult(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.refreshToken,
      this.createdAt});

  factory OAuthTokenResult.fromJson(Map<String, dynamic> json) {
    return OAuthTokenResult(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        expiresIn: json['expiresIn'] as int,
        refreshToken: json['refresh_token'],
        createdAt: json['created_at'] as int);
  }

  String json() {
    return jsonEncode({
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'refresh_token': refreshToken,
      'created_at': createdAt
    });
  }
}

class Authentication extends http.Http {
  Authentication(HostConfig host) : super(host);

  Future<http.DataResponse<OAuthTokenResult, http.ErrorResponse>> getToken(
      AuthTokenAttr params) async {
    final resp = await spreeResponse('post', Routes.oauthTokenPath(), params: {
      'username': params.username,
      'password': params.password,
      'grant_type': 'password'
    });

    var dataResponse = http.DataResponse<OAuthTokenResult, http.ErrorResponse>(
        resp, (data) => OAuthTokenResult.fromJson(data));
    return dataResponse;
  }

  Future<http.DataResponse<OAuthTokenResult, http.ErrorResponse>> refreshToken(
      RefreshTokenAttr params) async {
    final resp = await spreeResponse('post', Routes.oauthTokenPath(), params: {
      'refresh_token': params.refreshToken,
      'grant_type': 'refresh_token'
    });

    var dataResponse = http.DataResponse<OAuthTokenResult, http.ErrorResponse>(
        resp, (data) => OAuthTokenResult.fromJson(data));
    return dataResponse;
  }
}
