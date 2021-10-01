import 'dart:convert';

import 'package:amazon_clone/constants/ApiConstants.dart';
import 'package:amazon_clone/globals.dart';
import 'package:amazon_clone/models/ProductModel.dart';
import 'package:amazon_clone/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class IndexPageProvider extends ChangeNotifier {
  var searchController = TextEditingController();
  List<ProductModel> products = [];
  List categories = [];
  List<ProductModel> cart = [];
  UserModel? userModel;

  fetchProducts() async {
    final resp = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    products = (jsonDecode(resp.body) as List)
        .map((e) => ProductModel.fromMap(e))
        .toList();
    notifyListeners();
  }

  fetchCategories() async {
    final resp = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));
    categories = (jsonDecode(resp.body) as List);
    notifyListeners();
  }

  getUser() async {
    if (sharedPreferences.getString('token') != null) {
      final resp = await http.get(
          Uri.parse(
            '$API_PROTOCOL://$API_HOST:$API_PORT/api/users/get',
          ),
          headers: {
            'x-access-token': sharedPreferences.getString('token') ?? '',
          });
      var jsonDecodedData = jsonDecode(resp.body);
      if (jsonDecodedData['error'] != null) {
        Fluttertoast.showToast(
          webPosition: 'left',
          webBgColor: '#0D0106',
          msg: jsonDecodedData['error'],
          timeInSecForIosWeb: 3,
        );
      } else {
        userModel = UserModel.fromMap(jsonDecodedData);
        notifyListeners();
      }
      return;
    }
    userModel = null;
  }

  addToCart(BuildContext context, ProductModel productModel) async {
    this.cart.add(productModel);
    Fluttertoast.showToast(
      webPosition: 'left',
      webBgColor: '#0D0106',
      msg: 'Product added to cart...',
      timeInSecForIosWeb: 3,
    );
    notifyListeners();
  }

  emptyCart(BuildContext context) {
    this.cart = [];
    notifyListeners();
  }

  removeElement(BuildContext context, int index) {
    this.cart.removeAt(index);
    notifyListeners();
  }

  getTotalPrice() {
    double _total = 0.0;
    for (var item in cart) {
      print(item.price);
      _total += double.parse(item.price) * 70;
    }
    return _total.toStringAsFixed(2);
  }
}
