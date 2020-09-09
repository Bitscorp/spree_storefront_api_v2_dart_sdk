import 'dart:convert';

import 'package:spree_storefront_api_v2_dart_sdk/client.dart';
import 'package:http/http.dart' as http;


class Token {
    final String orderToken;
    final String bearerToken;

    Token({this.orderToken, this.bearerToken});
}

class ErrorResponse extends Response {
    List<String> errors;
    String error;

    ErrorResponse(String body) : super(body) {
        isError = true;

        if(data != null) {
            this.data = data;

            if (this.data.containsKey('errors')) {
                (this.data['errors'] as List<String>).forEach((err) {
                    errors.add(err);
                });
            }

            if(this.data.containsKey('error')) {
                error = this.data['error'];
            }
        }
    }

    @override
    String toString() {
        var err = error;

        if (errors.length > 0) {
            err += ': ' + errors.join(', ');
        }

        return err;
    }
}

class Response {
    // should contains json view of response.
    Map<String, dynamic> data;
    String body;
    bool isError = false;

    Response(this.body) {
        if (body != '') {
            data = jsonDecode(body);
        } else {
            data = {};
        }
    }
}

abstract class Data {}

class DataResponse<TData extends Data, TError extends ErrorResponse> {
    TData success;
    TError error;

    DataResponse(Response resp,
        TData Function(Map<String, dynamic>) creator) {

        if (resp.isError) {
            error = resp as ErrorResponse;
        } else {
            success = creator(resp.data);
        }
    }
}

class Http {
    final HostConfig host;

    Http(this.host);

    _spreeOrderHeaders(http.Request req, Token token) {
        if (token.orderToken != '') {
            req.headers['X-Spree-Order-Token'] = token.orderToken;
        }

        if (token.bearerToken != '') {
            req.headers['Authorization'] = 'Bearer ${token.bearerToken}';
        }
    }

    Future<Response> spreeResponse(String method, String url, {Token token, Map<String, dynamic> params, Map<String, String> body}) async {
        var uri = Uri(scheme: host.scheme, host: host.host, port: host.port, path: url, queryParameters: params);
        var req = http.Request(method, uri);

        if (token != null) {
            _spreeOrderHeaders(req, token);
        }

        if (body != null) {
            req.body = jsonEncode(body);
        }

        req.headers['Content-Type'] = 'application/json';

        var resp = await req.send();
        var data = await resp.stream.bytesToString();

        if(resp.statusCode != 200 && resp.statusCode != 201) {
            return ErrorResponse(data);
        } else {
            return Response(data);
        }
    }
}
