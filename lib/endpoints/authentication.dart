import 'dart:convert';

import 'package:spree_storefront_api_v2_dart_sdk/endpoints/http.dart' as http;
import 'package:spree_storefront_api_v2_dart_sdk/client.dart';
import 'package:spree_storefront_api_v2_dart_sdk/endpoints/routes.dart';


class AuthTokenAttr {
    final String username;
    final String password;

    const AuthTokenAttr(this.username, this.password);
}

class IOAuthTokenResult extends http.Data {
    final String accessToken;
    final String tokenType;
    final int expiresIn;
    final String refreshToken;
    final int createdAt;

    IOAuthTokenResult({this.accessToken, this.tokenType,
        this.expiresIn, this.refreshToken, this.createdAt});

    factory IOAuthTokenResult.fromJson(Map<String, dynamic> json) {
        return IOAuthTokenResult(
            accessToken: json['access_token'],
            tokenType: json['token_type'],
            expiresIn: json['expiresIn'] as int,
            refreshToken: json['refresh_token'],
            createdAt: json['created_at'] as int
        );
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

    Future<http.DataResponse<IOAuthTokenResult, http.ErrorResponse>> getToken(AuthTokenAttr params) async {
        final resp = await spreeResponse('post', Routes.oauthTokenPath(),
                params: {
                    'username': params.username,
                    'password': params.password,
                    'grant_type': 'password'
                });

        var dataResponse = http.DataResponse<IOAuthTokenResult, http.ErrorResponse>(
            resp, (data) => IOAuthTokenResult.fromJson(data));
        return dataResponse;
    }
}
