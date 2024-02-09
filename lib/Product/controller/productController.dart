import 'dart:collection';

import 'package:antiergit/Product/Model/productlist.dart';
import 'package:antiergit/Product/repository/api_service.dart';
import 'package:antiergit/Product/repository/endpoint.dart';
import 'package:antiergit/Product/widgets/categoryText.dart';
import 'package:antiergit/Product/widgets/productdetailsWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController with StateMixin {
  List<Map<String, List<Products>>> list = [];
  List<Widget> widgetList = [];
  ProductList productList = ProductList();
  APIService apiService = APIService();

  int skipValueC = 0;
  bool pagination = true;

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    await getProductList(0);
    await getDropDown();
    change(null, status: RxStatus.success());
  }

  getProductList(int skipvalue) async {
    pagination = false;

    skipValueC = skipvalue;
    var res = await apiService
        .getProductList(Endpoints.productListEndpoint + skipvalue.toString());
    if (res != null) {
      productList = res;
      if (skipvalue > productList.total!.toInt()) {
        pagination = false;
        // paginationLoader = false;
        // if (widgetList.isNotEmpty) {
        //   widgetList.removeLast();
        // }
        // update();
      } else {
        pagination = true;
        // paginationLoader = false;
        // if (widgetList.isNotEmpty) widgetList.removeLast();
        // update();
      }
    }
    await productListToWidgetListConvert();
    update();
  }

  // Initial Selected Value
  String dropdownvalue = 'All';

  List<String> items = ["All"];

  getDropDown() async {
    var res = await apiService.getDropDown(Endpoints.categoriesEndpoints);
    if (res != null) {
      for (var i = 0; i < res.length; i++) {
        items.add(res[i].toString());
      }
    }
  }

  dropSelectedAll() async {
    change(null, status: RxStatus.loading());
    pagination = true;
    list = [];
    await getProductList(0);
    change(null, status: RxStatus.success());
  }

  dropSelectOtherOption(String category) async {
    change(null, status: RxStatus.loading());
    var res = await apiService
        .getProductList(Endpoints.categoriesSearchEndppoint + category);
    if (res != null) {
      productList = res;
      pagination = false;
    }
    list = [];
    productListToWidgetListConvert();
    change(null, status: RxStatus.success());
  }

  productListToWidgetListConvert() {
    for (var i = 0; i < productList.products!.length; i++) {
      bool contains = false;
      for (var j = 0; j < list.length; j++) {
        if (list[j].containsKey(productList.products![i].category)) {
          contains = true;
          list[j][productList.products![i].category]!
              .add(productList.products![i]);
        }
      }
      if (contains == false) {
        list.add({
          productList.products![i].category!: [productList.products![i]]
        });
      }
    }

    widgetList = [];
    for (var i = 0; i < list.length; i++) {
      widgetList.add(CategroyText(
          title: list[i].keys.toString().split("(")[1].split(")")[0]));

      for (var element in list[i].values) {
        for (var i = 0; i < element.length; i++) {
          widgetList.add(ProductDetailsWidget(product: element[i]));
        }
      }

      // for (var j = 0; j < list[i].values.length; j++) {
      // widgetList.add(ProductDetailsWidget(product: list[i].values));
      // }
    }
  }

  bool searchLoading = false;
  searchProduct(String searchText) async {
    searchLoading = true;
    // change(null, status: RxStatus.loading());
    var res =
        await apiService.getProductList(Endpoints.searchList + searchText);
    if (res != null) {
      productList = res;
      pagination = false;
    }
    list = [];
    productListToWidgetListConvert();
    searchLoading = false;
    update();
  }
}
