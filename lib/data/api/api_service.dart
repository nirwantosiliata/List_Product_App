import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:list_product/data/product.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
  };

  Future<BaseProductResponse> getProduct({String title = ""}) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/products/search?q=$title'), headers: headers);

    if (response.statusCode == 200) {
      return BaseProductResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list product');
    }
  }

  Future<Product> getDetailProduct(String id) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/products/$id'), headers: headers);

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list product');
    }
  }
}
