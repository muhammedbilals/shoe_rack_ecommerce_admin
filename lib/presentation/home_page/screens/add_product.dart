import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoe_rack_ecommerce_admin/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce_admin/core/utils/utils.dart';
import 'package:shoe_rack_ecommerce_admin/functions/functions.dart';
import 'package:shoe_rack_ecommerce_admin/main.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/productsTextfield.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key});
  final formKey = GlobalKey<FormState>();
  List<String> categoryList = <String>['Sneakers', 'Casual', 'Sports', 'Formal'];
  List<String> sizeList = <String>['9', '10', '11', '12'];
  List<String> nameList = <String>['Adidas', 'droorsclothing', 'Fila', 'Vans', 'Nike', 'Redtape', 'Under Armour'];
  List<String> colorList = <String>['Black', 'Red', 'White', 'Blue'];



  final ValueNotifier<String> imagePathNotifer = ValueNotifier("");
  Future<List<String>> uploadFiles(List<File> images) async {
    var imageUrls =
        await Future.wait(images.map((image) => uploadFile(image)));
    print(imageUrls);
    return imageUrls;
  }

  Future<String> uploadFile(File image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('posts/${image.path}');
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask;
    return await storageReference.getDownloadURL();
  }

  final titlecontroller = TextEditingController();
  final subtitlecontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  // final sizecontroller = TextEditingController();
  final colorcontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final Size size = MediaQuery.of(context).size;
    String dropdownCategoryValue = categoryList.first;
    String dropdownSizeValue = sizeList.first;
    String dropdownNameValue = nameList.first;
    String dropdownColorValue = colorList.first;

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
      if (imagepath == '') {
        return;
      }
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
          'name': dropdownNameValue,
          'subtitle': subtitlecontroller.text,
          'price': int.parse(pricecontroller.text),
          'size': int.parse(dropdownSizeValue),
          'color': dropdownColorValue,
          'description': descriptioncontroller.text,
          'category': dropdownCategoryValue,
        }).then((value) => print('product added'));
        //  Navigator.pop(context);
        // users.add(product.toJason()).then((value) => print('user added'));
      } on FirebaseException catch (e) {
        print(e);
        utils.showSnackbar('${e.message}-------------------------------------');
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);

      return;
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              ? const Padding(
                                  padding: EdgeInsets.all(100.0),
                                  child: Icon(Icons.add),
                                )
                              : Image.network(
                                  imgpath,
                                  fit: BoxFit.cover,
                                );
                        },
                      ),
                    ),
                  ),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: size.width * 0.9,
                          height: size.width * 0.13,
                          decoration: BoxDecoration(
                              border: Border.all(color: colorgreen),
                              borderRadius: BorderRadius.circular(20),
                              color: colorwhite),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownNameValue,
                                icon: const Icon(Icons.arrow_downward_sharp),
                                elevation: 8,
                                style: const TextStyle(color: Colors.black),
                                disabledHint: Container(
                                  height: 2,
                                  color: Colors.black,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownNameValue = value!;
                                  });
                                },
                                items: nameList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },).toList(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ProductsTextField(
                    controller: subtitlecontroller,
                    title: 'Men Black Solid Adivat Running Shoes',
                    maintitle: 'Product subtitle',
                  ),
                  ProductsTextField(
                    isNumberPad: true,
                    controller: pricecontroller,
                    title: '4500',
                    maintitle: 'price',
                  ),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: size.width * 0.9,
                          height: size.width * 0.13,
                          decoration: BoxDecoration(
                              border: Border.all(color: colorgreen),
                              borderRadius: BorderRadius.circular(20),
                              color: colorwhite),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownSizeValue,
                                icon: const Icon(Icons.arrow_downward_sharp),
                                elevation: 8,
                                style: const TextStyle(color: Colors.black),
                                disabledHint: Container(
                                  height: 2,
                                  color: Colors.black,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownSizeValue = value!;
                                  });
                                },
                                items: sizeList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                   StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: size.width * 0.9,
                          height: size.width * 0.13,
                          decoration: BoxDecoration(
                              border: Border.all(color: colorgreen),
                              borderRadius: BorderRadius.circular(20),
                              color: colorwhite),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownColorValue,
                                icon: const Icon(Icons.arrow_downward_sharp),
                                elevation: 8,
                                style: const TextStyle(color: Colors.black),
                                disabledHint: Container(
                                  height: 2,
                                  color: Colors.black,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownColorValue = value!;
                                  });
                                },
                                items: colorList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ProductsTextField(
                    controller: descriptioncontroller,
                    title:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been theand typesetting industry Lorem Ipsum has been the  industrys standard dummy text ever',
                    maintitle: 'discription',
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Category'),
                  ),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: size.width * 0.9,
                          height: size.width * 0.13,
                          decoration: BoxDecoration(
                              border: Border.all(color: colorgreen),
                              borderRadius: BorderRadius.circular(20),
                              color: colorwhite),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownCategoryValue,
                                icon: const Icon(Icons.arrow_downward_sharp),
                                elevation: 8,
                                style: const TextStyle(color: Colors.black),
                                disabledHint: Container(
                                  height: 2,
                                  color: Colors.black,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownCategoryValue = value!;
                                  });
                                },
                                items: categoryList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
