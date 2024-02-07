import 'package:antiergit/Product/controller/productController.dart';
import 'package:antiergit/Product/widgets/customTextField.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  var controller = Get.put(ProductController());
  TextEditingController searchController = TextEditingController();

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
                      // TextField(
                      //   controller: searchController,
                      //   // onChanged: (value) {},
                      //   onEditingComplete: () {},
                      // ),
                      if (controller.searchLoading == false)
                        Expanded(
                          child: ListView.builder(
                              itemCount: controller.widgetList.length,
                              itemBuilder: (context, index) {
                                if (controller.pagination == true) {
                                  if (controller.widgetList.length - 1 ==
                                      index) {
                                    controller.getProductList(
                                        controller.skipValueC + 20);
                                    // return const CircularProgressIndicator();
                                  }
                                }
                                return controller.widgetList[index];
                              }),
                        ),
                    ],
                  ),
                )));
  }
}
