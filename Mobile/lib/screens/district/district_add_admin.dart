import 'package:assetsync/bloc/connection_cubit.dart';
import 'package:assetsync/database/district_mysql_helper.dart';
import 'package:assetsync/services/email_validator.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/error.dart';
import 'package:assetsync/widgets/loading.dart';
import 'package:assetsync/widgets/no_internet.dart';
import 'package:assetsync/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistrictAddAdmin extends StatelessWidget {
  const DistrictAddAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    final TextEditingController email = TextEditingController();

    final TextEditingController phone = TextEditingController();

    final TextEditingController name = TextEditingController();

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
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(24),
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
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Add Sub Area Details",
                            style: kHeadingTextStyle,
                            textAlign: TextAlign.center,
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
                            height: 20,
                          ),
                          TextFormField(
                            controller: name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Name';
                              } else if (value.length < 3) {
                                return 'Name Should be of 3 Character';
                              } else {
                                return null;
                              }
                            },
                            decoration: kTextFieldDecoration.copyWith(
                              labelText: 'Enter Name',
                              hintText: 'Enter Name',
                              prefixIcon: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.person,
                                    color: kPrimaryColor,
                                  )),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            controller: email,
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
                              labelText: 'Enter E-mail',
                              hintText: 'E-mail',
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
                          TextFormField(
                            controller: phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Password';
                              } else if (value.length < 5) {
                                return 'Password Should be of 5 Character';
                              } else {
                                return null;
                              }
                            },
                            decoration: kTextFieldDecoration.copyWith(
                              labelText: 'Enter Phone Number',
                              hintText: 'Enter Phone Number',
                              prefixIcon: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.phone,
                                    color: kPrimaryColor,
                                  )),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          RoundedButton(
                              title: "Generate",
                              onPressed: () {
                                DistrictMySqlHelper.addDSubArea(context,
                                        name.text, email.text, phone.text)
                                    .whenComplete(() {
                                  Navigator.pop(context);
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              );
          }
        }));
  }
}
