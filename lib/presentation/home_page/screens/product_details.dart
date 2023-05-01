import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce_admin/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/screens/edit_product.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/MainButton.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/details_tile.dart';

class ProductsDetails extends StatelessWidget {
  const ProductsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.width,
                  width: size.width,
                  color: colorgreen,
                ),
                const detailsTile(maintitle: 'title', title: 'puma'),
                const detailsTile(
                    maintitle: 'subtitle',
                    title: 'Men Black Solid Adivat Running Shoes'),
                const detailsTile(maintitle: 'price', title: '4500'),
                const detailsTile(
                    height: 150,
                    maintitle: 'discription',
                    title:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been theand typesetting industry Lorem Ipsum has been the  industrys standard dummy text ever'),
                const SizedBox(
                  height: 250,
                )
              ],
            ),
            const Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: CustomButton(
                  widget: EditProduct(),
                  icon: Icons.edit,
                  text: 'Edit Product',
                ))
          ],
        ),
      ),
    );
  }
}
