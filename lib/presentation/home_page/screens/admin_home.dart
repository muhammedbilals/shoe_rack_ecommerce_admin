import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/productdetails_products.dart';
import 'package:shoe_rack_ecommerce_admin/presentation/home_page/widgets/products_details_orders.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(
                     Icons.back_hand_rounded,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                      const Spacer(),
                      const Center(
                        child: Text(
                          'Orders',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const TabBar(
                    indicatorColor: Colors.green,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(height: 40, text: 'Products'),
                      Tab(height: 40, text: 'Orders'),
                    ]),
              ],
            ),
          ),
          body:  TabBarView(
              // physics: NeverScrollableScrollPhysics(),
              physics: BouncingScrollPhysics(),
              children: [ProductsPage(), OrdersPage()]),
        ),
      ),
    );
  }
}