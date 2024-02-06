import 'dart:async';
import 'dart:convert';

import 'package:antiergit/Product/Model/productlist.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<ProductList?> getProductList(String url) async {
    var response = await httpGet(url);
    if (response != null) {
      var jsondata = await jsonDecode(response);
      return ProductList.fromJson(jsondata);
    }
    return null;
  }

  httpGet(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
