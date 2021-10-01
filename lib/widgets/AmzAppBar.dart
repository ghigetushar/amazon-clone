import 'package:amazon_clone/globals.dart';
import 'package:amazon_clone/pages/CartPage.dart';
import 'package:amazon_clone/pages/IndexPage.dart';
import 'package:amazon_clone/pages/LoginPage.dart';
import 'package:amazon_clone/providers/IndexPageProvider.dart';
import 'package:amazon_clone/widgets/AmzHoverBox.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class AmzAppBar extends StatelessWidget {
  const AmzAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF131921),
      pinned: true,
      title: Container(
        child: Column(
          children: [
            Row(
              children: [
                AmzHoverBox(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IndexPage(),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/amazon-logo.png',
                    width: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                  child: AmzHoverBox(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.location_on_outlined, size: 18),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Select your address',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 50,
                              height: 40,
                              color: Colors.grey.shade300,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'All',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 15,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              onEditingComplete: () {
                                /* 
                                !Impelement Search
                                */
                                print(Provider.of<IndexPageProvider>(context,
                                        listen: false)
                                    .searchController
                                    .text);
                              },
                              controller:
                                  Provider.of<IndexPageProvider>(context)
                                      .searchController,
                              cursorHeight: 20,
                              cursorWidth: 1,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              /* 
                              !Impelement Search
                              */
                              print(Provider.of<IndexPageProvider>(context,
                                      listen: false)
                                  .searchController
                                  .text);
                            },
                            child: Container(
                              width: 50,
                              color: Colors.orangeAccent,
                              child: Center(
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                PopupMenuButton(
                  tooltip: 'account',
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer<IndexPageProvider>(
                                builder: (context, provider, _) {
                                  if (provider.userModel != null) {
                                    return Text(
                                      'Hello, ${provider.userModel?.username}',
                                      style: TextStyle(fontSize: 12),
                                    );
                                  }
                                  return Text(
                                    'Hello, Sign in',
                                    style: TextStyle(fontSize: 12),
                                  );
                                },
                              ),
                              Text(
                                'Accounts and List',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_drop_down, size: 18),
                        ],
                      ),
                    ),
                  ),
                  offset: Offset(-20, 40),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        padding: EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () async {
                            if (sharedPreferences.getString('token') == null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                              return;
                            }
                            await sharedPreferences.remove('token');
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IndexPage(),
                              ),
                              (route) => false,
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                            ),
                            child: Center(
                              child: Text(
                                sharedPreferences.getString('token') == null
                                    ? 'Sign in'
                                    : 'Logout',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                ),
                AmzHoverBox(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 50,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            children: [
                              Icon(
                                LineIcons.shoppingCart,
                                size: 35,
                              ),
                              Positioned(
                                right: 0,
                                child: Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Consumer<IndexPageProvider>(
                                      builder: (context, provider, _) {
                                        return Text(
                                          '${provider.cart.length}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Cart',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
