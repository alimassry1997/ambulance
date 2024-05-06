import 'dart:convert';
import 'dart:developer';

import 'package:ambulancecheckup/firestore_functions.dart';
import 'package:ambulancecheckup/routes/routes.dart';
import 'package:ambulancecheckup/screens/main_screen.dart';
import 'package:ambulancecheckup/utils/validations.dart';
import 'package:ambulancecheckup/widgets/button.dart';
import 'package:ambulancecheckup/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  bool obscurePassword = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Image.asset('assets/images/logo.png',
                    width: 200, height: 200, fit: BoxFit.cover),
                const SizedBox(height: 60),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MainTextFormField(
                          controller: userNameController,
                          labelText: 'Username',
                          hintText: 'Username',
                          validator: Validations.defaultValidator.call,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        MainTextFormField(
                            controller: passwordController,
                            obscureText: obscurePassword,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                child: (obscurePassword)
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: mainRedColor,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: mainRedColor,
                                      )),
                            labelText: 'Password',
                            hintText: 'Password',
                            validator: Validations.passwordValidator.call,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done),
                      ],
                    )),
                const SizedBox(height: 50),
                MainButton(
                  child: 'Login',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FireStoreAPIs.checkUserExists(
                              username: userNameController.text,
                              encryptedPassword: passwordController.text)
                          .then((value) {
                        if (value != null) {
                          Hive.box('localStorage')
                              .put('user', jsonEncode(value.toJson()));
                          log(Hive.box('localStorage').get('user'));
                          Navigator.of(context).pushNamed(Routes.mainScreen);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Wrong Credentials!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: mainRedColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      });
                    }
                  },
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                const SizedBox(height: 50),
                // MainButton(
                //   child: 'Register',
                //   onPressed: () async {
                //     if (_formKey.currentState!.validate()) {
                //       FireStoreAPIs.createUser(
                //               username: userNameController.text,
                //               password: passwordController.text)
                //           .then((value) {
                //         if (value != null) {
                //           Navigator.of(context).pushNamed(Routes.mainScreen);
                //         }
                //       });
                //     }
                //   },
                //   height: 50,
                //   width: MediaQuery.of(context).size.width * 0.8,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
