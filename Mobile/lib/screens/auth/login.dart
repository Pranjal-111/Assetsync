import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:assetsync/database/admin_mysql_helper.dart';
import 'package:assetsync/database/district_mysql_helper.dart';
import 'package:assetsync/database/state_mysql_helper.dart';
import 'package:assetsync/database/subarea_mysql_helper.dart';
import 'package:assetsync/screens/admin/admin_dashboard.dart';
import 'package:assetsync/screens/auth/forgot_password.dart';
import 'package:assetsync/screens/district/district_dashboard.dart';
import 'package:assetsync/screens/state/state_dashboard.dart';
import 'package:assetsync/screens/sub_area/subarea_dashboard.dart';
import 'package:assetsync/services/change_screen.dart';
import 'package:assetsync/services/email_validator.dart';
import 'package:assetsync/utils/style.dart';
import 'package:assetsync/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<GloablAuthCubit>(context);
    String dropdown = "";

    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    final TextEditingController userName = TextEditingController();

    final TextEditingController password = TextEditingController();
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
                    "Login Yourself",
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
                              DropdownButtonFormField(
                                iconEnabledColor: kPrimaryColor,
                                style: const TextStyle(color: kPrimaryColor),
                                decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Select Authority',
                                  hintStyle:
                                      const TextStyle(color: kPrimaryColor),
                                  prefixIcon: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.person,
                                        color: kPrimaryColor,
                                      )),
                                ),
                                items: <String>[
                                  'Admin',
                                  'State Admin',
                                  'District Admin',
                                  'Sub-Area Admin'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  dropdown = value.toString();
                                },
                              ),
                              const SizedBox(
                                height: 15.0,
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
                                  labelText: 'Username',
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
                              TextFormField(
                                controller: password,
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
                                  labelText: 'Password',
                                  hintText: 'Enter Password',
                                  prefixIcon: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.lock,
                                        color: kPrimaryColor,
                                      )),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: (() {
                                        changeScreen(
                                            context, const ForgotPassword());
                                      }),
                                      child: const Text(
                                        'Forgot Password?',
                                        style: TextStyle(color: kPrimaryColor),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              RoundedButton(
                                  title: "Login",
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      progressbar(context);
                                      if (dropdown == "Admin") {
                                        await AdminMySQLHelper.login(context,
                                                userName.text, password.text)
                                            .then((adminModel) {
                                          if (adminModel != null) {
                                            blocProvider
                                                .loginSuperAdmin(adminModel);
                                            Navigator.pop(context);
                                            changeScreenReplacement(context,
                                                const AdminDashboard());
                                          }
                                        });
                                      } else if (dropdown == "State Admin") {
                                        await StateMySQLHelper.login(context,
                                                userName.text, password.text)
                                            .then((stateModel) {
                                          if (stateModel != null) {
                                            blocProvider
                                                .loginStateAdmin(stateModel);
                                            Navigator.pop(context);
                                            changeScreenReplacement(context,
                                                const StateDashboard());
                                          }
                                        });
                                      } else if (dropdown == "District Admin") {
                                        await DistrictMySqlHelper.login(context,
                                                userName.text, password.text)
                                            .then((districtModel) {
                                          if (districtModel != null) {
                                            blocProvider.loginDistrictAdmin(
                                                districtModel);
                                            Navigator.pop(context);
                                            changeScreenReplacement(context,
                                                const DistrictDashboard());
                                          }
                                        });
                                      } else if (dropdown == "Sub-Area Admin") {
                                        await SubAreaHelper.login(context,
                                                userName.text, password.text)
                                            .then((subareaModel) {
                                          if (subareaModel != null) {
                                            blocProvider.loginSubAreaAdmin(
                                                subareaModel);
                                            Navigator.pop(context);
                                            changeScreenReplacement(context,
                                                const SubAreaDashboard());
                                          }
                                        });
                                      } else {
                                        Navigator.pop(context);
                                        showDialog(
                                            context: context,
                                            builder: (builder) {
                                              return const AlertDialog(
                                                title: Text(
                                                    "Slelect from dropdown"),
                                              );
                                            });
                                      }
                                    }
                                  })
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
