import 'package:assetsync/bloc/global_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<GloablAuthCubit>(context);
    return Scaffold(
      body: Text(blocProvider.adminModel.toString()),
    );
  }
}
