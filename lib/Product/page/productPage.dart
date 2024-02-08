import 'package:antiergit/Product/controller/productController.dart';
import 'package:antiergit/Product/widgets/customTextField.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var controller = Get.put(ProductController());

  TextEditingController searchController = TextEditingController();

  ScrollController scrollController = ScrollController();
  bool paginationLoader = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(addItems);
  }

  // @override
  addItems() async {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (controller.pagination == true) {
          paginationLoader = true;
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
          setState(() {});
          await controller.getProductList(controller.skipValueC + 20);
          paginationLoader = false;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: controller.obx(
            onLoading: const Center(child: CircularProgressIndicator()),
            (state) => SafeArea(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          CustomAutoSizeTextMontserrat(
                            text: "Products",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          const Spacer(),
                          DropdownButton(
                              value: controller.dropdownvalue,
                              items: controller.items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (value) {
                                controller.dropdownvalue = value!;
                                if (value == "All") {
                                  controller.dropSelectedAll();
                                } else {
                                  controller.dropSelectOtherOption(value);
                                }
                              }),
                          const SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            enabled: true,
                            textAlign: TextAlign.center,
                            controller: searchController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Search Products',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    width: 0.5,
                                    style: BorderStyle.none,
                                    color: Colors.black),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsets.all(16),
                              // fillColor: Colors.blue,
                            ),
                            onEditingComplete: () {},
                            onChanged: (value) {
                              controller.searchProduct(searchController.text);
                            },
                          ),
                        ),
                      ),
                      if (controller.searchLoading == false)
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                ...controller.widgetList,
                                if (paginationLoader == true)
                                  const CircularProgressIndicator(),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                )));
  }

  Widget getloading() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    return const CircularProgressIndicator();
  }
}
