import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce_admin/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce_admin/model/order_functions.dart';
import 'package:shoe_rack_ecommerce_admin/model/order_model.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/details_tile.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/orderdetailswidget.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({super.key, required this.orderId, required this.orderModel});
  final String orderId;
  final OrderModel orderModel;
  List<String> nameList = <String>[
    'Placed',
    'Shipped',
    'Out of Delivery',
    'Delivered'
  ];

  @override
  Widget build(BuildContext context) {
    final orderRef = FirebaseFirestore.instance.collection('orders');
    String dropdownNameValue = nameList.first;
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: getOrderFromOrderId(),
        builder: (context, orderSnapshot) {
          if (orderSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (orderSnapshot.hasError) {
            return Text('Error: ${orderSnapshot.error}');
          }
          if (orderSnapshot.hasData) {
            log(orderModel.orderId!);
            return FutureBuilder<DocumentSnapshot>(
              future: getAddressId(orderModel.addressId!, orderModel.userId!),
              builder: (context, addressSnapshot) {
                String addressId = '';
                if (addressSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (addressSnapshot.hasError) {
                  return Text('Error: ${addressSnapshot.error}');
                }
                if (addressSnapshot.hasData) {
                  final addressData =
                      addressSnapshot.data!.data() as Map<String, dynamic>;
                  // addressId = addressData['id'];

                  return SingleChildScrollView(
                    child: Column(children: [
                      detailsTile(
                          title: orderModel.userId!, maintitle: 'Email'),
                      detailsTile(
                          height: 150,
                          title:
                              '${addressData['name']} ${addressData['city']}${addressData['houseName']}',
                          maintitle: 'adress'),
                      detailsTile(
                          title: orderModel.orderDate!,
                          maintitle: 'ordered on'),
                      const detailsTile(
                          title: 'RazorPay', maintitle: 'payment Method'),
                      const detailsTile(title: '', maintitle: 'products'),
                      sbox,
                      OrderDetailsActive(
                        productid: [orderModel.productId],
                      ),
                      StatefulBuilder(
                        builder: (context, setState) =>
                            DropdownButtonHideUnderline(
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
                              setState(
                                () {
                                  dropdownNameValue = value!;
                                  orderRef.doc(orderModel.orderId).update(
                                      {'orderStatus': dropdownNameValue});
                                },
                              );
                            },
                            items: nameList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ]),
                  );
                }
                return Text('laoding');
              },
            );
          }
          return const Text('loading');
        },
      ),
    );
  }
}
