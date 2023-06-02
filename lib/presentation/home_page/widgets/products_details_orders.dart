import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce_admin/model/order_functions.dart';
import 'package:shoe_rack_ecommerce_admin/model/order_model.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/screens/order_details.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/orders_tile.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: getProductIdFromOrder(),
        builder: (context, orderSnapshot) {
          if (orderSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (orderSnapshot.hasError) {
            return Text('Error: ${orderSnapshot.error}');
          }
          if (orderSnapshot.hasData) {
            List<String> orderId = orderSnapshot.data!.docs
                .map((doc) => doc.get('orderId') as String)
                .toList();
            List<OrderModel> orders = orderSnapshot.data!.docs
                .map((doc) =>
                    OrderModel.fromJason(doc.data() as Map<String, dynamic>))
                .toList();
            log(orders.toString());
            log(orderId.toString());
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: orderId.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderDetails(
                                  orderModel: orders[index],
                                  orderId: orderId[index]),
                          ),
                        );
                      },
                      child: OrdersTile(
                          orderId: orderId[index],
                          order: orderId[index],
                          orderstatus: 'Delivered'),
                    );
                  },
                )
              ],
            );
          }
          return const Text('loading');
        });
  }
}
