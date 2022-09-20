import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/rounded_button.dart';
import 'package:assetsync/widgets/simple_tile.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    final TextEditingController typepass = TextEditingController();

    final TextEditingController retypepass = TextEditingController();

    return Scaffold(
      backgroundColor: kBGcolor,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            "Account",
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
              height: 180,
              width: 180,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
              child: Container(
            color: kBGcolor,
            child: Column(
              children: [
                SimpleTile(
                  title: "Haryana",
                  ontap: () {
                    //    changeScreen(context, const PersonalInformation());
                  },
                  firsticon: const Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  lasticon: const Icon(
                    Icons.arrow_forward_ios,
                    color: kWhite,
                  ),
                ),
                SimpleTile(
                  title: "+91 8930091163",
                  ontap: () {
                    //    changeScreen(context, const PersonalInformation());
                  },
                  firsticon: const Icon(
                    Icons.phone,
                    color: kPrimaryColor,
                  ),
                  lasticon: const Icon(
                    Icons.arrow_forward_ios,
                    color: kWhite,
                  ),
                ),
                SimpleTile(
                  title: "haryana@cmo.gov.in",
                  ontap: () {
                    //    changeScreen(context, const PersonalInformation());
                  },
                  firsticon: const Icon(
                    Icons.email,
                    color: kPrimaryColor,
                  ),
                  lasticon: const Icon(
                    Icons.arrow_forward_ios,
                    color: kWhite,
                  ),
                ),
                SimpleTile(
                    title: "Change Passsword",
                    lasticon: const Icon(
                      Icons.arrow_forward_ios,
                      color: kPrimaryColor,
                    ),
                    ontap: () {
                      //    changeScreen(context, const About());
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (builder) {
                            return Container(
                              color: const Color(0xff677568),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Add Admin Details",
                                        style: kHeadingTextStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: kGrey,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  blurRadius: 5,
                                                  spreadRadius: 1,
                                                  //   offset: const Offset(10, 10)
                                                )
                                              ],
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Form(
                                              key: formkey,
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  TextFormField(
                                                    controller: typepass,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please Enter Password';
                                                      } else if (value.length <
                                                              10 &&
                                                          value.length > 5) {
                                                        return 'Name Should be of 5 Character and less than 10 character';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    decoration:
                                                        kTextFieldDecoration
                                                            .copyWith(
                                                      labelText:
                                                          'Enter New Password',
                                                      hintText:
                                                          'Enter New Password',
                                                      prefixIcon: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Icon(
                                                            Icons.lock,
                                                            color:
                                                                kPrimaryColor,
                                                          )),
                                                    ),
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                  ),
                                                  const SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  TextFormField(
                                                    controller: retypepass,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please Enter Password';
                                                      } else if (typepass.text
                                                              .toString() !=
                                                          value.toString()) {
                                                        return "Typed password does not match";
                                                      } else if (value.length <
                                                              10 &&
                                                          value.length > 5) {
                                                        return 'Name Should be of 5 Character and less than 10 character';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    decoration:
                                                        kTextFieldDecoration
                                                            .copyWith(
                                                      labelText:
                                                          'Retype New Password',
                                                      hintText:
                                                          'Retype New Password',
                                                      prefixIcon: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Icon(
                                                            Icons.lock_outline,
                                                            color:
                                                                kPrimaryColor,
                                                          )),
                                                    ),
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                  ),
                                                  const SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  RoundedButton(
                                                      title: "Generate",
                                                      onPressed: () {})
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
                          });
                    },
                    firsticon: const Icon(
                      Icons.published_with_changes,
                      color: kPrimaryColor,
                    )),
                SimpleTile(
                  title: "Logout",
                  lasticon: const Icon(
                    Icons.arrow_forward_ios,
                    color: kPrimaryColor,
                  ),
                  ontap: () {
                    //   changeScreenReplacement(context, const Login());
                  },
                  firsticon: const Icon(
                    Icons.power_settings_new,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
