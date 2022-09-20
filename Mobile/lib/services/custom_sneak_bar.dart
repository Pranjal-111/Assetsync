
  import 'package:flutter/material.dart';

showErrorMessage(BuildContext context, String error) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.withOpacity(0.7), content: Text(error)));
  }

  showSuccessMessage(BuildContext context, String error) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.withOpacity(0.7), content: Text(error)));
  }
