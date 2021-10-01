import 'package:amazon_clone/providers/IndexPageProvider.dart';
import 'package:amazon_clone/widgets/AmzAppBar.dart';
import 'package:amazon_clone/widgets/AmzHoverBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AmzAppBar(),
          SliverToBoxAdapter(
            child: Container(
              height: 40,
              width: double.infinity,
              color: Color(0xFF232F3E),
              child: Consumer<IndexPageProvider>(
                builder: (context, provider, _) {
                  if (provider.categories.length > 0) {
                    return Row(
                      children: [
                        SizedBox(width: 20),
                        ...List.generate(
                          provider.categories.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: AmzHoverBox(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 5,
                                ),
                                child: Text(
                                  provider.categories[index][0].toUpperCase() +
                                      provider.categories[index].substring(1),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Consumer<IndexPageProvider>(
                builder: (context, provider, _) {
                  if (provider.cart.length > 0) {
                    return Container(
                      margin: EdgeInsets.only(
                        top: 30,
                        left: 30,
                        right: MediaQuery.of(context).size.width * 0.2,
                      ),
                      padding: EdgeInsets.only(top: 30, left: 30),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shopping Cart',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              provider.emptyCart(context);
                            },
                            child: Text(
                              "Delete all items",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Price'),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            endIndent: 30,
                            height: 0.5,
                            thickness: 0,
                          ),
                          ...List.generate(
                            provider.cart.length,
                            (index) => Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 5,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 150,
                                          child: Image.network(
                                            provider.cart[index].image,
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8.0,
                                                    ),
                                                    child: Text(
                                                      provider
                                                          .cart[index].title,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 120),
                                                  TextButton(
                                                    onPressed: () {
                                                      provider.removeElement(
                                                        context,
                                                        index,
                                                      );
                                                    },
                                                    child: Text(
                                                      "remove",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 25.0),
                                                child: Text(
                                                  "₹" +
                                                      (double.parse(provider
                                                                  .cart[index]
                                                                  .price) *
                                                              70)
                                                          .toStringAsFixed(2),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    endIndent: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 30, bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Subtotal (${provider.cart.length}): ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '₹ ${provider.getTotalPrice()}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(
                      top: 30,
                      left: 30,
                      right: MediaQuery.of(context).size.width * 0.2,
                    ),
                    padding: EdgeInsets.only(top: 40, left: 30),
                    height: 150,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Amazon Cart is empty.',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Your shopping cart is waiting. Give it purpose – fill it with groceries, clothing, household supplies, electronics and more.\nContinue shopping on the Amazon.in homepage, learn about today\'s deals, or visit your Wish List.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
