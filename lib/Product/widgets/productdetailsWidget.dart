import 'package:antiergit/Product/Model/productlist.dart';
import 'package:antiergit/Product/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class ProductDetailsWidget extends StatelessWidget {
  Products product = Products();

  ProductDetailsWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getDailogForAgree(context, product);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Image.network(
              product.thumbnail ?? "",
              width: 100,
              alignment: Alignment.topLeft,
              height: 80,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: CustomAutoSizeTextMontserrat(
                    text: product.title,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: CustomAutoSizeTextMontserrat(
                    text: product.description,
                    maxLines: 10,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

getDailogForAgree(BuildContext context, Products product) {
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (ctx) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 180,
                    width: 280,
                    child: Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomAutoSizeTextMontserrat(
                            text: product.title,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.images?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  product.images![index],
                                  height: 100,
                                  width: 100,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomAutoSizeTextMontserrat(
                            text: product.description,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomAutoSizeTextMontserrat(
                            text: "Price: ${product.price.toString()}",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
}
