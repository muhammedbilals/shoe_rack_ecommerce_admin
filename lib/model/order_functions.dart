import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoe_rack_ecommerce_admin/model/order_model.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

final User? user = auth.currentUser;

final userid = user!.email;

Future<QuerySnapshot> getProductIdFromOrder() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;
  final querySnapshot =
      await FirebaseFirestore.instance.collection('orders').get();
  return querySnapshot;
}

Future<QuerySnapshot> getOrderFromOrderId() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  final querySnapshot = await FirebaseFirestore.instance
      .collection('orders')
      // .where('orderId', isEqualTo: id)

      .get();
  return querySnapshot;
}

List<String> getListasString(List<dynamic> nestedList) {
  List<String> flattenedList = [];
  for (var sublist in nestedList) {
    if (sublist is List<dynamic>) {
      flattenedList.addAll(getListasString(sublist));
    } else {
      flattenedList.add(sublist.toString());
    }
  }
  return flattenedList;
}

OrderModel filterProducts(
    List<OrderModel> productList, String productIdList) {
  productList
      .where((product) => productIdList.contains(productIdList))
      .toList();
  return productList[0];
}
Future<DocumentSnapshot> getAddressId(String addressid,String userId) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('address').where('id',isEqualTo: addressid)
      // .where('isDefault', isEqualTo: true)
      .get();
  return querySnapshot.docs.first;
}
Future<QuerySnapshot> getProductIdFromOrders() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;
  final querySnapshot = await FirebaseFirestore.instance
      .collection('orders')
      .where('userId', isEqualTo: userID)
      .where('orderStatus', isEqualTo: 'placed')
      .get();
  return querySnapshot;
}
Future<QuerySnapshot> getProducts() async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('product').get();
  return querySnapshot;
}

