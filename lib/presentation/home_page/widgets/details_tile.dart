import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce_admin/core/colors/colors.dart';

class detailsTile extends StatelessWidget {
  const detailsTile({
    super.key,
    required this.title,
    this.height,
    required this.maintitle,
  });

  final String title;
  final double? height;
  final String maintitle;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(maintitle),
          ),
          Container(
            color: colorgray,
            width: size.width,
            height: height != null ? height : 50,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
