import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spree_storefront_api_v2_dart_sdk/client.dart';

class Query {
  String include;
  Map<String, dynamic> fields;
  Map<String, dynamic> filter;
  int page;
  int perPage;
  String sort;

  Map<String, dynamic> params() {
    var params = {};

    if (include != null && include.isNotEmpty) {
      params['include'] = include;
    }

    if (page != null) {
      params['page'] = page;
    }

    if (perPage != null) {
      params['per_page'] = perPage;
    }

    if (sort != null) {
      params['sort'] = sort;
    }

    if (fields != null && fields.length > 0) {
      fields.forEach((key, value) => params['fields[$key]'] = value);
    }

    if (filter != null && filter.length > 0) {
      filter.forEach((key, value) => params['filter[$key]'] = value);
    }

    return params;
  }
}

abstract class JsonList {
  List<dynamic> list;
  int totalPages;
  int totalCount;
  int page;

  meta(Map<String, dynamic> json) {
    if (json.containsKey("meta")) {
      var meta = json['meta'] as Map<String, dynamic>;
      if (meta != null) {
        if (meta.containsKey('total_count')) {
          totalCount = meta['total_count'];
        }

        if (meta.containsKey('total_pages')) {
          totalPages = meta['total_pages'];
        }

        if (meta.containsKey('page')) {
          page = meta['page'];
        }
      }
    }
  }

  data(Map<String, dynamic> json);
}

abstract class JsonObject {
  dynamic object;

  data(Map<String, dynamic> json);
}

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

    if (data != null) {
      this.data = data;

      if (this.data.containsKey('errors')) {
        (this.data['errors'] as List<String>).forEach((err) {
          errors.add(err);
        });
      }

      if (this.data.containsKey('error')) {
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

  DataResponse(Response resp, TData Function(Map<String, dynamic>) creator) {
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

  Future<Response> spreeResponse(String method, String url,
      {Token token,
      Map<String, dynamic> params,
      Map<String, String> body}) async {
    var uri = Uri(
        scheme: host.scheme,
        host: host.host,
        port: host.port,
        path: url,
        queryParameters: params);
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

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      return ErrorResponse(data);
    } else {
      return Response(data);
    }
  }
}
