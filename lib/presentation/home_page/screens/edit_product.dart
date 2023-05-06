import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce_admin/model/product.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/MainButton.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/productsTextfield.dart';

class EditProduct extends StatelessWidget {
  EditProduct({super.key, required this.id,  this.product});
  final String id;
  Product? product;

  @override
  Widget build(BuildContext context) {
    final titlecontroller = TextEditingController();
    final subtitlecontroller = TextEditingController();
    final pricecontroller = TextEditingController();
    final sizecontroller = TextEditingController();
    final colorcontroller = TextEditingController();
    final discriptioncontroller = TextEditingController();

    // Product product = Product(
    //     name: titlecontroller.text.trim(),
    //     subtitle: subtitlecontroller.text.trim(),
    //     color: colorcontroller.text,
    //     size: int.parse(sizecontroller.text),
    //     descrption: discriptioncontroller.text);

    Future<void> updateProduct(
      String id,
    ) async {
      CollectionReference product =
          FirebaseFirestore.instance.collection('product');
      final documentReference = product.doc(id);
      try {
        documentReference.update({
          'name': titlecontroller.text,
          'subtitle': subtitlecontroller.text,
          'discription': discriptioncontroller.text,
          'id': id,
          'color': colorcontroller.text,
          'size': sizecontroller.text
        });
        print(id);
        // print();
      } on FirebaseException catch (e) {
        print(e.message);
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: const Icon(Icons.add),
                ),
                ProductsTextField(
                  controller: titlecontroller,
                  title: 'puma',
                  maintitle: 'Product name',
                ),
                ProductsTextField(
                  controller: subtitlecontroller,
                  title: 'Men Black Solid Adivat Running Shoes',
                  maintitle: 'Product subtitle',
                ),
                ProductsTextField(
                  controller: pricecontroller,
                  title: '4500',
                  maintitle: 'price',
                ),
                ProductsTextField(
                  controller: sizecontroller,
                  title: '10',
                  maintitle: 'size',
                ),
                ProductsTextField(
                  controller: colorcontroller,
                  title: 'black',
                  maintitle: 'color',
                ),
                ProductsTextField(
                  controller: discriptioncontroller,
                  title:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been theand typesetting industry Lorem Ipsum has been the  industrys standard dummy text ever',
                  maintitle: 'discription',
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
          CustomButton(
            text: 'Update',
            function: updateProduct(id),
          )
        ],
      ),
    );
  }
}
