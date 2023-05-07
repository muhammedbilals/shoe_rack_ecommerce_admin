import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce_admin/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/screens/add_product.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/screens/product_details.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/MainButton.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({
    super.key,
  });
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('product').snapshots();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Future<void> deleteProduct(String id) async {
      final products = FirebaseFirestore.instance.collection('products');
      final productRef = products.doc(id);

      try {
        return productRef.delete().then((value) {
          print("Product Deleted");
        });
      } on FirebaseException catch (e) {
        print(e.message);
      }
    }

    return Stack(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductsDetails(data: data),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: size.width * 0.95,
                    height: size.width * 0.30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: colorgray),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child:data['imgurl']==""? Container(
                                  color: colorgreen,
                                ):Image.network(data['imgurl'],fit: BoxFit.cover,)
                                ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.47,
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 12.0, top: 10, bottom: 8),
                                    child: Text(
                                      data['name'],
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Flex(direction: Axis.horizontal),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, bottom: 8, top: 5),
                                child: Text(
                                  data['subtitle'],
                                  style: TextStyle(
                                      // overflow: TextOverflow.clip,
                                      fontSize: 13,
                                      color: colorblack.withOpacity(0.5)),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            print(data['id']);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete confirmation'),
                                  content: const Text(
                                      'Are you sure you want to delete this item?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            ).then((value) {
                              deleteProduct(
                                data['id'],
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList());
          },
        ),
        CustomButton(
          text: 'Add Products',
          widget: AddProduct(),
        )
      ],
    );
  }
}
