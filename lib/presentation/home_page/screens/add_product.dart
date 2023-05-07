import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoe_rack_ecommerce_admin/api/firebase_api.dart';
import 'package:shoe_rack_ecommerce_admin/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce_admin/core/utils/utils.dart';
import 'package:shoe_rack_ecommerce_admin/functions/functions.dart';
import 'package:shoe_rack_ecommerce_admin/main.dart';
import 'package:shoe_rack_ecommerce_admin/model/product.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/MainButton.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/productsTextfield.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key});
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<String> imagePathNotifer = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final titlecontroller = TextEditingController();
    final subtitlecontroller = TextEditingController();
    final pricecontroller = TextEditingController();
    final sizecontroller = TextEditingController();
    final colorcontroller = TextEditingController();
    final descriptioncontroller = TextEditingController();

    // Product products = Product(
    //     name: titlecontroller.text,
    //     subtitle: subtitlecontroller.text,
    //     color: colorcontroller.text,
    //     size:
    //         sizecontroller.text.isEmpty ? null : int.parse(sizecontroller.text),
    //     descrption: descriptioncontroller.text);
    ValueListenableBuilder(
      valueListenable: imagePathNotifer,
      builder: (BuildContext context, dynamic value, Widget? _) {
        final imagepath;
        return imagepath = value;
      },
    );
    Future<void> addProduct(String imagepath) async {
      final isValid = formKey.currentState!.validate();
      if (!isValid) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        // CollectionReference users =
        //     FirebaseFirestore.instance.collection('product');
        // await FirebaseApi.createProduct(product);
        CollectionReference product =
            FirebaseFirestore.instance.collection('product');
        final productRef = product.doc();
        productRef.set({
          'imgurl': imagepath,
          'id': productRef.id,
          'name': titlecontroller.text,
          'subtitle': subtitlecontroller.text,
          'price': pricecontroller.text,
          'size': sizecontroller.text,
          'color': colorcontroller.text,
          'description': descriptioncontroller.text
        }).then((value) => print('product added'));
        //  Navigator.pop(context);
        // users.add(product.toJason()).then((value) => print('user added'));
      } on FirebaseException catch (e) {
        print(e);
        utils.showSnackbar('${e.message}-------------------------------------');
      }
      navigatorKey.currentState!.pop((route) => route.isFirst);

      return;
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.amber,
                    width: size.width,
                    height: size.width,
                    child: GestureDetector(
                      onTap: () async {
                        // final ImagePicker picker = ImagePicker();
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
                      child: ValueListenableBuilder(
                        valueListenable: imagePathNotifer,
                        builder: (BuildContext context, String imgpath,
                            Widget? child) {
                          return imgpath == ""
                              ? Padding(
                                  padding: EdgeInsets.all(100.0),
                                  child: Icon(Icons.add),
                                )
                              : Image.network(
                                  imgpath,
                                  fit: BoxFit.contain,
                                );
                        },
                      ),
                    ),
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
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
          // CustomButton(
          //   text: 'save product',
          //   function: addProduct(product),
          // )
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: size.width * 0.9,
                height: 60,
                child: ValueListenableBuilder(
                  valueListenable: imagePathNotifer,
                  builder:
                      (BuildContext context, String imgpath, Widget? child) {
                    return ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(colorgreen),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        print(
                            'recived imagepath in lisner -----------------$imgpath');
                        // addProduct(product);
                        addProduct(imgpath);
                      },
                      icon: Icon(
                        Icons.add,
                        size: 25,
                        color: colorwhite,
                      ),
                      label: Text(
                        'Add Product',
                        style: TextStyle(fontSize: 22, color: colorwhite),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
