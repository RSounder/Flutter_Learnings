import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'homePage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

TextEditingController emailController = new TextEditingController();

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  bool firstLogin;

  LoginScreen({this.firstLogin = true});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Future futureData;
  var _formKey = GlobalKey<FormState>();

  get states => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Login')),
        body: SingleChildScrollView(
            child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(top: 60, bottom: 40),
                          child: Center(
                            child: Container(
                                width: 200,
                                height: 150,
                                child:
                                    Image.asset('assets/images/logo_main.png')),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          controller: emailController,
                          autocorrect: false,
                          maxLength: 50,
                          decoration: InputDecoration(
                              counterText: '', //disable char counter
                              labelText: 'email ID',
                              hintText: 'abc123@gmail.com',
                              border: OutlineInputBorder()),
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required'),
                            EmailValidator(
                                errorText: 'Please enter a valid email ID'),
                            MaxLengthValidator(50,
                                errorText: 'email ID can be utmost 50 chars')
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        child: TextFormField(
                          autocorrect: false,
                          obscureText: true,
                          maxLength: 20,
                          decoration: InputDecoration(
                              counterText: '', //disable char counter
                              labelText: 'Password',
                              border: OutlineInputBorder()),
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required'),
                            MinLengthValidator(5,
                                errorText: 'Password should atleast 5 chars'),
                            MaxLengthValidator(20,
                                errorText: 'Password should utmost 20 chars'),
                          ]),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            //on pressing forgot password
                            final snackBar = SnackBar(
                                content:
                                    Text('Sorry; Feature under construction!'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Text('Forgot Password',
                              textAlign: TextAlign.center),
                          style: TextButton.styleFrom(
                            primary: Colors.blue,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate() &&
                                    widget.firstLogin) {
                                  //navigate to home page
                                  final Map<String, String> header = {
                                    'Accept': 'application/json',
                                    'api-token':
                                        'XVt0338CSXlt42XpF3NSGluXcw01bq392H-ptps68-cw6f9nwuuSGcG71tlJYuTZVVg',
                                    'user-email': emailController.text
                                  };
                                  final response = await http.get(
                                      Uri.parse(
                                          'https://www.universal-tutorial.com/api/getaccesstoken?'),
                                      headers: header);
                                  dynamic authResult =
                                      json.decode(response.body);

                                  if (response.statusCode == 200) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => HomePage(
                                                authResult['auth_token'] ??
                                                    'tokenNull')));
                                  } else {
                                    final snackBar = SnackBar(
                                        content: Text(authResult['error']));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    //throw Exception(jsonResponse['error']);
                                  }
                                } else if (_formKey.currentState!.validate() &&
                                    !widget.firstLogin) {
                                  //return true/false for authentication Doubt?
                                  return;
                                } else {
                                  final snackBar = SnackBar(
                                      content: Text(
                                          'User name or Password invalid'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Text('Login'),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(250, 50),
                                  primary: Colors.blueAccent,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50)))))
                    ]))));
  }
}
