import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce_admin/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/details_tile.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/orderdetailswidget.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          detailsTile(title: 'admin', maintitle: 'username'),
          detailsTile(
              height: 150,
              title:
                  'akldjsfaspdufapiudshfaiusdhfpiakldjsfaspdufapiudshfaiusdhfpiasudfkasjdnfakdjsbfndjsbvbnfdasudfkasjdnfakdjsbfndjsbvbnfd dsoipfjadf',
              maintitle: 'adress'),
          detailsTile(title: 'debit card', maintitle: 'payment Methode'),
          detailsTile(title: 'admin', maintitle: 'username'),
          detailsTile(title: 'admin', maintitle: 'username'),
          sbox,
          OrderDetailsCard()
        ]),
      ),
    );
  }
}
