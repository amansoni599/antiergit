import 'dart:collection';

import 'package:antiergit/Product/Model/productlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController with StateMixin {
  List<Map<String, List<Widget>>> list = [];

  getProductList() {
    // check repated Values in Product Details List
  }
}
