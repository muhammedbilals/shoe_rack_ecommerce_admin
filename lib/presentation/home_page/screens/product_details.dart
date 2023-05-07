import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce_admin/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce_admin/model/product.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/screens/edit_product.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/MainButton.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/details_tile.dart';

class ProductsDetails extends StatelessWidget {
  const ProductsDetails({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    // final  products =product!.fromJason(data);
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
                  child: data['imgurl'] != ""
                      ? Image.network(
                          data['imgurl'],
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: size.width,
                          width: size.width,
                          color: colorgreen,
                          child: Center(child: Text('no image were added')),
                        ),
                ),
                detailsTile(maintitle: 'title', title: data['name']),
                detailsTile(maintitle: 'subtitle', title: data['subtitle']),
                detailsTile(maintitle: 'price', title: data['price']),
                detailsTile(maintitle: 'color', title: data['color']),
                detailsTile(maintitle: 'size', title: data['size'].toString()),
                detailsTile(
                    height: 150,
                    maintitle: 'discription',
                    title: data['description']),
                const SizedBox(
                  height: 250,
                )
              ],
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: size.width * 0.9,
                  height: 60,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(colorgreen),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProduct(data: data),
                          ));
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 25,
                      color: colorwhite,
                    ),
                    label: Text(
                      'Edit Product',
                      style: TextStyle(fontSize: 22, color: colorwhite),
                    ),
                  ),
                ),
              ),
            )
            //  Positioned(
            //     left: 0,
            //     right: 0,
            //     bottom: 10,
            //     child: CustomButton(
            //       widget: EditProduct(data: data),
            //       icon: Icons.edit,
            //       text: 'Edit Product',
            //     ))
          ],
        ),
      ),
    );
  }
}
