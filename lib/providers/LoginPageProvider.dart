import 'dart:convert';

import 'package:amazon_clone/globals.dart';
import 'package:amazon_clone/models/UserModel.dart';
import 'package:amazon_clone/pages/IndexPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginPageProvider extends ChangeNotifier {
  TextEditingController emailOrMobileNumber = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool keepMeSignedIn = false;

  bool isLoading = false;
  bool isError = false;
  String errorMessage = "";

  setKeepMeSigned(bool val) {
    this.keepMeSignedIn = val;
    notifyListeners();
  }

  bool isValid(BuildContext context) {
    isError = false;
    notifyListeners();
    if (emailOrMobileNumber.text.isEmpty) {
      isError = true;
      errorMessage = 'Invalid email/mobile number or password';
      notifyListeners();
      return false;
    }
    if (passwordController.text.length < 6) {
      isError = true;
      errorMessage = 'Invalid email/mobile number or password';
      notifyListeners();
      return false;
    }
    return true;
  }

  validateAndRegister(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    if (isValid(context)) {
      LoginUserModel loginUserModel = LoginUserModel(
          mobileNumberOrEmail: emailOrMobileNumber.text,
          password: passwordController.text);
      var resp = await http.post(
          Uri.parse('http://localhost:5000/api/users/login'),
          body: loginUserModel.toJson(),
          headers: {'content-type': 'application/json'});
      var jsonDecodedData = jsonDecode(resp.body);
      if (jsonDecodedData['error'] != null) {
        isError = true;
        errorMessage = jsonDecodedData['error'];
        isLoading = false;
        notifyListeners();
      } else if (jsonDecodedData['message'] != null) {
        await sharedPreferences.setString('token', jsonDecodedData['token']);
        isLoading = false;
        notifyListeners();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => IndexPage(),
          ),
          (route) => false,
        );
        Fluttertoast.showToast(
          webPosition: 'left',
          webBgColor: '#0D0106',
          msg: 'Login successful...',
          timeInSecForIosWeb: 3,
        );
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
