import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce_admin/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/screens/order_details.dart';

// enum orderstatus {
//   Delivered,shipped
// }
class OrdersTile extends StatelessWidget {
  const OrdersTile({
    required this.orderId,
    super.key,
    required this.order,
    this.height,
    required this.orderstatus,
  });

  final String order;
  final String orderId;
  final double? height;
  final String orderstatus;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: colorgray,
            width: size.width,
            height: height ?? 70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      order,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      orderstatus,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
