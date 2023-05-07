import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoe_rack_ecommerce_admin/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce_admin/functions/functions.dart';
import 'package:shoe_rack_ecommerce_admin/model/product.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/MainButton.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/productsTextfield.dart';

class EditProduct extends StatelessWidget {
  EditProduct({super.key, this.product, required this.data});

  Product? product;
  final Map<String, dynamic> data;
  final ValueNotifier<String> imagePathNotifer = ValueNotifier("");

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

    Future<void> updateProduct(String imgurl) async {
      final products = FirebaseFirestore.instance.collection('product');
      final productRef = products.doc(data['id']);
      try {
        await productRef.update({
          // 'id':productRef.id,
          'imgurl': imgurl,
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
                Container(
                  color: Colors.amber,
                  width: size.width,
                  height: size.width,
                  child: Stack(children: <Widget>[
                    Positioned(
                      height: 20,
                      bottom: 100,
                      left: size.width * 0.5,
                      child: IconButton(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            // final XFile? image =  await picker.pickImage(source: ImageSource.gallery);
                            final pickedFile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            if (pickedFile == null) {
                              return;
                            } else {
                              File file = File(pickedFile.path);
                              // imagePathNotifer.value = 'nullayi';
                              imagePathNotifer.value = await uploadImage(file);
                              print(
                                  'image url is-----------  ${imagePathNotifer.value}');
                            }
                          },
                          icon: Icon(Icons.camera)),
                    ),
                    Image.network(
                      data['imgurl'],
                      fit: BoxFit.cover,
                    ),

                    //   GestureDetector(

                    //   onTap: () async {
                    //     // final ImagePicker picker = ImagePicker();
                    //     // final XFile? image =  await picker.pickImage(source: ImageSource.gallery);
                    //     final pickedFile = await ImagePicker()
                    //         .pickImage(source: ImageSource.gallery);

                    //     if (pickedFile == null) {
                    //       return;
                    //     } else {
                    //       File file = File(pickedFile.path);
                    //       // imagePathNotifer.value = 'nullayi';
                    //       imagePathNotifer.value = await uploadImage(file);
                    //       print(
                    //           'image url is-----------  ${imagePathNotifer.value}');
                    //     }
                    //   },
                    //   child: ValueListenableBuilder(
                    //     valueListenable: imagePathNotifer,
                    //     builder: (BuildContext context, String imgpath,
                    //         Widget? child) {

                    //     return  imgpath == ""
                    //           ? Padding(
                    //               padding: EdgeInsets.all(100.0),
                    //               child: Icon(Icons.add),
                    //             )
                    //           : Image.network(
                    //               imgpath,
                    //               fit: BoxFit.cover,
                    //             );
                    //     },
                    //   ),
                    // ),
                  ]),
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
              child: ValueListenableBuilder(
                valueListenable: imagePathNotifer,
                builder: (BuildContext context, String imgpath, Widget? child) {
                  return ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(colorgreen),
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
                      updateProduct(imgpath);
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
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
