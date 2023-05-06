import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce_admin/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce_admin/model/product.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/MainButton.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/productsTextfield.dart';

class EditProduct extends StatelessWidget {
  EditProduct({super.key, this.product, required this.data});

  Product? product;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final titlecontroller = TextEditingController(text: data['name']);
    final subtitlecontroller = TextEditingController(text: data['subtitle']);
    final pricecontroller = TextEditingController(text: data['price']);
    final sizecontroller = TextEditingController(text: data['size']);
    final colorcontroller = TextEditingController(text: data['color']);
    final descriptioncontroller =
        TextEditingController(text: data['discription']);

    // Product product = Product(
    //     name: titlecontroller.text.trim(),
    //     subtitle: subtitlecontroller.text.trim(),
    //     color: colorcontroller.text,
    //     size: int.parse(sizecontroller.text),
    //     descrption: discriptioncontroller.text);

    Future<void> updateProduct() async {
      final products = FirebaseFirestore.instance.collection('product');
      final productRef = products.doc(data['id']);
      try {
        await productRef.update({
          // 'id':productRef.id,
          'name': titlecontroller.text,
          'subtitle': subtitlecontroller.text,
          'price': pricecontroller.text,
          'size': sizecontroller.text,
          'color': colorcontroller.text,
          'description': descriptioncontroller.text
        });
        // print(id);
        print(data['id']);
        print('Product updated');
        // print();
      } on FirebaseException catch (e) {
        print('eroor message is :${e.message}');
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
                  controller: descriptioncontroller,
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
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: SizedBox(
              width: size.width * 0.9,
              height: 60,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(colorgreen),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  print(titlecontroller.text);
                  print('id is -----------------------${data['id']}');
                  // addProduct(product);
                  updateProduct();
                },
                icon: Icon(
                  Icons.add,
                  size: 25,
                  color: colorwhite,
                ),
                label: Text(
                  'Update Product',
                  style: TextStyle(fontSize: 22, color: colorwhite),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
