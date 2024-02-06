import 'dart:collection';

import 'package:antiergit/Product/Model/productlist.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductController extends GetxController with StateMixin {
  HashMap<String, List<Products>> categoryList =
      HashMap<String, List<Products>>();

  getProductList() {
    // categoryList.forEach((key, value) { })
  }
}
