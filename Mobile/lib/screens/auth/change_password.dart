import 'dart:convert';

import 'package:assetsync/bloc/connection_cubit.dart';
import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/services/custom_sneak_bar.dart';
import 'package:assetsync/utils/constant.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/error.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:assetsync/widgets/no_internet.dart';
import 'package:assetsync/widgets/rounded_button.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysql1/mysql1.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<GloablAuthCubit>(context);

    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    final TextEditingController currentPassword = TextEditingController();

    final TextEditingController typepass = TextEditingController();

    final TextEditingController retypepass = TextEditingController();
    return Scaffold(
        backgroundColor: kBGcolor,
        appBar: simpleappbar(),
        body: BlocBuilder<ConnectionCubit, ConnectionStates>(
            builder: (context, state) {
          switch (state) {
            case ConnectionStates.checking:
              return const Loading();
            case ConnectionStates.notConnected:
              return const NoInternet();
            case ConnectionStates.error:
              return const ErrorScreen();
            case ConnectionStates.connected:
              return SafeArea(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Container(
                            decoration: BoxDecoration(
                                color: kGrey,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    //   offset: const Offset(10, 10)
                                  )
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Change Password",
                                      style: kHeadingTextStyle,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CircleAvatar(
                                      radius: 100,
                                      backgroundColor: kBGcolor,
                                      child: Image.asset(
                                        'images/logo.png',
                                        height: 150,
                                        width: 150,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    TextFormField(
                                      controller: currentPassword,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Password';
                                        } else if (value.length < 5 ||
                                            value.length > 10) {
                                          return 'Password Should be of 5 Character and less than 10 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: kTextFieldDecoration.copyWith(
                                        labelText: 'Current Password',
                                        hintText: 'Enter Current Password',
                                        prefixIcon: const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.lock,
                                              color: kPrimaryColor,
                                            )),
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    TextFormField(
                                      controller: typepass,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Password';
                                        } else if (value.length < 5 ||
                                            value.length > 10) {
                                          return 'Password Should be of 5 Character and less than 10 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: kTextFieldDecoration.copyWith(
                                        labelText: 'New Password',
                                        hintText: 'Enter New Password',
                                        prefixIcon: const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.lock_outlined,
                                              color: kPrimaryColor,
                                            )),
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    TextFormField(
                                      controller: retypepass,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Password';
                                        } else if (typepass.text.toString() !=
                                            value.toString()) {
                                          return "Typed password does not match";
                                        } else if (value.length < 5 ||
                                            value.length > 10) {
                                          return 'Password Should be of 5 Character and less than 10 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: kTextFieldDecoration.copyWith(
                                        labelText: 'Retype Password',
                                        hintText: 'Retype New Password',
                                        prefixIcon: const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.lock_outline,
                                              color: kPrimaryColor,
                                            )),
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    RoundedButton(
                                      title: "Generated",
                                      onPressed: () {
                                        progressbar(context);
                                        if (formkey.currentState!.validate()) {
                                          final hmacSha256 = Hmac(
                                              sha256, secretKey); // HMAC-SHA256
                                          final currentPasswordDigest =
                                              hmacSha256
                                                  .convert(utf8.encode(
                                                      currentPassword.text))
                                                  .toString();
                                          MySqlConnection.connect(
                                                  connectionSettings)
                                              .then(
                                            (conn) {
                                              conn.query(
                                                  'SELECT * FROM `admin` WHERE id = ?;',
                                                  [
                                                    blocProvider.userId
                                                  ]).then((result) {
                                                if (result.isEmpty) {
                                                  showErrorMessage(
                                                      context, "No User Exits");
                                                } else if (result
                                                        .first['password'] ==
                                                    currentPasswordDigest) {
                                                  final newPasswordDigest =
                                                      hmacSha256
                                                          .convert(utf8.encode(
                                                              typepass.text))
                                                          .toString();

                                                  conn.query(
                                                      'UPDATE `admin` SET `password`=? WHERE id = ?',
                                                      [
                                                        newPasswordDigest,
                                                        blocProvider.userId
                                                      ]).then(
                                                    (value) {
                                                      if (value.insertId !=
                                                          null) {
                                                        showSuccessMessage(
                                                            context,
                                                            'Password Changed Sucessfully!');
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      } else {
                                                        showErrorMessage(
                                                            context,
                                                            'Some Error Occured');
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                  ).onError(
                                                      (error, stackTrace) {
                                                    showErrorMessage(context,
                                                        "Some Error occured $error");
                                                    Navigator.pop(context);
                                                  });
                                                } else {
                                                  showErrorMessage(context,
                                                      "Current Password Is Wrong");
                                                  Navigator.pop(context);
                                                }
                                              }).onError((error, stackTrace) {
                                                showErrorMessage(context,
                                                    "Some Error occured $error");
                                                Navigator.pop(context);
                                              });
                                            },
                                          ).onError(
                                            (error, stackTrace) {
                                              showErrorMessage(context,
                                                  "Some Error occured $error");
                                              Navigator.pop(context);
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
          }
        }));
  }
}
