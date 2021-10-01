import 'package:amazon_clone/pages/IndexPage.dart';
import 'package:amazon_clone/pages/RegisterPage.dart';
import 'package:amazon_clone/providers/LoginPageProvider.dart';
import 'package:amazon_clone/widgets/AmzTextField.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginPageProvider(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IndexPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: WebsafeSvg.asset(
                        'assets/svg/amazon-logo.svg',
                        width: 110,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Consumer<LoginPageProvider>(
                      builder: (context, provider, _) {
                        return Column(
                          children: [
                            if (provider.isLoading)
                              LinearProgressIndicator(
                                color: Colors.orange[200],
                                backgroundColor: Colors.orange,
                              ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sign-In',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  AmzTextField(
                                    textEditingController:
                                        provider.emailOrMobileNumber,
                                    label: 'Email or mobile phone number',
                                    autoFocus: true,
                                  ),
                                  SizedBox(height: 15),
                                  AmzPasswordField(
                                    passwordController:
                                        provider.passwordController,
                                  ),
                                  SizedBox(height: 10),
                                  Consumer<LoginPageProvider>(
                                    builder: (context, provider, _) {
                                      if (provider.isError)
                                        return Row(
                                          children: [
                                            Icon(
                                              Icons.info_outline,
                                              color: Colors.red,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              provider.errorMessage,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.red,
                                              ),
                                            )
                                          ],
                                        );
                                      return Container();
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  Material(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.circular(4),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(4),
                                      onTap: () async {
                                        await provider
                                            .validateAndRegister(context);
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Center(
                                          child: Text(
                                            'Sign-In',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            color: Colors.black54,
                                            width: 0.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: provider.keepMeSignedIn,
                                        onChanged: (val) {
                                          provider
                                              .setKeepMeSigned(val ?? false);
                                        },
                                      ),
                                      Text(
                                        'Keep me signed in.',
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 350,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey[300],
                                height: 0,
                                endIndent: 5,
                              ),
                            ),
                            Text(
                              'New to Amazon?',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                indent: 5,
                                color: Colors.grey[300],
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Material(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  'Create your Amazon account',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.black54,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AmzPasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  const AmzPasswordField({Key? key, required this.passwordController})
      : super(key: key);

  @override
  _AmzPasswordFieldState createState() => _AmzPasswordFieldState();
}

class _AmzPasswordFieldState extends State<AmzPasswordField> {
  bool showPassword = false;
  bool showPasswordIcon = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        SizedBox(height: 5),
        TextField(
          controller: widget.passwordController,
          cursorColor: Colors.black,
          cursorWidth: 0.5,
          obscureText: !showPassword,
          onChanged: (_) {
            if (widget.passwordController.text.isNotEmpty) {
              setState(() {
                this.showPasswordIcon = true;
              });
            } else {
              setState(() {
                this.showPasswordIcon = false;
              });
            }
          },
          decoration: InputDecoration(
            suffixIcon: showPasswordIcon
                ? InkWell(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: Icon(
                      showPassword ? LineIcons.eyeSlashAlt : LineIcons.eyeAlt,
                      color: Colors.black,
                    ),
                  )
                : null,
            suffixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 40),
            isDense: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.5,
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.orange,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.5,
                color: Colors.black,
              ),
            ),
            contentPadding: EdgeInsets.all(10),
          ),
        ),
      ],
    );
  }
}
