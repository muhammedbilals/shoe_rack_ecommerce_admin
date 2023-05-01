import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce_admin/core/colors/colors.dart';

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Center(
        child: Container(
          width: size.width * 0.9,
          height: size.width * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: colorgray),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 90,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: colorgreen,
                      )),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.64,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 12.0, top: 0, bottom: 0),
                      child: Text(
                        'Puma',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.6,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 12.0, bottom: 0, top: 0),
                      child: Text(
                        'Men Black Solid Adivat Running Shoes',
                        style: TextStyle(
                            // overflow: TextOverflow.clip,
                            fontSize: 15,
                            color: colorblack.withOpacity(0.5)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 5),
                    child: Row(
                      children: const [
                        Text(
                          'White',
                          style: TextStyle(fontSize: 15),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            '|',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Size : 42',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 12.0, top: 0, bottom: 0),
                          child: Text(
                            '₹7,500',
                            style: TextStyle(fontSize: 25),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.25),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: colorgreen),
                            width: size.width * 0.15,
                            height: size.width * 0.09,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text('1'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
