import 'dart:async';
import 'dart:convert';

import 'package:antiergit/Product/Model/productlist.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  Future<ProductList?> getProductList(String url) async {
    var response;
    if (url == "https://dummyjson.com/products?limit=20&skip=0") {
      response = await getData(url);

      if (response != null) {
        return ProductList.fromJson(response);
      }
    }

    response ??= await httpGet(url);

    if (response != null) {
      var jsondata = await jsonDecode(response);

      await setData(url, ProductList.fromJson(jsondata));
      return ProductList.fromJson(jsondata);
    }
    return null;
  }

  getDropDown(String url) async {
    var response = await httpGet(url);
    if (response != null) {
      var jsondata = await jsonDecode(response);
      return jsondata;
    }
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

  setData(String url, var response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = await prefs.setString(url, jsonEncode(response));
  }

  getData(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = prefs.getString(url);

    if (res != null) {
      return jsonDecode(res);
    } else {
      return null;
    }
  }
}
