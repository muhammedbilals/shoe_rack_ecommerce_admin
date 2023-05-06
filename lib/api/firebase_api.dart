import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoe_rack_ecommerce_admin/model/product.dart';

class FirebaseApi {
  static Future<String> createProduct(Product product) async {
    final docProduct = FirebaseFirestore.instance.collection('product').doc();
    product.id = docProduct.id;
    await docProduct.set(
      
      product.toJason(),SetOptions(merge: true));
    print('created product:${product.name}-------------------------');
    return docProduct.id;
  }
}
