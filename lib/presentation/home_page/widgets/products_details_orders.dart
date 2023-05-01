import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce_admin/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/screens/product_details.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/orders_tile.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
       OrdersTile(order: 'order 123456', orderstatus: 'Delivered'),
       OrdersTile(order: 'order 123456', orderstatus: 'Delivered'),

       OrdersTile(order: 'order 123456', orderstatus: 'Delivered'),

       OrdersTile(order: 'order 123456', orderstatus: 'Delivered'),

      ],
    );
  }
}
