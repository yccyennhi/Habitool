import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitool/Custom_Values/custom_colors.dart';
import 'package:habitool/model/auth_provider.dart';
import 'package:habitool/view/screen/dashboard/dashboard_screen.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _isObscure = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.light,
      body: isLoading == false
          ? SingleChildScrollView(
              child: Container(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: <Widget>[
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: CustomColors.blue,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(30)),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 115.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 25.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 25.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'Đăng nhập',
                                      style: TextStyle(
                                        color: CustomColors.black,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    child: TextField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Tài khoản',
                                        labelStyle: TextStyle(
                                          color: CustomColors.grey,
                                          fontSize: 15,
                                        ),
                                        suffixIcon: _emailController
                                                .text.isEmpty
                                            ? Container(
                                                width: 0.0,
                                              )
                                            : IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: () =>
                                                    _emailController.clear(),
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  Container(
                                    child: TextField(
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        labelText: 'Mật khẩu',
                                        labelStyle: TextStyle(
                                          color: CustomColors.grey,
                                          fontSize: 15,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            (_isObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                          ),
                                          onPressed: _toggleObscure,
                                        ),
                                      ),
                                      obscureText: _isObscure,
                                    ),
                                  ),
                                  SizedBox(height: 50.0),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: CustomColors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      minimumSize: Size(700, 50),
                                    ),
                                    child: Text('Đăng nhập',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    onPressed: () {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      AuthClass()
                                          .signIn(
                                              email:
                                                  _emailController.text.trim(),
                                              password: _passwordController.text
                                                  .trim())
                                          .then((value) {
                                        if (value == "Welcome") {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DashBoardScreen()),
                                              (route) => false);
                                        } else {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(value)));
                                        }
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 25.0),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    minimumSize: Size(100, 50),
                                  ),
                                  icon: Image.asset(
                                    'assets/images/google-logo.png',
                                    height: 35.0,
                                  ),
                                  label: Text('Google',
                                      style: TextStyle(
                                        color: CustomColors.darkgrey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  onPressed: () {
                                    AuthClass()
                                        .signWithGoogle()
                                        .then((UserCredential value) {
                                      final displayName =
                                          value.user.displayName;

                                      print(displayName);

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DashBoardScreen()),
                                          (route) => false);
                                    });
                                  },
                                  onLongPress: () {},
                                ),
                              ),
                              SizedBox(
                                width: 25.0,
                              ),
                              Expanded(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    minimumSize: Size(100, 50),
                                  ),
                                  icon: Image.asset(
                                    'assets/images/facebook-logo.png',
                                    height: 35.0,
                                  ),
                                  label: Text(
                                    'Facebook',
                                    style: TextStyle(
                                      color: CustomColors.darkgrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {},
                                  onLongPress: () {},
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Bạn chưa có tài khoản?',
                                style: TextStyle(
                                  color: CustomColors.darkgrey,
                                  fontSize: 13,
                                ),
                              ),
                              TextButton(
                                child: Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                    color: CustomColors.link,
                                    fontSize: 13,
                                  ),
                                ),
                                onPressed: () {},
                                onLongPress: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
