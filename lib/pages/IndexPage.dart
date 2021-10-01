import 'dart:async';

import 'package:amazon_clone/providers/IndexPageProvider.dart';
import 'package:amazon_clone/widgets/AmzAppBar.dart';
import 'package:amazon_clone/widgets/AmzHoverBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final pageController = PageController(initialPage: 0);
  var timer;

  @override
  void initState() {
    super.initState();
    Provider.of<IndexPageProvider>(context, listen: false).fetchCategories();
    Provider.of<IndexPageProvider>(context, listen: false).fetchProducts();
    Provider.of<IndexPageProvider>(context, listen: false).getUser();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Timer.periodic(Duration(seconds: 10), (timer) {
        pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      });
    });
  }

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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width > 1100 ? 200 : 0,
                      ),
                      child: Stack(
                        children: [
                          PageView.builder(
                            itemBuilder: (context, index) {
                              return Container(
                                width: 500,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/carousel${(index % 8) + 1}.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            controller: pageController,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.15,
                            ),
                            child: Row(
                              children: [
                                AmzHoverBox(
                                  child: Container(
                                    height: 100,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20.0,
                                        ),
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    pageController.previousPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                ),
                                Spacer(),
                                AmzHoverBox(
                                  child: Container(
                                    height: 100,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    pageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.35,
                        left:
                            MediaQuery.of(context).size.width > 1100 ? 220 : 20,
                        right:
                            MediaQuery.of(context).size.width > 1100 ? 220 : 20,
                      ),
                      child: Consumer<IndexPageProvider>(
                        builder: (context, provider, _) {
                          if (provider.products.length > 0) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        MediaQuery.of(context).size.width > 1100
                                            ? 4
                                            : 3,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 20,
                                    childAspectRatio:
                                        MediaQuery.of(context).size.width > 1100
                                            ? 20 / 21
                                            : 20 / 25,
                                  ),
                                  itemCount: 8,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.all(15),
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 50,
                                            child: Text(
                                              provider.products[index].title,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Center(
                                            child: Container(
                                              height: 150,
                                              child: Image.network(
                                                provider.products[index].image,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          RichText(
                                            text: TextSpan(
                                              text: '₹ ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${(double.parse(provider.products[index].price) * 70).toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          getRating(
                                            context,
                                            double.parse(
                                              provider
                                                  .products[index].rating.rate,
                                            ).round(),
                                            provider
                                                .products[index].rating.count,
                                          ),
                                          SizedBox(height: 5),
                                          Spacer(),
                                          Material(
                                            color: Colors.orangeAccent,
                                            child: InkWell(
                                              onTap: () {
                                                provider.addToCart(context,
                                                    provider.products[index]);
                                              },
                                              child: Container(
                                                height: 30,
                                                child: Center(
                                                  child: Text(
                                                    'Add to Cart',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                Container(
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ...List.generate(
                                        MediaQuery.of(context).size.width > 1100
                                            ? 6
                                            : 4,
                                        (index) => Container(
                                          width: 200,
                                          padding: EdgeInsets.all(15),
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Tooltip(
                                                message: provider
                                                    .products[index + 9].title,
                                                child: Container(
                                                  height: 39,
                                                  child: Text(
                                                    provider.products[index + 9]
                                                        .title,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              getRating(
                                                context,
                                                double.parse(
                                                  provider.products[index]
                                                      .rating.rate,
                                                ).ceil(),
                                                provider.products[index].rating
                                                    .count,
                                              ),
                                              Container(
                                                height: 150,
                                                child: Image.network(
                                                  provider.products[index + 9]
                                                      .image,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: '₹ ',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          '${(double.parse(provider.products[index].price) * 70).toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Material(
                                                color: Colors.orangeAccent,
                                                child: InkWell(
                                                  onTap: () {
                                                    provider.addToCart(
                                                        context,
                                                        provider
                                                            .products[index]);
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    child: Center(
                                                      child: Text(
                                                        'Add to Cart',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        MediaQuery.of(context).size.width > 1100
                                            ? 4
                                            : 3,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 20,
                                    childAspectRatio:
                                        MediaQuery.of(context).size.width > 1100
                                            ? 20 / 21
                                            : 20 / 25,
                                  ),
                                  itemCount:
                                      MediaQuery.of(context).size.width > 1100
                                          ? 4
                                          : 6,
                                  itemBuilder: (context, index) {
                                    int tempIndex =
                                        MediaQuery.of(context).size.width > 1100
                                            ? index + 15
                                            : index + 13;
                                    return Container(
                                      padding: EdgeInsets.all(15),
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 50,
                                            child: Text(
                                              provider
                                                  .products[tempIndex].title,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Center(
                                            child: Container(
                                              height: 150,
                                              child: Image.network(
                                                provider
                                                    .products[tempIndex].image,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          RichText(
                                            text: TextSpan(
                                              text: '₹ ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${(double.parse(provider.products[tempIndex].price) * 70).toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          getRating(
                                            context,
                                            double.parse(
                                              provider.products[tempIndex]
                                                  .rating.rate,
                                            ).round(),
                                            provider.products[tempIndex].rating
                                                .count,
                                          ),
                                          SizedBox(height: 5),
                                          Spacer(),
                                          Material(
                                            color: Colors.orangeAccent,
                                            child: InkWell(
                                              onTap: () {
                                                provider.addToCart(
                                                    context,
                                                    provider
                                                        .products[tempIndex]);
                                              },
                                              child: Container(
                                                height: 30,
                                                child: Center(
                                                  child: Text(
                                                    'Add to Cart',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 50),
                              ],
                            );
                          }
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor: Colors.grey[300]!,
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    MediaQuery.of(context).size.width > 1100
                                        ? 4
                                        : 3,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 20,
                                childAspectRatio: 200 / 250,
                              ),
                              itemCount: 8,
                              itemBuilder: (context, index) {
                                return Container(
                                  color: Colors.white,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getRating(BuildContext context, int rate, String count) {
    return Row(
      children: [
        ...List.generate(
          rate,
          (index) => Icon(
            Icons.star,
            color: Colors.orangeAccent,
          ),
        ),
        ...List.generate(
          5 - rate,
          (index) => Icon(
            Icons.star_border_outlined,
          ),
        ),
        SizedBox(width: 5),
        Text('($count)')
      ],
    );
  }
}
