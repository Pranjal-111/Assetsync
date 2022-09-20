import 'dart:convert';

import 'package:assetsync/services/custom_sneak_bar.dart';
import 'package:assetsync/services/email_validator.dart';
import 'package:assetsync/services/random_password_generator.dart';
import 'package:assetsync/utils/constant.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/rounded_button.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mysql1/mysql1.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    final TextEditingController userName = TextEditingController();

    return Scaffold(
      backgroundColor: kBGcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              color: kBGcolor,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "AssetSync",
                    style: kHeadingTextStyle.copyWith(fontSize: 40),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: kBGcolor,
                    child: Image.asset(
                      'images/logo.png',
                      height: 180,
                      width: 180,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Reset Your Password",
                    style: kSubHeadingTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Form(
                      key: formkey,
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16))),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: userName,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter A Email';
                                  } else if (!EmailValidator.validate(value)) {
                                    return 'Please Enter A Valid Email';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: ' Username',
                                  hintText: 'Enter Username',
                                  prefixIcon: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.email,
                                        color: kPrimaryColor,
                                      )),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              RoundedButton(
                                title: "Reset Password",
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    await MySqlConnection.connect(
                                            connectionSettings)
                                        .then(
                                      (conn) async {
                                        conn.query(
                                            'SELECT * FROM `admin` WHERE admin.username = ?;',
                                            [userName.text]).then(
                                          (result) {
                                            if (result.isEmpty) {
                                              showErrorMessage(
                                                  context, "No User Exits");
                                            } else {
                                              progressbar(context);
                                              String password =
                                                  RandomPasswordGenerator()
                                                      .randomPassword(
                                                          letters: true,
                                                          uppercase: true,
                                                          number: true,
                                                          passwordLength: 10);
                                              final hmacSha256 = Hmac(sha256,
                                                  secretKey); // HMAC-SHA256
                                              final passwordDigest = hmacSha256
                                                  .convert(
                                                      utf8.encode(password))
                                                  .toString();
                                              final message = Message()
                                                ..from = senderAdress
                                                ..recipients
                                                    .add(result.first['email'])
                                                ..subject =
                                                    'Assets Sync Password Reset'
                                                ..text =
                                                    'Welcome To Assets Sync.\nPassword Reset For . \n\n\nUser Id  : ${userName.text}\nPassword : $password';

                                              showSuccessMessage(context,
                                                  "Mail Send To ${result.first['email']}");
                                              send(message, smtpServer)
                                                  .whenComplete(
                                                () async {
                                                  conn.query(
                                                      'UPDATE `admin` SET `password`=? WHERE username = ?;',
                                                      [
                                                        passwordDigest,
                                                        userName.text
                                                      ]).then(
                                                    (value) {
                                                      if (value.insertId !=
                                                          null) {
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
                                                },
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ).onError(
                                      (error, stackTrace) {
                                        showErrorMessage(context,
                                            "Some Error occured $error");
                                      },
                                    );
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              GestureDetector(
                                  onTap: (() {
                                    Navigator.pop(context);
                                  }),
                                  child: const Text(
                                    'Back To Login',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                              const SizedBox(
                                height: 4.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
