import 'dart:convert';

import 'package:amazon_clone/models/UserModel.dart';
import 'package:amazon_clone/pages/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RegisterPageProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool isError = false;
  String errorMessage = "";

  bool isValid(BuildContext context) {
    isError = false;
    notifyListeners();
    if (nameController.text.isEmpty) {
      isError = true;
      errorMessage = 'Please enter your name.';
      notifyListeners();
      return false;
    }
    if (phoneController.text.isEmpty ||
        (phoneController.text.length > 10 ||
            phoneController.text.length < 10)) {
      isError = true;
      errorMessage = 'Please enter valid mobile number.';
      notifyListeners();
      return false;
    }
    if (emailController.text.isNotEmpty) {
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text)) {
        isError = true;
        errorMessage = 'please enter a valid email.';
        notifyListeners();
        return false;
      }
    }
    if (passwordController.text.length < 6) {
      isError = true;
      errorMessage = 'Password must be at least 6 characters long.';
      notifyListeners();
      return false;
    }
    return true;
  }

  validateAndRegister(BuildContext context) async {
    Fluttertoast.cancel();
    isLoading = true;
    notifyListeners();
    if (isValid(context)) {
      RegisterUserModel registerUserModel = RegisterUserModel(
        username: nameController.text,
        email: emailController.text,
        mobileNumber: phoneController.text,
        password: passwordController.text,
      );
      var resp = await http.post(
          Uri.parse('http://localhost:5000/api/users/register'),
          body: registerUserModel.toJson(),
          headers: {'content-type': 'application/json'});
      var jsonDecodedData = jsonDecode(resp.body);
      if (jsonDecodedData['error'] != null) {
        isLoading = false;
        isError = true;
        errorMessage = jsonDecodedData['error'];
        notifyListeners();
      } else if (jsonDecodedData['message'] != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(
          webPosition: 'left',
          webBgColor: '#0D0106',
          msg: 'Registered successfully. You can login now...',
          timeInSecForIosWeb: 3,
        );
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
